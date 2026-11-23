import 'package:flutter/material.dart';
import 'package:flutter_application_1/Artists/manage_profile.dart';
import 'package:flutter_application_1/Artists/contact_us.dart';

class ArtistPage extends StatefulWidget {
  const ArtistPage({super.key});

  @override
  State<ArtistPage> createState() => _ArtistPageState();
}

class _ArtistPageState extends State<ArtistPage> {
  void _showArtistMenu() {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('Menu', style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile Management',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            tooltip: 'Menu',
            onPressed: _showArtistMenu,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 24),
            Image.asset(
              'assets/ArtWalkLogo-Dark.png',
              width: 400,
              height: 400,
            ),
            Text(
              'Welcome to the Artist Page! Here you can manage your profile, check in to your booth, and communicate any issues or questions you have!',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to the profile management page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfileManagementPage()),
                );
              },
              child: const Text('Manage Profile'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to the event page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ContactPage()),
                );
              },
              child: const Text('Contact Us'),
            ),
          ],
        ),
      ),
    );
  }
}