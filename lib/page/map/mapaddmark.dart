import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'dart:async';

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
    allMarkers.add(
      Marker(
        markerId: MarkerId('myMarker'),
        draggable: false,
        onTap: (){
          print('tapnow');
        },
        position: LatLng(40.0,22.0),
      ),
    );
  }

  Completer<GoogleMapController> _controller = Completer();
  Future<LocationData> getCurrentLocation() async {
    Location location = Location();
      return await location.getLocation();
  }
  Future getlocationnow() async {
    LocationData currentLocation;
    final GoogleMapController controller = await _controller.future;
    currentLocation = await getCurrentLocation();
    print(currentLocation.latitude.toString()+' '+currentLocation.longitude.toString());
    controller.animateCamera(CameraUpdate.newCameraPosition(
    CameraPosition(
      target: LatLng(
          currentLocation.latitude,
          currentLocation.longitude),
      zoom: 16,
    )));
  }
  // Future _createMarkerImageFromAsset(BuildContext context) async {
  //   if (_markerIcon == null) {
  //     ImageConfiguration configuration = ImageConfiguration();
  //     BitmapDescriptor bmpd = await BitmapDescriptor.fromAssetImage(
  //         configuration, 'assets/images/imagemap/car.png');
  //     setState(() {
  //       _markerIcon = bmpd;
  //     });
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    var data = MediaQuery.of(context);
    // _createMarkerImageFromAsset(context);
    getlocationnow();
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