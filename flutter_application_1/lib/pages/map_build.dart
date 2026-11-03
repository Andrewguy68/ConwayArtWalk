import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

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
  Widget build(BuildContext context) {
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
        RichAttributionWidget(
          attributions: [
            TextSourceAttribution('OpenStreetMap contributors'),
          ],
        ),
      ],
    );
  }
}