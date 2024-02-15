import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  final LocationData userLocation;
  MapPage({Key key, this.userLocation}) : super(key: key);
  @override
  
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();

//custom iconn maker
  BitmapDescriptor _locIcon;
  final Set<Marker> listMarkers = {};
//create cistom marker
Future<BitmapDescriptor> _setLocCustomMarker() async {
  BitmapDescriptor bIcon = await BitmapDescriptor.fromAssetImage(
    ImageConfiguration(devicePixelRatio:  2.5), 'images/home-map-pin.png'
  );
  return bIcon;
} 

  @override
  void initState() {
    super.initState();

    _setLocCustomMarker().then((value) {
      _locIcon = value;
      _locIcon != null
        ? setState(() {
          listMarkers.add(Marker(
            markerId: MarkerId('1'),
            position: LatLng(widget.userLocation.latitude,
              widget.userLocation.longitude),
              infoWindow: InfoWindow(title: 'Current Location'),
              icon: _locIcon));
        })
        : DoNothingAction();
    });
  }
  Widget build(BuildContext context) {
    CameraPosition _currentPos = CameraPosition(
      bearing: 0.0, //compass direction – 90 degree orients east up
      target:
          LatLng(widget.userLocation.latitude, widget.userLocation.longitude),
      tilt: 60.0,
//title angle – 60 degree looks ahead towards the horizon
      zoom: 17, //zoom level – a middle value of 11 shows city-level
    );
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        markers : Set.from(listMarkers),
        myLocationEnabled: true,
        initialCameraPosition: _currentPos,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
