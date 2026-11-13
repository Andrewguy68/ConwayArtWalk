import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/color_scheme.dart';
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
        title: Text('Menu', style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center),
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
            child: Text('Close', style: Theme.of(context).textTheme.bodyLarge),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About!', textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineLarge),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            tooltip: 'Menu',
            onPressed: _showMenu,
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1d1abc),
              Color(0xFF63a6f2),
            ],
          ),
        ),
        child: DefaultTextStyle(
          style: Theme.of(context).textTheme.headlineMedium ?? const TextStyle(),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Image.asset('assets/ArtWalkLogo-Dark.png', height: 160)),
                  Center(
                    child: Text(
                      'About us!SSS', style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}