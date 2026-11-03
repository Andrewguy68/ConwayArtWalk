import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/map_build.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Map test')),
        body: Builder(
          builder: (context) => MapBuild().build(context),
        ),
      ),
    ),
  );
}