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
import 'package:pickcar/models/booking.dart';
import 'package:pickcar/models/boxlocation.dart';
import 'package:pickcar/models/boxslotrentshow.dart';
import 'package:pickcar/models/listcarslot.dart';
import 'package:pickcar/models/user.dart';
import 'package:url_launcher/url_launcher.dart';

class Openkey extends StatefulWidget {
  String url = 'assets/images/keyopen/gif.gif';
  double zoom = 14;
  int i=0;
  bool receivekey = false;
  double unlock = 20;
  @override
  _OpenkeyState createState() => _OpenkeyState();
}

class _OpenkeyState extends State<Openkey> {
  @override
  void initState(){
    DataFetch.checkkeymap=0;
    Realtime.checkkeymap = Timer.periodic(Duration(days: 1), (timer){});
    widget.unlock = 20;
    widget.url = 'assets/images/keyopen/gif.gif';
    super.initState();
  }
  openimage(BuildContext context){
    // if(widget.showbuttom){
    return  Stack(
      children: <Widget>[
        AnimatedContainer(
          margin: EdgeInsets.only(top: widget.unlock),
          duration: Duration(milliseconds: 300),
          child: Image(image: new AssetImage('assets/images/keyopen/unlock.png'),),
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          child: Image(image: new AssetImage('assets/images/keyopen/lock.png'),),
        ),
      ],
    );
  }
  showalertkeyisin(BuildContext context){
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0))
          ),
          title: Text(UseString.takekey),
          content: Text(UseString.checktakekey),
          actions: <Widget>[
            FlatButton(
              child: Text(UseString.confirm),
              onPressed: () {
                updateworking(context);
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text(UseString.cancel),
              onPressed: () {
                openbox();
                setState(() {
                  widget.unlock =0;
                  widget.receivekey = true;
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
  showalertdropkey(BuildContext context){
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0))
          ),
          title: Text(UseString.dropkey),
          content: Text(UseString.checkdropkey),
          actions: <Widget>[
            FlatButton(
              child: Text(UseString.confirm),
              onPressed: () {
                updateend(context);
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text(UseString.cancel),
              onPressed: () {
                openbox();
                setState(() {
                  widget.unlock =0;
                  widget.receivekey = true;
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
  updateworking(BuildContext context) async {
    Realtime.checkkeymap.cancel();
    await Firestore.instance.collection('Booking')
                              .document(Datamanager.booking.bookingdocid)
                              .updateData({'status': 'working'});
    await Firestore.instance.collection('BoxslotRent')
                              .document(Datamanager.booking.boxslotrentdocid)
                              .updateData({'iskey': false});
  }
  updateend(BuildContext context) async {
    Realtime.checkkeymap.cancel();
    var price = Datamanager.user.money - Datamanager.booking.priceaddtax;;
    await Firestore.instance.collection('Booking')
                              .document(Datamanager.booking.bookingdocid)
                              .updateData({'status': 'end'});
    await Firestore.instance.collection('BoxslotRent')
                              .document(Datamanager.booking.boxslotrentdocid)
                              .updateData({'iskey': true});
    await Firestore.instance.collection('User')
                              .document(Datamanager.user.documentid)
                              .updateData({'money': price});
    Datamanager.user.money = price;
    print(Datamanager.user.money);
                                
  }
  checkiskey(BuildContext context) async {
    if(DataFetch.checkkeymap == 0){
      DataFetch.checkkeymap =1;
      await Firestore.instance.collection('Booking')
                              .document(Datamanager.booking.bookingdocid)
                              .get().then((data){
                                Datamanager.booking = Bookingshow.fromSnapshot(data);
                              });
      Realtime.checkkeymap = Timer.periodic(Duration(seconds: 1), (timer) async {
        await Firestore.instance.collection('BoxslotRent').document(Datamanager.booking.boxslotrentdocid).get().then((data){
          Datamanager.boxslotrentshow = Boxslotrentshow.fromSnapshot(data);
          if(!Datamanager.boxslotrentshow.isopen){
            setState(() {
              if(widget.receivekey && Datamanager.booking.status == 'working'){
                widget.receivekey = false;
                showalertdropkey(context);
              }else if(widget.receivekey && Datamanager.booking.status == 'booking'){
                widget.receivekey = false;
                showalertkeyisin(context);
              }else{

              }
              widget.unlock =20;
            });
          }
        });
      });
    }
  }
  openbox() async {
    await Firestore.instance.collection('BoxslotRent')
                              .document(Datamanager.booking.boxslotrentdocid)
                              .updateData({'isopen': true});
  }
  lock() async {
  await Firestore.instance.collection('BoxslotRent')
                              .document(Datamanager.booking.boxslotrentdocid)
                              .updateData({'isopen': false});
  }
  dispose() {
    lock();
    Realtime.checkkeymap =null;
  super.dispose();
}
  @override
  Widget build(BuildContext context) {
    checkiskey(context);
    var data = MediaQuery.of(context);
    return Scaffold(
      body: Container(
        width: data.size.width,
        height: data.size.height,
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 50,),
              Container(
                child: Text(UseString.slotnumber,
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*30,color: Colors.black), 
                ),
              ),
              Container(
                child: Text(Datamanager.boxslotnumbershow.name.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*180,color: Colors.black), 
                ),
              ),
              openimage(context),
              RaisedButton(
                onPressed: (){
                  openbox();
                  setState(() {
                    widget.receivekey = true;
                    widget.unlock =0;
                  });
                },
                child: Text('OPEN BOX',
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*30,color: Colors.black), 
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
