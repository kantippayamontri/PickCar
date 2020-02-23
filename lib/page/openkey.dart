import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
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
import 'package:pickcar/ui/uisize.dart';
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
    var number = 0;
    Realtime.checkkeymap.cancel();
    await Firestore.instance.collection('Booking')
                              .where('status' ,isEqualTo: 'booking')
                              .where('motorcycledocid' ,isEqualTo: Datamanager.booking.motorcycledocid)
                              .getDocuments().then((data) {
                                Future.delayed(const Duration(milliseconds: 1000), () async {
                                  if(data.documents.length == 1){
                                    print(data.documents.length);
                                    print('sdsd');
                                    await Firestore.instance.collection('Booking')
                                          .document(Datamanager.booking.bookingdocid)
                                          .updateData({'status': 'working'});
                                    await Firestore.instance.collection('BoxslotRent')
                                          .document(Datamanager.booking.boxslotrentdocid)
                                          .updateData({'iskey': false});
                                    await Firestore.instance.collection('Motorcycle')
                                                .document(Datamanager.booking.motorcycledocid)
                                                .updateData({'isworking': true,'isbook': false});
                                  }else{
                                    print(data.documents.length);
                                    print('=====');
                                    await Firestore.instance.collection('Booking')
                                          .document(Datamanager.booking.bookingdocid)
                                          .updateData({'status': 'working'});
                                    await Firestore.instance.collection('BoxslotRent')
                                          .document(Datamanager.booking.boxslotrentdocid)
                                          .updateData({'iskey': false});
                                    await Firestore.instance.collection('Motorcycle')
                                                .document(Datamanager.booking.motorcycledocid)
                                                .updateData({'isworking': true});
                                  }
                                });
                              });
  }
  updateend(BuildContext context) async {
    var booking = Booking(
      times:Datamanager.booking.time,
      day:Datamanager.booking.day,
      month:Datamanager.booking.month,
      year:Datamanager.booking.year,
      price:Datamanager.booking.price,
      motorcycledocid:Datamanager.booking.motorcycledocid,
      ownerid:Datamanager.booking.ownerid,
      myid:Datamanager.booking.myid,
      bookingdocid:Datamanager.booking.bookingdocid,
      boxdocid:Datamanager.booking.boxdocid,
      boxplacedocid:Datamanager.booking.boxplacedocid,
      boxslotrentdocid:Datamanager.booking.boxslotrentdocid,
      motorplacelocdocid:Datamanager.booking.motorplacelocdocid,
      university:Datamanager.booking.university,
      status:Datamanager.booking.status,
      priceaddtax:Datamanager.booking.priceaddtax,
      startdate:Datamanager.booking.startdate,
      isinhistory:true,
    );
    Realtime.checkkeymap.cancel();
    var price = Datamanager.user.money - Datamanager.booking.priceaddtax;
    await Firestore.instance.collection('Booking')
                              .where('status' ,isEqualTo: 'working')
                              .where('motorcycledocid' ,isEqualTo: Datamanager.booking.motorcycledocid)
                              .getDocuments().then((data) {
                                Future.delayed(const Duration(milliseconds: 1000), () async {
                                  if(data.documents.length == 1){
                                    // print(data.documents.length);
                                    // print('sdsd');
                                    await Firestore.instance.collection('Booking')
                                              .document(Datamanager.booking.bookingdocid)
                                              .updateData({'status': 'end','isinhistory': true});
                                    await Firestore.instance.collection('Motorcycle')
                                              .document(Datamanager.booking.motorcycledocid)
                                              .updateData({'isworking': false});
                                    await Firestore.instance.collection('BoxslotRent')
                                              .document(Datamanager.booking.boxslotrentdocid)
                                              .updateData({'iskey': true});
                                    await Firestore.instance.collection('User')
                                              .document(Datamanager.user.documentid)
                                              .updateData({'money': price});
                                  }else{
                                    // print(data.documents.length);
                                    // print('=====');
                                    await Firestore.instance.collection('Booking')
                                              .document(Datamanager.booking.bookingdocid)
                                              .updateData({'status': 'end','isinhistory': true});
                                    await Firestore.instance.collection('BoxslotRent')
                                              .document(Datamanager.booking.boxslotrentdocid)
                                              .updateData({'iskey': true});
                                    await Firestore.instance.collection('User')
                                              .document(Datamanager.user.documentid)
                                              .updateData({'money': price});
                                    await Firestore.instance.collection('historybooking')
                                              .document(Datamanager.user.documentid)
                                              .setData(booking.toJson());
                                    await Firestore.instance.collection('historybooking')
                                              .document(Datamanager.user.documentid)
                                              .collection('listhistory')
                                              .add({'startdate':Datamanager.booking.startdate,'price':Datamanager.booking.priceaddtax});
                                  }
                                });
                              });
    Datamanager.user.money = price;
    // print(Datamanager.user.money);
                                
  }
  checkiskey(BuildContext context) async {
    if(DataFetch.checkkeymap == 0){
      DataFetch.checkkeymap =1;
      await Firestore.instance.collection('Booking')
                              .document(Datamanager.booking.bookingdocid)
                              .get().then((data){
                                Datamanager.booking = Bookingshow.fromSnapshot(data);
                              });
      Realtime.checkkeymap = Timer.periodic(Duration(seconds: 3), (timer) async {
        var isopen;
        await Firestore.instance.collection('BoxslotRent').document(Datamanager.booking.boxslotrentdocid).get().then((data) async {
          Datamanager.boxslotrentshow = Boxslotrentshow.fromSnapshot(data);
          await FirebaseDatabase.instance
                            .reference()
                            .child(Datamanager.booking.boxdocid)
                            .child(Datamanager.boxslotrentshow.boxslotdocid)
                            .once()
                            .then((DataSnapshot doc) {
                             Map<dynamic , dynamic> result = doc.value;
                             isopen = result['isopen'];
                             print(isopen);
                              if(!isopen){
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
      });
    }
  }
  openbox() async {
    // await Firestore.instance.collection('BoxslotRent')
    //                           .document(Datamanager.booking.boxslotrentdocid)
    //                           .updateData({'isopen': true});
    await FirebaseDatabase().reference().child(Datamanager.booking.boxdocid).child(Datamanager.boxslotrentshow.boxslotdocid).update({"isopen": true,});
  }
  lock() async {
  // await Firestore.instance.collection('BoxslotRent')
  //                             .document(Datamanager.booking.boxslotrentdocid)
  //                             .updateData({'isopen': false});
  await FirebaseDatabase().reference().child(Datamanager.booking.boxdocid).child(Datamanager.boxslotrentshow.boxslotdocid).update({"isopen": false,});
  }
  dispose() {
    Realtime.checkkeymap.cancel();
    lock();
  super.dispose();
}
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
              ButtonTheme(
                height: SizeConfig.blockSizeVertical *7,
                minWidth: SizeConfig.blockSizeHorizontal *20,
                child: RaisedButton(
                  color: PickCarColor.colorbuttom,
                  onPressed: (){
                    openbox();
                    setState(() {
                      widget.receivekey = true;
                      widget.unlock =0;
                    });
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(14.0),
                    // side: BorderSide(color: Colors.red)
                  ),
                  child: Text('OPEN BOX',
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*30,color: Colors.black), 
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
