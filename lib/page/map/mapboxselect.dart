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
import 'package:url_launcher/url_launcher.dart';

class Mapboxselect extends StatefulWidget {
  double zoom = 14;
  double latitude = 18.802587;
  double logtitude = 98.951556;
  double latitudemark;
  double logtitudemark;
  @override
  _MapboxselectState createState() => _MapboxselectState();
}

class _MapboxselectState extends State<Mapboxselect> {
  BitmapDescriptor _markerIcon;
  var textController = TextEditingController();
  List<Marker> allMarkers = [];
  @override
  void initState(){
    DataFetch.checkhavedata =0;
    //bankok
    widget.latitude = 13.736717;
    widget.logtitude = 100.523186;
    //chiangmai university
    widget.latitude = 18.802587;
    widget.logtitude = 98.951556;
    super.initState();
  }
  startmarker(DocumentSnapshot data){
    BoxShow boxshow = BoxShow.fromSnapshot(data);
    var latitude = boxshow.latitude;
    var logitude = boxshow.longitude;
    int i = 0;
     String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$logitude';
    allMarkers.add(
      Marker(
        icon: _markerIcon,
        markerId: MarkerId((i++).toString()),
        draggable: false,
        onTap: (){
          Datamanager.boxselect = boxshow;
        },
        infoWindow: InfoWindow(
          title: boxshow.placename,
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
    // print(i);
  }
  fetchData(BuildContext context) async {
    if(DataFetch.checkhavedata == 0){
      await Firestore.instance.collection('box').getDocuments().then((data){
        data.documents.map((data){
            startmarker(data);
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
    if (_markerIcon == null) {
     final Uint8List markerIcon = await getBytesFromAsset('assets/images/imagemap/key.png', 200);
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
        title: Text(Datamanager.boxselect.placename),
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
                Datamanager.boxselect = null;
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
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
                onTap: (latLng){
                  Datamanager.boxselect =null;
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
                    if(Datamanager.boxselect != null){
                      addname(context);
                    }
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                    // side: BorderSide(color: Colors.red)
                  ),
                  child: Text(UseString.selectbox,
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
  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}
