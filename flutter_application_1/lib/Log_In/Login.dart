import 'package:flutter/material.dart';

import 'package:flutter_application_1/Authentication/auth_form.dart';
import 'package:flutter_application_1/Authentication/auth_scope.dart';
import 'package:flutter_application_1/Authentication/validators.dart';

class Login extends StatelessWidget {  //This Has been reused from my previous project (Hang out) which I have modified. 
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: Theme.of(context).textTheme.headlineLarge,
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: AuthForm(
            submitLabel: 'Log In',
            usernameValidator: Validators.loginUsername,
            passwordValidator: Validators.loginPassword,
            onSubmit: (username, password) =>
                AuthScope.of(context).logIn(username, password),
            footer: TextButton(
              onPressed: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute<void>(builder: (_) => const Signup()));
              },
              child: const Text('Create an account'),
            ),
          ),
        ),
      ),
    );
  }
}

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign Up',
          style: Theme.of(context).textTheme.headlineLarge,
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: AuthForm(
            submitLabel: 'Sign Up',
            usernameValidator: Validators.signupUsername,
            passwordValidator: Validators.signupPassword,
            onSubmit: (username, password) async {
              await AuthScope.of(context).signUp(username, password);
              if (!context.mounted) return;
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            footer: TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Back to login'),
            ),
          ),
        ),
      ),
    );
  }
}
