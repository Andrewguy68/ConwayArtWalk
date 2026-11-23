import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/map_page.dart';
import 'package:flutter_application_1/Widgets/button_setup.dart';
import 'package:flutter_application_1/pages/about_page.dart';
import 'package:flutter_application_1/pages/Main_menu.dart';
import 'package:flutter_application_1/pages/stamp_page.dart';
import 'package:flutter_application_1/models/color_scheme.dart';

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
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _section(String name, Color color, {Color textColor = Colors.white}) {
    return Container(
      margin: const EdgeInsets.only(top: 24, bottom: 4),
      padding: const EdgeInsets.fromLTRB(24, 10, 28, 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.horizontal(right: Radius.circular(28)),
      ),
      child: Text(
        name.toUpperCase(),
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
          fontSize: 20,
          fontWeight: FontWeight.normal,
          color: textColor,
        ), 
        ),
    );
  }

  Widget _venue(String name) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 2),
      child: Text(
        name,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
          fontSize: 28,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _event(String title, {String? time}) {
    final parts = title.split('*');
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 4, 24, 4),
      child: Text.rich(
        TextSpan(
          children: [
            const TextSpan(text: '• '),
            if (time != null)
              TextSpan(
                text: '$time  ',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            for (var i = 0; i < parts.length; i++)
              TextSpan(
                text: parts[i],
                style: i.isOdd ? const TextStyle(fontStyle: FontStyle.italic) : null,
              )

          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Events!', textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineLarge),
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
                      'Schedule of Events',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontSize: 28,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  _section('Simon Park', const Color(0xFF627d4e)),
                  _venue('Kris Allen Stage'),
                  _event('The Stompin\' Crows', time: '5:00 - 6:15'),
                  _event('La\'Chaz Holloway', time: '6:30 - 8:00'),


                  _section('Conductor', const Color(0xFF63a6f2), textColor: Colors.black),
                  _venue('Arnold Innovations Center'),
                  _event('Exhibiting Artists\' Booths'),
                  _event('Cardboard Gingerbread Houses'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
