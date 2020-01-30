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
import 'package:pickcar/models/universityplace.dart';
import 'package:url_launcher/url_launcher.dart';

class Boxselectadmin extends StatefulWidget {
  double zoom = 14;
  double latitude = 18.802587;
  double logtitude = 98.951556;
  double latitudemark;
  double logtitudemark;
  var dataDocument;
  @override
  _BoxselectadminState createState() => _BoxselectadminState();
}

class _BoxselectadminState extends State<Boxselectadmin> {
  Universityplaceshow university;
  BitmapDescriptor _markerIcon;
  var textController = TextEditingController();
  List<Marker> allMarkers = [];
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
  startmarker(DocumentSnapshot data){
    BoxlocationShow boxshow = BoxlocationShow.fromSnapshot(data);
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
        // onTap: (){
        //   print('tapnow');
        // },
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
    // print(i);
  }
  fetchData(BuildContext context) async {
    if(DataFetch.checkhavedata == 0){
      await Firestore.instance.collection('boxlocation')
                              .where('Universityname' , isEqualTo: SetUniversity.university)
                              .getDocuments()
                              .then((data){
                                data.documents.map((data){
                                    print('asds');
                                    startmarker(data);
                                }).toList();
                              });
      // print(SetUniversity.university);
      await Datamanager.firestore.collection('universityplace')
                      .where('Universityname' , isEqualTo: SetUniversity.university)
                      .getDocuments()
                      .then((data){
                        data.documents.map((data){
                          print(data);
                          widget.dataDocument = data;
                        }).toList();
                      });
                      university = Universityplaceshow.fromSnapshot(widget.dataDocument);
                      widget.latitude = university.latitude;
                      widget.logtitude = university.longitude;
                      // print(university.docid);
                      // print(university.listplace);
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
  marker() async {
    LocationData currentLocation;
    currentLocation = await getCurrentLocation();
    setState(() {
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
      widget.latitudemark = currentLocation.latitude;
      widget.logtitudemark = currentLocation.longitude;
      DataFetch.checkhavepin =1;
    });
    GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(LatLng(currentLocation.latitude,currentLocation.longitude), 17.0));
  }
  markertap(LatLng location) async {
    setState(() {
      allMarkers.add(
        Marker(
          icon: _markerIcon,
          markerId: MarkerId('myMarker'),
          draggable: true,
          // onTap: (){
          //   print('tapnow');
          // },
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
    // GoogleMapController controller = await _controller.future;
    // controller.animateCamera(CameraUpdate.newLatLngZoom(location, 17.0));
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
  showalert(BuildContext context){
    var data = MediaQuery.of(context);
        return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(20),
              ),
              // title: Text('place have same name.'),
              content: Text('place have same name.',
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*25,color:PickCarColor.colorFont1), 
                ),
              // TextField(
              //   controller: textController,
              //   decoration: InputDecoration(
              //     hintText: "Put pin name.",
              //   ),
              // ),
              // actions: <Widget>[
              //   Row(
              //     children: <Widget>[
              //       FlatButton(
              //         child: new Text('CONFIRM'),
              //         onPressed: () {
              //           addboxdatabase();
              //         },
              //       ),
              //       FlatButton(
              //         child: new Text('CANCEL'),
              //         onPressed: () {
              //           textController = TextEditingController();
              //           Navigator.of(context).pop();
              //         },
              //       ),
              //     ],
              //   )
              // ],
            );
          });
      // }
      // else{
      //   return Container();
      // }
    }
  addname(BuildContext context){
    return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(20),
        ),
        title: Text('Pin name'),
        content: TextField(
          controller: textController,
          decoration: InputDecoration(
            hintText: "Put pin name.",
          ),
        ),
        actions: <Widget>[
          Row(
            children: <Widget>[
              FlatButton(
                child: new Text('CONFIRM'),
                onPressed: () {
                  addboxdatabase();
                },
              ),
              FlatButton(
                child: new Text('CANCEL'),
                onPressed: () {
                  textController = TextEditingController();
                  Navigator.of(context).pop();
                },
              ),
            ],
          )
        ],
      );
    });
  }
  addboxdatabase() async {
    print(widget.latitudemark);
    var listnull = [];
    listnull.add(textController.text);
    List<dynamic> list = university.listplacebox;
    int samename;
    if(list !=null){
      samename = list.indexOf(textController.text);
    }else{
      samename = -1;
    }
    
    if(samename == -1){
     Boxlocation boxlocation = Boxlocation(
      latitude: widget.latitudemark,
      longitude: widget.logtitudemark,
      name: textController.text,
      universityname: SetUniversity.university,
    );
    var refboxlocation = await Datamanager.firestore.collection('boxlocation')
                          .add(boxlocation.toJson());
    var docboxlocationid = refboxlocation.documentID;
    Datamanager.firestore.collection('boxlocation')
                          .document(docboxlocationid)
                          .updateData({'docboxid':docboxlocationid});
    Box box = Box(
      latitude: widget.latitudemark,
      longitude: widget.logtitudemark,
      boxlocationid: docboxlocationid,
      maxslot: 10,
    );
    Datamanager.firestore.collection('universityplace')
                        .document(university.docid)
                        .updateData({'listplacebox': FieldValue.arrayUnion(listnull)});

    var refbox = await Datamanager.firestore.collection('box')
                          .add(box.toJson());
    var docboxid = refbox.documentID;
    Datamanager.firestore.collection('box').document(docboxid).updateData({'docid': docboxid});
    for(int i=1;i<box.maxslot+1;i++){
      // print(i);
      var ref =Datamanager.firestore.collection('box')
                          .document(docboxid)
                          .collection('boxslot')
                          .document();
      var docslot = ref.documentID;
      Datamanager.firestore.collection('box')
                          .document(docboxid)
                          .collection('boxslot')
                          .document(docslot)
                          .setData({'name': i,'docid':docslot,'boxid':docboxid});
    }
    // Future.delayed(const Duration(milliseconds: 1000), () {
    // print('a');
    Datamanager.firestore.collection('box')
                          .document(docboxid)
                          .updateData({'docboxid':docboxid}).whenComplete((){
                            setState(() {
                              DataFetch.checkhavedata =0;
                              DataFetch.checkhavepin =0;
                              allMarkers = [];
                              textController = TextEditingController();
                              _controller = Completer();
                              Navigator.pop(context);
                            });
                          });
    }else{
      Navigator.pop(context);
      textController = TextEditingController();
      showalert(context);
    }
    // });

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
  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}
