import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/color_scheme.dart';
import 'package:flutter_application_1/pages/map_page.dart';
import 'package:flutter_application_1/Widgets/button_setup.dart';
import 'package:flutter_application_1/pages/event_page.dart';
import 'package:flutter_application_1/pages/Main_menu.dart';
import 'package:flutter_application_1/pages/stamp_page.dart';
import 'package:flutter_application_1/models/about_info.dart';
import 'package:flutter_application_1/firestore_service.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  void _showMenu() {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('Menu', style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              NavStart().buildNavButton(dialogContext, 'Map!', MapSetup(), Icons.map_outlined, closePopupFirst: true, colorScheme: Scheme.primary),
              NavStart().buildNavButton(dialogContext, 'Event List!', EventPage(), Icons.abc, closePopupFirst: true, colorScheme: Scheme.secondary),
              NavStart().buildNavButton(dialogContext, 'About Page!', AboutPage(), Icons.abc, closePopupFirst: true, colorScheme: Scheme.tertiary),
              NavStart().buildNavButton(dialogContext, 'Stamps!', StampPage(), Icons.abc, closePopupFirst: true, colorScheme: Scheme.secondary),
              NavStart().buildNavButton(dialogContext, 'Back to Menu!', MainMenu(), Icons.abc, closePopupFirst: true, colorScheme: Scheme.tertiary),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text('Close', style: Theme.of(context).textTheme.bodyLarge),
          ),
        ],
      ),
    );
  }


  // loads the about info from firestore once when the page opens
  late final Future<AboutInfo> _aboutFuture = FirestoreService().getAboutInfo();

  // opens a link, email, or phone number outside the app
  Future<void> _open(String url) async {
    final uri = Uri.tryParse(url);
    // only web links, email, and phone numbers are allowed
    final allowed = uri != null && ['https', 'mailto', 'tel'].contains(uri.scheme);
    var opened = false;
    if (allowed) {
      try {
        opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
      catch (_) {}
    }
    if (!opened && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open that link.', style: Theme.of(context).textTheme.bodyLarge)),
      );
    }
  }

  // keeps only the numbers so (501) 232-1133 works as a phone link
  String _digits(String phone) => phone.replaceAll(RegExp(r'[^0-9+]'), '');

  // colored section label (Geronide), same as the events page
  Widget _section(String name, Color color, {Color textColor = Colors.white}) {
    return Container(
      margin: const EdgeInsets.only(top: 24, bottom: 4),
      padding: const EdgeInsets.fromLTRB(24, 10, 28, 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.horizontal(right: Radius.circular(28)),
      ),
      child: Text(
        name.toUpperCase(),
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
          fontSize: 20,
          fontWeight: FontWeight.normal,
          color: textColor,
        ),
      ),
    );
  }

  // paragraph text (Sanchez)
  Widget _text(String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 4),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Colors.white,
          height: 1.4,
        ),
      ),
    );
  }
  // an icon with a line of info, that isnt appable
  Widget _info(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 6, 24, 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 22, color: Colors.white),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // an icon with a tappable line that opens the link
  Widget _link(IconData icon, String label, String url) {
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: TextButton.icon(
        style: TextButton.styleFrom(foregroundColor: Colors.white),
        onPressed: () => _open(url),
        icon: Icon(icon, size: 22),
        label: Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
        ),
      ),
    );
  }

  // a text button that opens a social page, same look as the survey button on the map
  Widget _socialButton(String label, String url) {
    return TextButton(
      style: TextButton.styleFrom(foregroundColor: Colors.white),
      onPressed: () => _open(url),
      child: Text(label, style: Theme.of(context).textTheme.bodyLarge),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About!', textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineLarge),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            tooltip: 'Menu',
            onPressed: _showMenu,
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1d1abc),
              Color(0xFF63a6f2),
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
                      'About the Conway Art Walk!', style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.white), textAlign: TextAlign.center,
                    ),
                  ),

                  // shows the defaults right away, then the firestore info once it loads
                  FutureBuilder<AboutInfo>(
                    future: _aboutFuture,
                    builder: (context, snapshot) {
                      final info = snapshot.data ?? AboutInfo.defaults;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _section('Who We Are', const Color(0xFF627d4e)),
                          _text(info.blurb),

                          _section('Contact Us', const Color(0xFF63a6f2), textColor: Colors.black),
                          _info(Icons.place, info.address),
                          _info(Icons.access_time, info.hours),
                          _link(Icons.email, info.email, 'mailto:${info.email}'),
                          _link(Icons.phone, info.phone, 'tel:${_digits(info.phone)}'),

                          _section('Follow Us', const Color(0xFFffb809), textColor: Colors.black),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              children: [
                                _socialButton('Instagram', info.instagram),
                                _socialButton('Facebook', info.facebook),
                                ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}