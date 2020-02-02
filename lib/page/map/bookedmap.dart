import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

import 'package:pickcar/datamanager.dart';
import 'package:pickcar/models/boxlocation.dart';
import 'package:url_launcher/url_launcher.dart';

class Bookedmap extends StatefulWidget {
  double zoom = 14;
  double latitude = 18.802587;
  double logtitude = 98.951556;
  double latitudemark;
  double logtitudemark;
  List box = [];
  int i=0;
  @override
  _BookedmapState createState() => _BookedmapState();
}

class _BookedmapState extends State<Bookedmap> {
  BitmapDescriptor _markerIcon;
  List<Marker> allMarkers = [];
  @override
  void initState(){
    DataFetch.checkhavedata =0;
    Datamanager.boxlocationshow = null;
    Datasearch.boxlocationname = [];
    Datasearch.boxlocationlatitude = [];
    Datasearch.boxlocationlogtitude = [];
    Datasearch.boxlocationindex = null;
    widget.latitude = Datamanager.motorcycleShow.currentlatitude;
    widget.logtitude = Datamanager.motorcycleShow.currentlongitude;
    super.initState();
  }
  startmarker(){
    if(DataFetch.checkhavedata ==0){
      var latitude = Datamanager.motorcycleShow.currentlatitude;
      var longitude = Datamanager.motorcycleShow.currentlongitude;
      String googleUrl =
          'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
      allMarkers.add(
        Marker(
          icon: _markerIcon,
          markerId: MarkerId((widget.i++).toString()),
          draggable: false,
          onTap: (){
          },
          infoWindow: InfoWindow(
            title: Datamanager.placelocationshow.name,
            snippet: 'Tap here to open in google map.',
            onTap: () async {
              if (await canLaunch(googleUrl)) {
                await launch(googleUrl);
              } else {
              }
            },
          ),
          position: LatLng(
            latitude,
            longitude
          ),
        ),
      );
      DataFetch.checkhavedata =1;
      setState(() {
      });
    }
    
    // print(i);
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
     final Uint8List markerIcon = await getBytesFromAsset('assets/images/imagemap/car.png', 200);
      BitmapDescriptor bmpd = BitmapDescriptor.fromBytes(markerIcon);
      setState(() {
        _markerIcon = bmpd;
      });
    }
  }
  addname(BuildContext context){
    return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(20),
        ),
        title: Text(Datamanager.boxlocationshow.name),
        content: Row(
          children: <Widget>[
            RaisedButton(
              child: Text('Confirm'),
              onPressed: (){
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
            SizedBox(width: 10,),
            RaisedButton(
              child: Text('Cancel'),
              onPressed: (){
                Datamanager.boxlocationshow = null;
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    var data = MediaQuery.of(context);
    _createMarkerImageFromAsset(context);
    Future.delayed(const Duration(milliseconds: 200), () {
      startmarker();
    });
    return  Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.white,
      flexibleSpace: Image(
          image: AssetImage('assets/images/imagesprofile/appbar/background.png'),
          fit: BoxFit.cover,
        ),
      centerTitle: true,
      title: Text(UseString.maploacation,
          style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*25,color: Colors.white), 
      ),
      leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left,
          color: Colors.white,
          ),
          onPressed: () {
            DataFetch.checkhavedata = 0;
            Navigator.pop(context);
          },
        ),
      ),
      drawer: Drawer(),
      body: Container(
        width: data.size.width,
        height: data.size.height,
        child: Stack(
          children: <Widget>[
            GoogleMap(
              mapType: MapType.normal,
              zoomGesturesEnabled: true,
              initialCameraPosition: CameraPosition(
                target: LatLng(widget.latitude, widget.logtitude),
                zoom: widget.zoom,
              ),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              markers: Set.from(allMarkers),
              onTap: (latLng){
                Datamanager.boxlocationshow =null;
              },
            ),
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    super.dispose();
  }
}
