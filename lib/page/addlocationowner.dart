import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../datamanager.dart';

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
import 'package:pickcar/models/box.dart';
import 'package:pickcar/models/boxlocation.dart';
import 'package:pickcar/models/listcarslot.dart';
import 'package:pickcar/models/universityplace.dart';
import 'package:url_launcher/url_launcher.dart';

class AddLocationOwner extends StatefulWidget {

  double zoom = 14;
  double latitude = 18.802587;
  double logtitude = 98.951556;
  double latitudemark;
  double logtitudemark;
  var dataDocument;
  String motorcycledocid;

  AddLocationOwner({@required this.motorcycledocid});

  @override
  _AddLocationOwnerState createState() => _AddLocationOwnerState();
}

class _AddLocationOwnerState extends State<AddLocationOwner> {
  Universityplaceshow university;
  BitmapDescriptor _markerIcon;
  List<Marker> allMarkers = [];
  Completer<GoogleMapController> _controller = Completer();
  @override
  void initState(){
    UseString.pin = "Pin Here";
    DataFetch.checkhavedata =0;
    DataFetch.checkhavepin =0;
    //bankok
    widget.latitude = 13.736717;
    widget.logtitude = 100.523186;
    //chiangmai university
    widget.latitude = 18.802587;
    widget.logtitude = 98.951556;
    super.initState();
  }
  // addmarker(){
  //   allMarkers.add(
  //     Marker(
  //       icon: _markerIcon,
  //       markerId: MarkerId('wait'),
  //       draggable: false,
  //       visible: true,
  //       // onTap: (){
  //       //   print('tapnow');
  //       // },
  //     ),
  //   );
  //   print('wait');
  //   print(allMarkers.length);
  // }
  startmarker(DocumentSnapshot data) async {
    MotorcycleShow motor = MotorcycleShow.fromSnapshot(data);
    if(motor.currentlatitude != null && motor.currentlongitude != null){
      var latitude = motor.currentlatitude;
      var longitude = motor.currentlongitude;
      widget.latitude = latitude;
      widget.logtitude = longitude;
      int i = 0;
      String googleUrl =
          'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
      allMarkers.add(
        Marker(
          icon: _markerIcon,
          markerId: MarkerId((i++).toString()),
          draggable: false,
          // onTap: (){
          //   print('tapnow');
          // },
          infoWindow: InfoWindow(
            title: UseString.thiscar,
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
    }
    
    // print(i);
  }
  fetchData(BuildContext context) async {
    if(DataFetch.checkhavedata == 0){
      await Firestore.instance.collection('Motorcycle')
                             .document(widget.motorcycledocid)
                             .get()
                              .then((data){
                                startmarker(data);
                              });
    }else{
      return Container();
    }
    
  }
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
    setState(() {
      allMarkers.add(
        Marker(
          icon: _markerIcon,
          markerId: MarkerId('myMarker'),
          draggable: true,
          position: LatLng(
            currentLocation.latitude,
            currentLocation.longitude),
        ),
      );
      widget.latitudemark = currentLocation.latitude;
      widget.logtitudemark = currentLocation.longitude;
      DataFetch.checkhavepin =1;
    });
    GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(LatLng(currentLocation.latitude,currentLocation.longitude), 17.0));
  }
  markertap(LatLng location) async {
    allMarkers = [];
    setState(() {
      allMarkers.add(
        Marker(
          icon: _markerIcon,
          markerId: MarkerId('myMarker'),
          draggable: true,
          position: LatLng(
            location.latitude,
            location.longitude),
        ),
      );
      widget.latitudemark = location.latitude;
      widget.logtitudemark = location.longitude;
      DataFetch.checkhavepin =1;
      UseString.pin = "Add Here";
    });
     GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(LatLng(location.latitude,location.longitude), 17.0));
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
        title: Text(UseString.addlocation,
          style: TextStyle(fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).textScaleFactor*25,color:PickCarColor.colorFont1), 
        ),
        content: Text(UseString.thisplace,
          style: TextStyle(fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).textScaleFactor*18,color:PickCarColor.colorFont1), 
        ),
        actions: <Widget>[
          Row(
            children: <Widget>[
              FlatButton(
                child: new Text('CONFIRM'),
                onPressed: () {
                  addboxdatabase(context);
                },
              ),
              FlatButton(
                child: new Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          )
        ],
      );
    });
  }
  loadalert(BuildContext context){
    var data = MediaQuery.of(context);
    return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(20),
        ),
        content: Container(
          width: data.size.width/3,
          height: data.size.height/10,
          child: Row(
            children: <Widget>[
              SpinKitCircle(
                color: PickCarColor.colormain,
              ),
              Text(UseString.loading,
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).textScaleFactor*25,color:PickCarColor.colorFont1), 
              ),
            ],
          ),
        ),
      );
    });
  }
  addboxdatabase(BuildContext context) async {
    loadalert(context);
    await Firestore.instance.collection('Motorcycle')
                             .document(widget.motorcycledocid)
                             .updateData({'currentlatitude': widget.latitudemark,'currentlongitude': widget.logtitudemark})
                             .then((data){
                               Navigator.pop(context);
                               Navigator.pop(context);
                               Navigator.pop(context);
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
    fetchData(context);
    if(DataFetch.checkhavedata == 1){
      return  Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.white,
        flexibleSpace: Image(
            image: AssetImage('assets/images/imagesprofile/appbar/background.png'),
            fit: BoxFit.cover,
          ),
        centerTitle: true,
        title: Text(UseString.addlocation,
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
                onTap: (latlang) {
                  UseString.pin = "Add Here";
                  markertap(latlang); //we will call this function when pressed on the map
                },
              ),
              Container(
                margin: EdgeInsets.only(left: 120,top: 520),
                width: 170,
                height: 60,
                // color: Colors.black,
                child: FlatButton(
                  color: PickCarColor.colormain,
                  onPressed: (){
                    // print(DataFetch.checkhavepin);
                    if(DataFetch.checkhavepin ==0){
                      UseString.pin = "Add Here";
                      marker();
                    }else{
                      // addboxdatabase();
                      addname(context);
                    }
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                    // side: BorderSide(color: Colors.red)
                  ),
                  child: Text(UseString.pin,
                    style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*25,color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: getlocationnow,
          child: Icon(Icons.near_me),
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
}