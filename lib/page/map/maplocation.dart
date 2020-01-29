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

class Maplocation extends StatefulWidget {
  double zoom = 14;
  double latitude = 18.802587;
  double logtitude = 98.951556;
  double latitudemark;
  double logtitudemark;
  List box = [];
  int i=0;
  @override
  _MaplocationState createState() => _MaplocationState();
}

class _MaplocationState extends State<Maplocation> {
  BitmapDescriptor _markerIconlocation;
  BitmapDescriptor _markerIconKey;
  bool addlocation = true;
  var textController = TextEditingController();
  List<Marker> allMarkers = [];
  @override
  void initState(){
    DataFetch.checkhavedata =0;
    Datamanager.boxlocationshow = null;
    Datasearch.boxlocationname = [];
    Datasearch.boxlocationlatitude = [];
    Datasearch.boxlocationlogtitude = [];
    Datasearch.boxlocationindex = null;
    addlocation = true;
    //bankok
    widget.latitude = 13.736717;
    widget.logtitude = 100.523186;
    //chiangmai university
    widget.latitude = 18.802587;
    widget.logtitude = 98.951556;
    super.initState();
  }
  startmarker(DocumentSnapshot data){
    print('aaa');
    if(addlocation){
      addlocation = false;
      BoxlocationShow boxshow = BoxlocationShow.fromSnapshot(data);
      // print(boxshow.name);
      var latitude = boxshow.latitude;
      var logitude = boxshow.longitude;
      String googleUrl =
          'https://www.google.com/maps/search/?api=1&query=$latitude,$logitude';
      allMarkers.add(
        Marker(
          icon: _markerIconKey,
          markerId: MarkerId((widget.i++).toString()),
          draggable: false,
          onTap: (){
            // Datamanager.boxlocationshow = boxshow;
          },
          infoWindow: InfoWindow(
            title: boxshow.name,
            snippet: 'Tap here to open in google map.',
            onTap: () async {
              if (await canLaunch(googleUrl)) {
                await launch(googleUrl);
              } else {
              }
            },
          ),
          position: LatLng(
            boxshow.latitude,
            boxshow.longitude
          ),
        ),
      );
      var latitudes = Datamanager.placelocationshow.latitude;
      var longitudes = Datamanager.placelocationshow.longitude;
      String googleUrls =
          'https://www.google.com/maps/search/?api=1&query=$latitudes,$longitudes';
      allMarkers.add(
        Marker(
          icon: _markerIconlocation,
          markerId: MarkerId((widget.i++).toString()),
          draggable: false,
          onTap: (){
            // Datamanager.boxlocationshow = boxshow;
          },
          infoWindow: InfoWindow(
            title: Datamanager.placelocationshow.name,
            snippet: 'Tap here to open in google map.',
            onTap: () async {
              if (await canLaunch(googleUrls)) {
                await launch(googleUrls);
              } else {
              }
            },
          ),
          position: LatLng(
            latitudes,
            longitudes
          ),
        ),
      );
    }
    // print(i);
  }
  fetchData(BuildContext context) async {
    if(DataFetch.checkhavedata == 0){
      var i =0;
      Firestore.instance.collection('boxlocation').where("docboxid", isEqualTo: Datamanager.listcarslot.boxplacedocid).snapshots().listen((data){
        // print(data);
        data.documents.map((datas){
          // print(data.documents.length);
          startmarker(datas);
        }).toList();
      });
    }else{
      return Container();
    }
    
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
    var icon;
    var icon2;
    if (_markerIconKey == null) {
     final Uint8List markerIcon = await getBytesFromAsset('assets/images/imagemap/key.png', 200);
      BitmapDescriptor bmpd = BitmapDescriptor.fromBytes(markerIcon);
      _markerIconKey = bmpd;
    }
    if (_markerIconlocation == null) {
     final Uint8List markerIcon = await getBytesFromAsset('assets/images/imagemap/place.png', 200);
      BitmapDescriptor bmpd = BitmapDescriptor.fromBytes(markerIcon);
      _markerIconlocation = bmpd;
    }
    print('sss');
    setState(() {
    });
  }
  wait(){
    Future.delayed(const Duration(milliseconds: 1000), () {
      // print('wait');
      setState(() {
        DataFetch.checkhavedata =1;
        allMarkers = allMarkers;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    var data = MediaQuery.of(context);
    _createMarkerImageFromAsset(context);
    Future.delayed(const Duration(milliseconds: 200), () {
      fetchData(context);
    });
    if(DataFetch.checkhavedata == 1){
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
    }else{
      wait();
      // return Container();
      return Center(
        child: Container(
          width: data.size.width,
          height: data.size.height,
          color: PickCarColor.colormain,
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 100),
                child: SpinKitCircle(
                  color: Colors.white,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                child:  Text(UseString.loading,
                  style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*25,color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}
