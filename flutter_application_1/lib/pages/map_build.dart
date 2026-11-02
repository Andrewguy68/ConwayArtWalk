import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
	

//Helpful class to create original buttons
class MapBuild {

	@override
	Widget build(BuildContext context) {
	  return FlutterMap(
	    options: MapOptions(
	      initialCenter: LatLng(35.0898, -92.4418), // Coordinates for Conway, Arkansas
	      initialZoom: 50,
	    ),
	    children: [
	      //TileLayer( // Bring your own tiles
	        //urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png', // For demonstration only
	        //userAgentPackageName: /*'com.example.app'*/, // Add your app identifier
	        // And many more recommended properties!
	      //),
	      //RichAttributionWidget( // Include a stylish prebuilt attribution widget that meets all requirments
	        //attributions: [
	          //TextSourceAttribution(
	            //'OpenStreetMap contributors',
	            //onTap: () => launchUrl(Uri.parse('https://openstreetmap.org/copyright')), // (external)
	          //),
	          // Also add images...
	        //],
	      //),
	    ],
	  );
	}
}
