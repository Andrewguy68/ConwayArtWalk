import 'package:flutter/material.dart';
import 'package:flutter_application_1/Start_Page/main_menu.dart';
import 'package:flutter_application_1/Widgets/button_setup.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    //builds the main menu widget
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Signup!',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NavStart().buildNavButton(context, 'Back to Menu!', MainMenu()),
          ],
        ),
      ),
    );
  }
}