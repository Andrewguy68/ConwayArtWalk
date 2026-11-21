import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Authentication/auth_scope.dart';
import 'package:flutter_application_1/Log_In/Login.dart';
import 'package:flutter_application_1/pages/map_page.dart';

/// The map when a user is signed in, Login otherwise. It reacts when the state changes, so a
/// successful log in / sign up / sign out swaps the page without any manual
/// navigation, and a saved session survives app restarts.
class AuthGate extends StatefulWidget {  //This Has been reused from my previous project (Hang out) which I have modified. 
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  // created once so rebuilds don't re-subscribe to Firebase.
  late final Stream<User?> _authState;

  @override
  void initState() {
    super.initState();
    _authState = AuthScope.of(context).authState;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: _authState,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError) {
          return const Scaffold(
            body: Center(child: Text('Unable to check your sign-in status.')),
          );
        }
        return snapshot.data == null ? const Login() : const MapSetup();
      },
    );
  }
}
