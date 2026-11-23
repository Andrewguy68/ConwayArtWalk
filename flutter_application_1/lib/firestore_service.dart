import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/models/pin.dart';
import 'package:flutter_application_1/models/about_info.dart';

// reading from firestore will happen here
// our screens will use this instead of firestore directly
class FirestoreService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  // reads every doc in the pins 
  Future<List<Pin>> getPins() async {
    final snapshot = await db.collection('pins').get();
    final pins = <Pin>[];
    for (final doc in snapshot.docs) {
      try {
        pins.add(Pin.fromMap(doc.id, doc.data()));
      }
      catch (e) {
        // if we have one bad pin, it shouldnt break the whole thing
        debugPrint('Skipping pin ${doc.id}: $e');
      }
    }
    return pins;
  }

  // reads the about page info from config/about
  // if the doc is missing or cant be read, the defaults are used
  Future<AboutInfo> getAboutInfo() async {
    try {
      final doc = await db.collection('config').doc('about').get();
      final data = doc.data();
      if (data == null) return AboutInfo.defaults;
      return AboutInfo.fromMap(data);
    }
    catch (e) {
      debugPrint('Could not load about info: $e');
      return AboutInfo.defaults;
    }
  }
}