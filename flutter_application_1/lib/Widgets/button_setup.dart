import 'package:flutter/material.dart';

//Helpful class to create original buttons
class NavStart {
  Widget buildNavButton(
    BuildContext context,
    String label,
    Widget destination, {
    bool closePopupFirst = false,
  }) {
    // Builds a navigation button widget which creates all of the needed elevated buttons for this code.
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: () {
          // grab the navigator before the pop up closes
          final navigator = Navigator.of(context);
          if (closePopupFirst) navigator.pop();
          navigator.pushReplacement(
            MaterialPageRoute(builder: (context) => destination),
          );
        },
        key: Key(label),
        child: Text(label),
      ),
    );
  }
}