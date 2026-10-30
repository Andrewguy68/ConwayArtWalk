import 'package:cloud_firestore/cloud_firestore.dart';

// each pin is one item on the map
// can be a booth, live music, or an accessibility point
class Pin {
  final String id;

  // pin type could be booth, music, accessibility
  final String type;
  final String title;
  final String description;

  // pin location
  final double lat;
  final double long;

  // booth only
  final String? boothNum;
  // we want booths to point to the artit's page
  // final String? vendorId;

  // music only 
  // timestamp data type btw
  final DateTime? startTime; 
  final DateTime? endTime;

  const Pin({
    // the req parts on the pin
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.lat,
    required this.long,

    // non req bc not all are booths or music
    this.boothNum,
    // this.vendorId
    this.startTime,
    this.endTime,
  });

  // https://dart.dev/language/constructors#factory-constructors
  // this builds a pin from the firestore doc
  // [id] is the doc ID, seperate from the docs fields
  factory Pin.fromMap(String id, Map<String, dynamic> data) {
    return Pin(
      id: id,
      // type is defaulted to 'booth' if it doesn't have one
      type: data['type'] as String? ?? 'booth',
      // these two fallback into empty strings
      title: data['title'] as String? ?? '',
      description: data['description'] as String? ?? '',
      // no fallback bc we need a location for the pin
      lat: (data['lat'] as num).toDouble(),
      long: (data['long'] as num).toDouble(),
      boothNum: data['boothNum'] as String?,
      // vendorId: data['vendorId'] as String?,
      // firestore timestamp into Dart date
      startTime: (data['startTime'] as Timestamp?)?.toDate(),
      endTime: (data['endTime'] as Timestamp?)?.toDate(),
    );
  }

  // converts a pin to a map 
  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'title': title,
      'description': description,
      'lat': lat,
      'long': long,
      if (boothNum != null)'boothNum': boothNum,

      // https://stackoverflow.com/questions/66446873/flutter-convert-datetime-to-timestamp
      // want to convert dart to firebase
      if (startTime != null) 'startTime': Timestamp.fromDate(startTime!),
      if (endTime != null) 'endTime': Timestamp.fromDate(endTime!),
    };
  }
}