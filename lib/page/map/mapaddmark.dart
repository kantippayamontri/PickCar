import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

import 'package:pickcar/datamanager.dart';
class Mapaddmark extends StatefulWidget {
  double zoom = 16;
  @override
  _MapaddmarkState createState() => _MapaddmarkState();
}

class _MapaddmarkState extends State<Mapaddmark> {
  BitmapDescriptor _markerIcon;
  List<Marker> allMarkers = [];
  @override
  void initState(){
    super.initState();
  }

  Completer<GoogleMapController> _controller = Completer();
  Future<LocationData> getCurrentLocation() async {
    Location location = Location();
      try{
        return await location.getLocation();
      } on PlatformException catch (e) {
        print(e.message);
        location = null;
    }
  }
  marker() async {
    LocationData currentLocation;
    currentLocation = await getCurrentLocation();
     allMarkers.add(
      Marker(
        icon: _markerIcon,
        markerId: MarkerId('myMarker'),
        draggable: true,
        // onTap: (){
        //   print('tapnow');
        // },
        position: LatLng(
          currentLocation.latitude,
          currentLocation.longitude),
      ),
    );
  }
  Future getlocationnow() async {
    LocationData currentLocation;
    final GoogleMapController controller = await _controller.future;
    currentLocation = await getCurrentLocation();
    // print(currentLocation.latitude.toString()+' '+currentLocation.longitude.toString());
    controller.animateCamera(CameraUpdate.newCameraPosition(
    CameraPosition(
      target: LatLng(
          currentLocation.latitude,
          currentLocation.longitude),
      zoom: 16,
    )));
  }
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
  }
  Future _createMarkerImageFromAsset(BuildContext context) async {
    if (_markerIcon == null) {
     final Uint8List markerIcon = await getBytesFromAsset('assets/images/imagemap/car.png', 150);
      BitmapDescriptor bmpd = BitmapDescriptor.fromBytes(markerIcon);
      setState(() {
        _markerIcon = bmpd;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    var data = MediaQuery.of(context);
    _createMarkerImageFromAsset(context);
    getlocationnow();
    marker();
    return  Scaffold(
      body: Container(
        width: data.size.width,
        height: data.size.height,
        child: Stack(
          children: <Widget>[
             GoogleMap(
              mapType: MapType.normal,
              zoomGesturesEnabled: true,
              initialCameraPosition: CameraPosition(
                target: LatLng(13.7650836, 100.5379664),
                zoom: widget.zoom,
              ),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              markers: Set.from(allMarkers),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getlocationnow,
        child: Icon(Icons.near_me),
      ),
    );
  }
}