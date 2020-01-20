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
  double latitude = 18.802587;
  double logtitude = 98.951556;
  @override
  _MapaddmarkState createState() => _MapaddmarkState();
}

class _MapaddmarkState extends State<Mapaddmark> {
  BitmapDescriptor _markerIcon;
  List<Marker> allMarkers = [];
  @override
  void initState(){
    UseString.pin = "Pin Here";
    //bankok
    widget.latitude = 13.736717;
    widget.logtitude = 100.523186;
    //chiangmai university
    widget.latitude = 18.802587;
    widget.logtitude = 98.951556;
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
    allMarkers = [];
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
          // onTap: (){
          //   print('tapnow');
          // },
          position: LatLng(
            location.latitude,
            location.longitude),
        ),
      );
      UseString.pin = "Add Here";
    });
    GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(location, 17.0));
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
  @override
  Widget build(BuildContext context) {
    var data = MediaQuery.of(context);
    _createMarkerImageFromAsset(context);
    return  Scaffold(
      appBar: AppBar(
       backgroundColor: Colors.white,
       flexibleSpace: Image(
          image: AssetImage('assets/images/imagesprofile/appbar/background.png'),
          fit: BoxFit.cover,
        ),
       centerTitle: true,
       title: Text(UseString.detail,
          style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*25,color: Colors.white), 
       ),
       actions: <Widget>[
         IconButton(
          icon: Icon(Icons.search,
          color: Colors.white,
          ),
          onPressed: () {
            showSearch(context: context,delegate:Searchmap());
          },
        ),
       ],
       leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left,
          color: Colors.white,
          ),
          onPressed: () {
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
                  UseString.pin = "Add Here";
                  marker();
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
  }
}

class Searchmap extends SearchDelegate<String> {
  final data = ["asssssd","b"];
  final suggest = ["cadad","d"];
  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(
        icon: Icon(Icons.clear),
        onPressed:(){
          query ='';
        },
      )];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: (){
        close(context,null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty ? suggest
        :data.where((p) => p.startsWith(query)).toList();
    return ListView.builder(
      itemBuilder: (context,index){
        return ListTile(
          onTap: (){
            showResults(context);
          },
          leading: Icon(Icons.location_city),
          title: RichText(
            text: TextSpan(
              text: suggestionList[index].substring(0,query.length),
              style: TextStyle(
                color: Colors.black,fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: suggestionList[index].substring(query.length),
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        );
      },
      itemCount: suggestionList.length,
    );
  }

}