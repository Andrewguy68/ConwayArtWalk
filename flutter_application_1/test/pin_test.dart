import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/models/pin.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Pin pinWith({double? showAtZoom, double? hideAtZoom}) => Pin(
        id: 'x',
        type: 'booth',
        title: 't',
        description: 'd',
        lat: 35.09,
        long: -92.44,
        showAtZoom: showAtZoom,
        hideAtZoom: hideAtZoom,
      );

  group('Pin.isVisibleAt', () {
    test('shows at every zoom when no range is set', () {
      final pin = pinWith();
      expect(pin.isVisibleAt(14), isTrue);
      expect(pin.isVisibleAt(18), isTrue);
    });

    test('showAtZoom is inclusive', () {
      final pin = pinWith(showAtZoom: 16);
      expect(pin.isVisibleAt(15.99), isFalse);
      expect(pin.isVisibleAt(16), isTrue);
    });

    test('hideAtZoom is exclusive', () {
      final pin = pinWith(hideAtZoom: 16);
      expect(pin.isVisibleAt(15.99), isTrue);
      expect(pin.isVisibleAt(16), isFalse);
    });

    test('a general and a detailed pin never show together', () {
      final general = pinWith(hideAtZoom: 16);
      final detailed = pinWith(showAtZoom: 16);
      for (final zoom in [14.0, 15.5, 15.99, 16.0, 17.0, 18.0]) {
        expect(general.isVisibleAt(zoom) != detailed.isVisibleAt(zoom), isTrue);
      }
    });
  });

  group('Pin.fromMap', () {
    final base = <String, dynamic>{
      'type': 'booth',
      'title': 'T',
      'description': 'D',
      'lat': 35.09,
      'long': -92.44,
    };

    test('reads zoom fields even when firestore returns ints', () {
      final pin = Pin.fromMap('a', {...base, 'showAtZoom': 16, 'hideAtZoom': 18});
      expect(pin.showAtZoom, 16.0);
      expect(pin.hideAtZoom, 18.0);
    });

    test('optional fields are null when missing', () {
      final pin = Pin.fromMap('a', base);
      expect(pin.boothNum, isNull);
      expect(pin.startTime, isNull);
      expect(pin.showAtZoom, isNull);
      expect(pin.hideAtZoom, isNull);
    });

    test('type defaults to booth', () {
      final data = {...base}..remove('type');
      expect(Pin.fromMap('a', data).type, 'booth');
    });

    test('whole-number coordinates still work', () {
      final pin = Pin.fromMap('a', {...base, 'lat': 35, 'long': -92});
      expect(pin.lat, 35.0);
      expect(pin.long, -92.0);
    });

    test('throws when a location is missing', () {
      final data = {...base}..remove('lat');
      expect(() => Pin.fromMap('a', data), throwsA(anything));
    });

    test('reads timestamps as DateTime', () {
      final when = DateTime(2026, 11, 14, 9, 30);
      final pin = Pin.fromMap('a', {...base, 'startTime': Timestamp.fromDate(when)});
      expect(pin.startTime, when);
    });
  });

  group('Pin.toMap', () {
    test('leaves out optional fields that are null', () {
      final map = pinWith().toMap();
      expect(map.containsKey('showAtZoom'), isFalse);
      expect(map.containsKey('boothNum'), isFalse);
    });

    test('round trips through fromMap', () {
      final original = pinWith(showAtZoom: 16, hideAtZoom: 18);
      final copy = Pin.fromMap('x', original.toMap());
      expect(copy.lat, original.lat);
      expect(copy.long, original.long);
      expect(copy.showAtZoom, original.showAtZoom);
      expect(copy.hideAtZoom, original.hideAtZoom);
    });
        test('writes zoom fields when they are set', () {
      final map = pinWith(showAtZoom: 16, hideAtZoom: 18).toMap();
      expect(map['showAtZoom'], 16.0);
      expect(map['hideAtZoom'], 18.0);
    });
  });
}