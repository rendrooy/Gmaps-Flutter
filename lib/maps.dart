import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Maps extends StatefulWidget {
  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  final Set<Marker> _markers = {};
  final LatLng _currentPosition = LatLng(-6.303562, 107.024723);
  Set<Polyline> _polylines = HashSet<Polyline>();

  void _setPolylines() {
    List<LatLng> polylineLatLongs = List<LatLng>();
    polylineLatLongs.add(LatLng(-6.303562, 107.024723));
    polylineLatLongs.add(LatLng(-6.302461, 107.022283));

    _polylines.add(
      Polyline(
        polylineId: PolylineId("0"),
        color: Colors.blue,
        width: 3,
        points: polylineLatLongs,
      ),
    );
  }

  @override
  void initState() {
    _markers.add(Marker(
        markerId: MarkerId("0"),
        position: _currentPosition,
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(
          title: "Titik A",
        )));
    super.initState();
    _setPolylines();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Maps"),
        ),
        body: Stack(
          children: <Widget>[
            GoogleMap(
              mapType: MapType.satellite,
              initialCameraPosition: CameraPosition(
                target: _currentPosition,
                zoom: 16,
              ),
              markers: _markers,
              onTap: (position) {
                setState(() {
                  _markers.add(Marker(
                      markerId: MarkerId("1"),
                      icon: BitmapDescriptor.defaultMarker,
                      position: position,
                      infoWindow: InfoWindow(title: "Titik B")));
                });
              },
              onLongPress: (position) {
                setState(() {
                  _markers.add(Marker(
                      markerId: MarkerId("0"),
                      icon: BitmapDescriptor.defaultMarker,
                      position: position));
                });
              },
              polylines: _polylines,
            ),
            Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
              child: Text("By Narendra"),
            )
          ],
        ));
  }
}
