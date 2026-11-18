import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/color_scheme.dart';
import 'package:flutter_application_1/pages/main_menu.dart';
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
          style: Theme.of(context).textTheme.headlineLarge
        ),
        centerTitle: true,
      ),
      body:  Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFee5033),
              Color(0xFFffb809),
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
                      'Schedule of Events!', style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  NavStart().buildNavButton(context, 'Back to Menu!', MainMenu(), colorScheme: Scheme.secondary),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}