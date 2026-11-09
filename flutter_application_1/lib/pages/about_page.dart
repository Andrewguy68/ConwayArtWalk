import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/map_page.dart';
import 'package:flutter_application_1/Widgets/button_setup.dart';
import 'package:flutter_application_1/pages/event_page.dart';
import 'package:flutter_application_1/pages/Main_menu.dart';
import 'package:flutter_application_1/pages/stamp_page.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
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
        title: const Text('About!', textAlign: TextAlign.center),
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