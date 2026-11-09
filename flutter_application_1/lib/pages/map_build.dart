import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_application_1/models/pin.dart';

// have to use OpenStreetMap's - https://www.openstreetmap.org/#map=5/38.01/-95.84
// if we move to another provider, change the url and the attribution 
const String kTileUrl = 'https://tile.openstreetmap.org/{z}/{x}/{y}.png';

// shows this app to the tile server
const String kUserAgent = 'ConwayArtWalk-StudentApp';

// starting settings to view artwalk
final LatLng kMapCenter = LatLng(35.0898, -92.4418);
const double kInitialZoom = 15;
const double kMinZoom = 14;
const double kMaxZoom = 18;

final LatLngBounds kMapBounds = LatLngBounds(
  // SW and NE corner
  LatLng(35.075, -92.460), 
  LatLng(35.105, -92.425), 
);
	
// map building
class MapBuild {
  // pins are optional, so old calls will still work
  Widget build(BuildContext context, {List<Pin> pins = const []}) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: kMapCenter,
        initialZoom: kInitialZoom,
        minZoom: kMinZoom,
        maxZoom: kMaxZoom,
        cameraConstraint: CameraConstraint.contain(bounds: kMapBounds),
      ),
      children: [
        TileLayer(
          urlTemplate: kTileUrl,
          userAgentPackageName: kUserAgent,
        ),
        // layers draw in order, so the pins/markers will be drawn on top of the tiles
        MarkerLayer(
          markers: pins.map(_markerFor).toList(),
        ),
        RichAttributionWidget(
          attributions: [
            TextSourceAttribution('OpenStreetMap contributors'),
          ],
        ),
      ],
    );
  }

  // turns on of our pins into a marker on the map
  Marker _markerFor(Pin pin) {
    return Marker(
      point: LatLng(pin.lat, pin.long),
      width: 40,
      height: 40,
      // the tip of the pin is on the coords
      alignment: Alignment.topCenter,
      child: Icon(
        Icons.location_pin,
        size: 40,
        color: _colorFor(pin.type),
      ),
    );
  }

  // the colors of the pins
  // change to fit the colors we want
  Color _colorFor(String type) {
    switch (type) {
      case 'music':
        return Colors.purple;
      case 'accessibility':
        return Colors.blue;
      default:
        // default is red, which is an art booth
        return Colors.red;
    }
  }
}