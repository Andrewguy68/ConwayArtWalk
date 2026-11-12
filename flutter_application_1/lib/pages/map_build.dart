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
final LatLng kMapCenter = LatLng(35.0908, -92.4402);
const double kInitialZoom = 17;
const double kMinZoom = 17;
const double kMaxZoom = 20;

final LatLngBounds kMapBounds = LatLngBounds(
  // SW and NE corner
  LatLng(35.0885, -92.4420),
  LatLng(35.0930, -92.4385),
);

// every pin type used for the show/hide filter
const Set<String> kAllPinTypes = {'booth', 'music', 'accessibility'};

// pin size in pixels, size changing with zooming
// we can adjust so it works nicely
const double kPinSizeZoomedOut = 48;
const double kPinSizeZoomedIn = 28;
	
// map building
class MapBuild {
  // pins are optional, so old calls will still work
  // visibleTypes is which pin types show up
  Widget build(
    BuildContext context, {
    List<Pin> pins = const [],
    Set<String> visibleTypes = kAllPinTypes,
  }) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: kMapCenter,
        initialZoom: kInitialZoom,
        minZoom: kMinZoom,
        maxZoom: kMaxZoom,
        cameraConstraint: CameraConstraint.containCenter(bounds: kMapBounds),
      ),
      children: [
        TileLayer(
          urlTemplate: kTileUrl,
          userAgentPackageName: kUserAgent,
        ),
        // layers draw in order, so the pins/markers will be drawn on top of the tiles
        // pinLayer decides which pins show at the current zoom
        _PinLayer(pins: pins, visibleTypes: visibleTypes),
        RichAttributionWidget(
          attributions: [
            TextSourceAttribution('OpenStreetMap contributors'),
          ],
        ),
      ],
    );
  }
}

// MapCamera.of(context) makes this rebuild whenever the map moves or zooms.
class _PinLayer extends StatelessWidget {
  final List<Pin> pins;
  final Set<String> visibleTypes;

  const _PinLayer({required this.pins, required this.visibleTypes});

  @override
  Widget build(BuildContext context) {
    final zoom = MapCamera.of(context).zoom;
    // temp, shows the zoom in the console to check the numbers
    // debugPrint('zoom: $zoom');

    // keeps filters and zoom level
    final shown = pins.where(
      (pin) => visibleTypes.contains(pin.type) && pin.isVisibleAt(zoom),
    );

    return MarkerLayer(
      markers: shown.map((pin) => _markerFor(pin, zoom)).toList(),
    );
  }
}

// turns one of our pins into a marker on the map
Marker _markerFor(Pin pin, double zoom) {
  final size = _pinSizeAt(zoom);
  return Marker(
    point: LatLng(pin.lat, pin.long),
    width: size,
    height: size,
    // the tip of the pin is on the coords
    alignment: Alignment.topCenter,
    child: Icon(
      Icons.location_pin,
      size: size,
      color: _colorFor(pin.type),
    ),
  );
}

// pin size shrinks as you zoom in
double _pinSizeAt(double zoom) {
  // 0 when fully zoomed out, 1 when fully zoomed in
  final t = ((zoom - kMinZoom) / (kMaxZoom - kMinZoom)).clamp(0.0, 1.0).toDouble();
  return kPinSizeZoomedOut + (kPinSizeZoomedIn - kPinSizeZoomedOut) * t;
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
    // maybe add a 4th color for the creative cove above the default
  }
}