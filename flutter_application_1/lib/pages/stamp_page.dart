import 'package:flutter/material.dart';
import 'package:flutter_application_1/Widgets/button_setup.dart';
import 'package:flutter_application_1/models/color_scheme.dart';
import 'package:flutter_application_1/pages/event_page.dart';
import 'package:flutter_application_1/pages/about_page.dart';
import 'package:flutter_application_1/pages/map_page.dart';
import 'package:flutter_application_1/pages/Main_menu.dart';
import 'package:qr_code_dart_scan/qr_code_dart_scan.dart';

class StampPage extends StatefulWidget {
  const StampPage({super.key});

  @override
  State<StampPage> createState() => _StampPageState();
}

class _StampPageState extends State<StampPage> {
  String? _scanResult;
  String? _cameraError;

  void _handleCameraError(String error) {
    if (!mounted || error == _cameraError) return;
    setState(() {
      _cameraError = error;
    });
  }

  void _handleCapture(ScanResult result) {
    if (!mounted || result.text.isEmpty || result.text == _scanResult) return;
    setState(() {
      _scanResult = result.text;
      _cameraError = null;
    });
  }

  void _showMenu() {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('Menu', style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              NavStart().buildNavButton(dialogContext, 'Map!', MapSetup(), closePopupFirst: true, colorScheme: Scheme.primary),
              NavStart().buildNavButton(dialogContext, 'Event List!', EventPage(), closePopupFirst: true, colorScheme: Scheme.secondary),
              NavStart().buildNavButton(dialogContext, 'About Page!', AboutPage(), closePopupFirst: true, colorScheme: Scheme.tertiary),
              NavStart().buildNavButton(dialogContext, 'Stamps!', StampPage(), closePopupFirst: true, colorScheme: Scheme.secondary),
              NavStart().buildNavButton(dialogContext, 'Back to Menu!', MainMenu(), closePopupFirst: true, colorScheme: Scheme.tertiary),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stamps', textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineLarge),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            tooltip: 'Menu',
            onPressed: _showMenu,
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          QRCodeDartScanView(
            onCameraError: _handleCameraError,
            typeScan: TypeScan.live,
            onCapture: _handleCapture,
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Card(
                margin: const EdgeInsets.all(16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _cameraError == null
                            ? (_scanResult == null
                                ? 'Find a QR code to scan'
                                : 'QR code detected')
                            : 'Camera error: $_cameraError',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      if (_scanResult != null) ...[
                        const SizedBox(height: 8),
                        SelectableText(_scanResult!),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}