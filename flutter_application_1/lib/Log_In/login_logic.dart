import 'package:flutter/material.dart';
import 'package:flutter_application_1/Start_Page/main_menu.dart';
import 'package:flutter_application_1/Widgets/button_setup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    //builds the main menu widget
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login!',
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
