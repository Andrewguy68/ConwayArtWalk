import 'package:flutter/material.dart';
import 'package:flutter_application_1/Event_List/event_page.dart';
import 'package:flutter_application_1/Widgets/button_setup.dart';
import 'package:flutter_application_1/About_Page/about_page.dart';
import 'package:flutter_application_1/Stamp_Page/stamp_page.dart';
import 'package:flutter_application_1/Start_Page/Main_menu.dart';

class MapSetup extends StatefulWidget {
  const MapSetup({super.key});

  @override
  State<MapSetup> createState() => _MapSetupState();
}

class _MapSetupState extends State<MapSetup> {
  @override
  Widget build(BuildContext context) {
    //builds the main menu widget
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Art Walk Map!',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NavStart().buildNavButton(context, 'Event List!', EventPage()),
            NavStart().buildNavButton(context, 'About Page!', AboutPage()),
            NavStart().buildNavButton(context, 'Stamps', StampPage()),
            NavStart().buildNavButton(context, 'Back to Menu!', MainMenu()),
          ],
        ),
      ),
    );
  }
}