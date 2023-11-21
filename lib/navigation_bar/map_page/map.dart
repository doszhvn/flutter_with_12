// ignore_for_file: prefer_const_constructors, unused_import, implementation_imports, unnecessary_import, depend_on_referenced_packages, use_key_in_widget_constructors, prefer_final_fields, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return MapGoogle();
  }
}

class MapGoogle extends StatefulWidget {
  @override
  State<MapGoogle> createState() => MapGoogleState();
}

class MapGoogleState extends State<MapGoogle> {
  Completer<GoogleMapController> _controller = Completer();
  static const LatLng aLocation = LatLng(43.242243, 76.949704);
  static const LatLng bLocation = LatLng(43.238310, 76.885119);

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(43.2566700, 76.9286100),
    zoom: 13.4746,
  );

  static final Marker _kGooglePlexMarker = Marker(
      markerId: MarkerId('_kGooglePlex'),
      infoWindow: InfoWindow(title: "A позиция"),
      icon: BitmapDescriptor.defaultMarker,
      position: aLocation);

  static final Marker _kSecposMarker = Marker(
      markerId: MarkerId('_kSecposPlex'),
      infoWindow: InfoWindow(title: "B позиция"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      position: bLocation);

  static final Polyline _kPolyline = Polyline(
      polylineId: PolylineId('_kPolyline'),
      points: [aLocation, bLocation],
      width: 4,
      color: Colors.blueAccent);

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_new
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        markers: {_kGooglePlexMarker, _kSecposMarker},
        polylines: {_kPolyline},
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
