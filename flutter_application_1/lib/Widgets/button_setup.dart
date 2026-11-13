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
    Brightness mode = MediaQuery.platformBrightnessOf(context);
    WidgetStatePropertyAll<Color> primary;
    WidgetStatePropertyAll<Color> secondary;
    WidgetStatePropertyAll<Color> tertiary;
    WidgetStatePropertyAll<Color> onPrimary;
    WidgetStatePropertyAll<Color> onSecondary;
    WidgetStatePropertyAll<Color> onTertiary;
    
    if (mode == Brightness.light){
      primary = WidgetStatePropertyAll<Color>(Theme.of(context).colorScheme.primary);
      secondary = WidgetStatePropertyAll<Color>(Theme.of(context).colorScheme.secondary);
      tertiary = WidgetStatePropertyAll<Color>(Theme.of(context).colorScheme.tertiary);
      onPrimary = WidgetStatePropertyAll<Color>(Theme.of(context).colorScheme.onPrimary);
      onSecondary = WidgetStatePropertyAll<Color>(Theme.of(context).colorScheme.onSecondary);
      onTertiary = WidgetStatePropertyAll<Color>(Theme.of(context).colorScheme.onTertiary);
    }else{
      primary = WidgetStatePropertyAll<Color>(Theme.of(context).colorScheme.onPrimary);
      secondary = WidgetStatePropertyAll<Color>(Theme.of(context).colorScheme.onSecondary);
      tertiary = WidgetStatePropertyAll<Color>(Theme.of(context).colorScheme.onTertiary);
      onPrimary = WidgetStatePropertyAll<Color>(Theme.of(context).colorScheme.primary);
      onSecondary = WidgetStatePropertyAll<Color>(Theme.of(context).colorScheme.secondary);
      onTertiary = WidgetStatePropertyAll<Color>(Theme.of(context).colorScheme.tertiary);
    };

    if (colorScheme == Scheme.tertiary){
      return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: tertiary,
          foregroundColor: onTertiary,
        ),
        onPressed: () {
          // grab the navigator before the pop up closes
          final navigator = Navigator.of(context);
          if (closePopupFirst) navigator.pop();
          navigator.pushReplacement(
            MaterialPageRoute(builder: (context) => destination),
          );
        },
        key: Key(label),
        child: Text(label, style: Theme.of(context).textTheme.bodyLarge),
      ),
    );
    }else if (colorScheme == Scheme.secondary){
      return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: secondary,
          foregroundColor: onSecondary,
        ),
        onPressed: () {
          // grab the navigator before the pop up closes
          final navigator = Navigator.of(context);
          if (closePopupFirst) navigator.pop();
          navigator.pushReplacement(
            MaterialPageRoute(builder: (context) => destination),
          );
        },
        key: Key(label),
        child: Text(label, style: Theme.of(context).textTheme.bodyLarge),
      ),
    );
    }else{
      // Builds a navigation button widget which creates all of the needed elevated buttons for this code.
      var style = Theme.of(context).textTheme.bodyLarge;
      //WidgetStatePropertyAll<TextStyle>(TextStyle(color: Theme.of(context).colorScheme.onPrimary));
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: primary,
            foregroundColor: onPrimary,
          ),
          onPressed: () {
            // grab the navigator before the pop up closes
            final navigator = Navigator.of(context);
            if (closePopupFirst) navigator.pop();
            navigator.pushReplacement(
              MaterialPageRoute(builder: (context) => destination),
            );
          },
          key: Key(label),
          child: Text(label, style: style),
        ),
      );
    }
  }
}