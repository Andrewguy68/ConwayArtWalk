import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/models/pin.dart';

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
}