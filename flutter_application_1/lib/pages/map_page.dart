import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/color_scheme.dart';
import 'package:flutter_application_1/pages/event_page.dart';
import 'package:flutter_application_1/Widgets/button_setup.dart';
import 'package:flutter_application_1/pages/about_page.dart';
import 'package:flutter_application_1/pages/stamp_page.dart';
import 'package:flutter_application_1/pages/Main_menu.dart';
import 'package:flutter_application_1/pages/map_build.dart';
import 'package:flutter_application_1/models/pin.dart';
import 'package:flutter_application_1/firestore_service.dart';
import 'package:url_launcher/url_launcher.dart';

class MapSetup extends StatefulWidget {
  const MapSetup({super.key});

  @override
  State<MapSetup> createState() => _MapSetupState();
}

class _MapSetupState extends State<MapSetup> {
  // pins will now come from firestore and they will replace the hardcoded ones
  // late final means it reads once
  late final Future<List<Pin>>_pinsFuture = FirestoreService().getPins();
  // which pin types are showing
  final Set<String> _visibleTypes = {...kAllPinTypes};

  @override
  void initState() { //https://api.flutter.dev/flutter/scheduler/SchedulerBinding/addPostFrameCallback.html 
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _showSurvey();
    });
  }

  // Opens a popup containing the navigation buttons.
  void _showMenu() {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('Menu', style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              NavStart().buildNavButton(dialogContext, 'Map!', MapSetup(), Icons.map_outlined, closePopupFirst: true, colorScheme: Scheme.primary),
              NavStart().buildNavButton(dialogContext, 'Event List!', EventPage(), Icons.abc, closePopupFirst: true, colorScheme: Scheme.secondary),
              NavStart().buildNavButton(dialogContext, 'About Page!', AboutPage(), Icons.abc, closePopupFirst: true, colorScheme: Scheme.tertiary),
              NavStart().buildNavButton(dialogContext, 'Stamps!', StampPage(), Icons.abc, closePopupFirst: true, colorScheme: Scheme.secondary),
              NavStart().buildNavButton(dialogContext, 'Back to Menu!', MainMenu(), Icons.abc, closePopupFirst: true, colorScheme: Scheme.tertiary),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text('Close', style: Theme.of(context).textTheme.bodyLarge,),
          ),
        ],
      ),
    );
  }

  void _showSurvey() {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(
          'Please take our survey!',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        content: Text('We would like to hear your feedback about the art walk!', style: Theme.of(context).textTheme.bodyLarge,),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              await launchUrl(
                Uri.parse('https://form.jotform.com/260534978822063'),
              );
            },
            child: Text('Take Survey!', style: Theme.of(context).textTheme.bodyLarge,),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text('Close', style: Theme.of(context).textTheme.bodyLarge,),
          ),
          
        ],
      ),
    );
  }

// short label for the type shown in the details
String _typeLabel(String type) {
  switch (type) {
    case 'music':
      return 'Live music';
    case 'accessibility':
      return 'Accessibility';
    default:
      return 'Art booth';
  }
}

// 9:30 AM style time from a DateTime
String _formatTime(DateTime time) {
  return TimeOfDay.fromDateTime(time).format(context);
}

// pops up the details when a pin is tapped
void _showPinDetails(Pin pin) {
  final textTheme = Theme.of(context).textTheme;
  showModalBottomSheet(
    context: context,
    builder: (sheetContext) => SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(pin.title, style: textTheme.headlineMedium),
            const SizedBox(height: 4),
            Text(
              _typeLabel(pin.type),
              style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            if (pin.description.isNotEmpty)
              Text(pin.description, style: textTheme.bodyLarge),
            if (pin.boothNum != null)
              Text('Booth ${pin.boothNum}', style: textTheme.bodyLarge),
            if (pin.startTime != null && pin.endTime != null)
              Text(
                '${_formatTime(pin.startTime!)} - ${_formatTime(pin.endTime!)}',
                style: textTheme.bodyLarge,
              ),
          ],
        ),
      ),
    ),
  );
}

  // row of widgets to adjust visibility
  Widget _filterBar() {
    const labels = {
      'booth': 'Booths',
      'music': 'Music',
      'accessibility': 'Accessibility',
    };
    return Wrap(
      spacing: 8,
      children: [
        for (final entry in labels.entries)
          FilterChip(
            label: Text(entry.value, style: Theme.of(context).textTheme.bodyLarge),
            selected: _visibleTypes.contains(entry.key),
            onSelected: (isOn) {
              setState(() {
                if (isOn) {
                  _visibleTypes.add(entry.key);
                } else {
                  _visibleTypes.remove(entry.key);
                }
              });
            },
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Art Walk Map!', textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineLarge),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            tooltip: 'Menu',
            onPressed: _showMenu,
          ),
        ],
      ),
      // map shows first, then pins
      body: FutureBuilder<List<Pin>>(
        future: _pinsFuture,
        builder: (context, snapshot) {
          // errors
          if (snapshot.hasError) {
            debugPrint('Could not load pins: ${snapshot.error}');
          }
          final pins = snapshot.data ?? const <Pin>[];
          return Stack(
            fit: StackFit.expand,
            children: [
              // add to show the details too
              MapBuild().build(context, pins: pins, visibleTypes: _visibleTypes, onPinTap: _showPinDetails),
              Positioned(top: 8, left: 8, right: 8, child: _filterBar()),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showSurvey,
        tooltip: 'Please take our survey!',
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.question_answer),
      ),
    );
  }
}