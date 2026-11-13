import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/color_scheme.dart';
import 'package:flutter_application_1/pages/map_page.dart';
import 'package:flutter_application_1/Widgets/button_setup.dart';
import 'package:flutter_application_1/pages/about_page.dart';
import 'package:flutter_application_1/pages/Main_menu.dart';
import 'package:flutter_application_1/pages/stamp_page.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  void _showMenu() {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Menu'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              NavStart().buildNavButton(dialogContext, 'Map!', MapSetup(), closePopupFirst: true, colorScheme: Scheme.primary),
              NavStart().buildNavButton(dialogContext, 'Event List!', EventPage(), closePopupFirst: true, colorScheme: Scheme.secondary),
              NavStart().buildNavButton(dialogContext, 'About Page!', AboutPage(), closePopupFirst: true, colorScheme: Scheme.tertiary),
              NavStart().buildNavButton(dialogContext, 'Stamps!', StampPage(), closePopupFirst: true, colorScheme: Scheme.secondary),
              NavStart().buildNavButton(dialogContext, 'Back to Menu!', MainMenu(), closePopupFirst: true, colorScheme: Scheme.tertiary),
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
        title: const Text('Events!', textAlign: TextAlign.center),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            tooltip: 'Menu',
            onPressed: _showMenu,
          ),
        ],
      ),
    );
  }
}
