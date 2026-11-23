import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/map_page.dart';
import 'package:flutter_application_1/auth_gate.dart';
import 'package:flutter_application_1/Authentication/auth_scope.dart';
import 'package:flutter_application_1/Authentication/auth_service.dart';

class MainMenu extends StatefulWidget { //sets up the main menu page!
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  bool _OpenMap = false;

  Future<void> _openMapAsGuest() async {
    if (_OpenMap) return;
    setState(() => _OpenMap = true);
    try {
      await AuthScope.of(context).signInAsGuest();
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(builder: (_) => const MapSetup()),
      );
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(authErrorMessage(error))));
    } finally {
      if (mounted) setState(() => _OpenMap = false);
    }
  }

  Future<void> _openLogin() async {
    final user = AuthScope.of(context).currentUser;
    if (user != null) {
      await AuthScope.of(context).logOut();
    }
    if (!mounted) return;
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (_) => const AuthGate()));
  }

  @override
  Widget build(BuildContext context) {
    //builds the main menu widget
    Brightness mode = MediaQuery.platformBrightnessOf(context);
    Color primary;
    Color secondary;
    Color tertiary;
    Color iconColor;
    if (mode == Brightness.light){
      primary = Theme.of(context).colorScheme.primary;
      secondary = Theme.of(context).colorScheme.secondary;
      tertiary = Theme.of(context).colorScheme.tertiary;
      iconColor = Colors.black;
    }else{
      primary = Theme.of(context).colorScheme.onPrimary;
      secondary = Theme.of(context).colorScheme.onSecondary;
      tertiary = Theme.of(context).colorScheme.onTertiary;
      iconColor = Colors.white;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Main Menu!',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        centerTitle: true,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/ArtWalkLogo-Dark.png', width: 400, height: 400),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: ElevatedButton(
                key: const Key('Map'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  iconColor:iconColor,
                ),
                onPressed: _OpenMap ? null : _openMapAsGuest,
                child: _OpenMap
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Row(
                        spacing: 10,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.map_outlined),
                          Text('Map', style: Theme.of(context).textTheme.bodyLarge)
                        ],
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: ElevatedButton(
                key: const Key('Login Page'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: secondary,
                  iconColor:iconColor,
                ),
                onPressed: _openLogin,
                child: Row(
                  spacing: 10,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.account_circle),
                    Text('Login', style: Theme.of(context).textTheme.bodyLarge)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
