import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:latlong/latlong.dart' as A;
import 'package:location/location.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

import 'package:pickcar/datamanager.dart';
import 'package:pickcar/models/boxlocation.dart';
import 'package:url_launcher/url_launcher.dart';

class Receivekeymap extends StatefulWidget {
  double zoom = 14;
  double latitude = 18.802587;
  double logtitude = 98.951556;
  double latitudebox;
  double logtitudebox;
  double latitudemark;
  double logtitudemark;
  bool openbutton = false;
  List box = [];
  int i = 0;
  @override
  _ReceivekeymapState createState() => _ReceivekeymapState();
}

class _ReceivekeymapState extends State<Receivekeymap>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<Offset> offset;
  BitmapDescriptor _markerIcon;
  List<Marker> allMarkers = [];
  @override
  void initState() {
    DataFetch.checkhavedata = 0;
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));

    offset = Tween<Offset>(begin: Offset.zero, end: Offset(0.0, -0.5))
        .animate(controller);
    // Datasearch.boxlocationname = [];
    // Datasearch.boxlocationlatitude = [];
    // Datasearch.boxlocationlogtitude = [];
    // Datasearch.boxlocationindex = null;
    widget.latitude = Datamanager.boxlocationshow.latitude;
    widget.logtitude = Datamanager.boxlocationshow.longitude;
    super.initState();
  }

  startmarker() {
    if (DataFetch.checkhavedata == 0) {
      var latitude = Datamanager.boxlocationshow.latitude;
      var longitude = Datamanager.boxlocationshow.longitude;

      String googleUrl =
          'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
      allMarkers.add(
        Marker(
          icon: _markerIcon,
          markerId: MarkerId((widget.i++).toString()),
          draggable: false,
          onTap: () {
            setState(() {
              widget.openbutton = true;
              widget.latitudebox = latitude;
              widget.logtitudebox = longitude;
              controller.forward();
            });
          },
          infoWindow: InfoWindow(
            title: Datamanager.boxlocationshow.name,
            snippet: 'Tap here to open in google map.',
            onTap: () async {
              if (await canLaunch(googleUrl)) {
                await launch(googleUrl);
              } else {}
            },
          ),
          position: LatLng(latitude, longitude),
        ),
      );
      DataFetch.checkhavedata = 1;
      setState(() {});
    }

    // print(i);
  }
  showfar(BuildContext context,double meter){
    var data = MediaQuery.of(context);
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(20),
          ),
          title: Text(UseString.fartitle+meter.toString()+" "+UseString.meters),
          content: Text(UseString.fardetail,),
          actions: <Widget>[
            FlatButton(
              child: Text(UseString.ok),
              onPressed: (){
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
  }
  Completer<GoogleMapController> _controller = Completer();
  Future<LocationData> getCurrentLocation() async {
    Location location = Location();
    try {
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
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(currentLocation.latitude, currentLocation.longitude),
      zoom: 16,
    )));
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
  }

  Future _createMarkerImageFromAsset(BuildContext context) async {
    if (_markerIcon == null) {
      final Uint8List markerIcon =
          await getBytesFromAsset('assets/images/imagemap/key.png', 200);
      BitmapDescriptor bmpd = BitmapDescriptor.fromBytes(markerIcon);
      setState(() {
        _markerIcon = bmpd;
      });
    }
  }
  shownotavailable(BuildContext context) {
    var data = MediaQuery.of(context);
    var notavailable = '';
    if(!Checkopenkey.checkcar && Checkopenkey.checkkey){
      notavailable = UseString.carnotavai ;
    }else if(!Checkopenkey.checkkey && Checkopenkey.checkcar){
      notavailable = UseString.keynotavai;
    }else{
      notavailable = UseString.carnotavai +"\n"+ UseString.keynotavai;
    }
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(20),
          ),
          // title: Text('place have same name.'),
          content: Text(
            notavailable,
            style: TextStyle(
                fontWeight: FontWeight.bold,),
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        flexibleSpace: Image(
          image:
              AssetImage('assets/images/imagesprofile/appbar/background.png'),
          fit: BoxFit.cover,
        ),
        centerTitle: true,
        title: Text(
          UseString.maploacation,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: data.textScaleFactor * 25,
              color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_arrow_left,
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
              onTap: (latLng) {
                Datamanager.boxlocationshow = null;
                setState(() {
                  controller.reverse();
                  widget.openbutton = false;
                });
              },
            ),
            AnimatedOpacity(
              opacity: widget.openbutton ? 1.0 : 0.0,
              duration: Duration(milliseconds: 300),
              child: Container(
                width: double.infinity,
                height: data.size.height,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  // padding: EdgeInsets.only(bottom: data.size.height/15),
                  child: ButtonTheme(
                    minWidth: data.size.width / 2.5,
                    height: data.size.height / 9,
                    child: SlideTransition(
                      position: offset,
                      child: RaisedButton(
                        color: PickCarColor.colorbuttom,
                        onPressed: () async {
                          final A.Distance distance = new A.Distance();
                          LocationData currentLocation;
                          final GoogleMapController controller = await _controller.future;
                          currentLocation = await getCurrentLocation();
                           final double meter = distance(
                                        new A.LatLng(currentLocation.latitude,currentLocation.longitude),
                                        new A.LatLng(widget.latitudebox,widget.logtitudebox)
                                      );
                          if(meter<=20){
                            if(Checkopenkey.checkkey && Checkopenkey.checkcar){
                              Navigator.of(context).pushNamed(Datamanager.openkey);
                            }else{
                              shownotavailable(context);
                            }
                          }else{
                            showfar(context,meter);
                          }
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                          // side: BorderSide(color: Colors.red)
                        ),
                        child: IntrinsicWidth(
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: data.size.width/11,
                                height: data.size.height/18,
                                child: Image.asset("assets/images/imagemap/keyunlock.png",fit:BoxFit.fill),
                              ),
                              Text(
                                " "+UseString.unlock,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: data.textScaleFactor * 25,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
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
