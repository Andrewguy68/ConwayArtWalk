import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/event_page.dart';
import 'package:flutter_application_1/Widgets/button_setup.dart';
import 'package:flutter_application_1/pages/about_page.dart';
import 'package:flutter_application_1/pages/stamp_page.dart';
import 'package:flutter_application_1/pages/Main_menu.dart';
import 'package:flutter_application_1/pages/map_build.dart';
import 'package:flutter_application_1/models/pin.dart';

class MapSetup extends StatefulWidget {
  const MapSetup({super.key});

  @override
  State<MapSetup> createState() => _MapSetupState();
}

class _MapSetupState extends State<MapSetup> {
  // example pins for testing
  final List<Pin> _testPins = const [
     Pin(id: 't1', type: 'booth', title: 'Test Booth', description: 'Sample', lat: 35.0910, long: -92.4395, boothNum: '12'),
     Pin(id: 't2', type: 'music', title: 'Test Stage', description: 'Sample', lat: 35.0880, long: -92.4440),
     Pin(id: 't3', type: 'accessibility', title: 'Test Access Point', description: 'Sample', lat: 35.0925, long: -92.4425),
   ];
  // Opens a popup containing the navigation buttons.
  void _showMenu() {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Menu'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              NavStart().buildNavButton(dialogContext, 'Map!', MapSetup(), closePopupFirst: true),
              NavStart().buildNavButton(dialogContext, 'Event List!', EventPage(), closePopupFirst: true),
              NavStart().buildNavButton(dialogContext, 'About Page!', AboutPage(), closePopupFirst: true),
              NavStart().buildNavButton(dialogContext, 'Stamps!', StampPage(), closePopupFirst: true),
              NavStart().buildNavButton(dialogContext, 'Back to Menu!', MainMenu(), closePopupFirst: true),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Art Walk Map!', textAlign: TextAlign.center),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            tooltip: 'Menu',
            onPressed: _showMenu,
          ),
        ],
      ),
      body: MapBuild().build(context, pins: _testPins),
    );
  }
}