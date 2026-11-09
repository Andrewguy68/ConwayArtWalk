import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/Main_menu.dart';
import 'package:firebase_core/firebase_core.dart'; 
import 'firebase_options.dart';

// async so Firebase finishes starting before the app builds
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {  //Builds the main app widget
    //Fonts: Geronide Regular, Campground, Jimmy Script, Sanchez
    //Colors: #1d1abc, #ee5033, #ffb809, #f8a9a4, #eae9e2, #000000, #627d4e, #63a6f2
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      brightness: MediaQuery.platformBrightnessOf(context),
      seedColor: Color(0xFF1d1abc),
      primary: Color(0xFFee5033),
      secondary: Color(0xFFffb809),
      tertiary: Color(0xFF627d4e)
    );
    return MaterialApp(
      title: 'Conway Art Walk!',
      theme: ThemeData(
        colorScheme: colorScheme,
        useMaterial3: true,
      ),
      home: const MainMenu(),
    );
  }
}
