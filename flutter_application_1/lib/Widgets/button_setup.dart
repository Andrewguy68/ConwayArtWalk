import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/color_scheme.dart';

//Helpful class to create original buttons
class NavStart {
  Widget buildNavButton(
    BuildContext context,
    String label,
    Widget destination, {
    bool closePopupFirst = false,
    Scheme colorScheme = Scheme.primary,}){
    if (colorScheme == Scheme.tertiary){
      return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: () {
          // grab the navigator before the pop up closes
          final navigator = Navigator.of(context);
          Theme.of(context).colorScheme.tertiary;
          if (closePopupFirst) navigator.pop();
          navigator.pushReplacement(
            MaterialPageRoute(builder: (context) => destination),
          );
        },
        key: Key(label),
        child: Text(label),
      ),
    );
    }else if (colorScheme == Scheme.secondary){
      return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: () {
          // grab the navigator before the pop up closes
          final navigator = Navigator.of(context);
          Theme.of(context).colorScheme.secondary;
          if (closePopupFirst) navigator.pop();
          navigator.pushReplacement(
            MaterialPageRoute(builder: (context) => destination),
          );
        },
        key: Key(label),
        child: Text(label),
      ),
    );
    }else{
      // Builds a navigation button widget which creates all of the needed elevated buttons for this code.
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: ElevatedButton(
          onPressed: () {
            // grab the navigator before the pop up closes
            final navigator = Navigator.of(context);
            Theme.of(context).colorScheme.primary;
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
}