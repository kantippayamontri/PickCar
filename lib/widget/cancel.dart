import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pickcar/datamanager.dart';
import 'package:pickcar/models/booking.dart';
import 'package:pickcar/models/listcarslot.dart';

  String monthy(int month) {
    switch (month) {
      case 1:
        return 'Jan';
        break;
      case 2:
        return 'Feb';
        break;
      case 3:
        return 'Mar';
        break;
      case 4:
        return 'Apr';
        break;
      case 5:
        return 'May';
        break;
      case 6:
        return 'Jun';
        break;
      case 7:
        return 'Jul';
        break;
      case 8:
        return 'Aug';
        break;
      case 9:
        return 'Sep';
        break;
      case 10:
        return 'Oct';
        break;
      case 11:
        return 'Nov';
        break;
      default:
        return 'Dec';
        break;
    }
  }
  showdialogrenter(BuildContext context,Bookingshow booking,MotorcycleShow motorcycleShow){
      return showDialog<void>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(UseString.bookinreport),
            content: Text("Brand: "+motorcycleShow.brand
                          +"\nGeneration: "+motorcycleShow.generation
                          +"\n"+UseString.date +" : "+ booking.day.toString()+" "+monthy(booking.month)+" "+booking.year.toString()
                          +"\n"+UseString.time +" : "+ booking.time
                          +"\n"+UseString.price +" : "+ booking.price.toString()+'฿'),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () async {
                  await Firestore.instance.collection('Booking')
                          .document(booking.bookingdocid)
                          .updateData({"rentercanclealert":true,"alreadycheck":true}).whenComplete((){
                            DataFetch.waitloaddata = 0;
                            Navigator.of(context).pop();
                          });
                },
              ),
            ],
          );

        },
      ).then((data) async {
        await Firestore.instance.collection('Booking')
                          .document(booking.bookingdocid)
                          .updateData({"rentercanclealert":true,"alreadycheck":true}).whenComplete((){
                            DataFetch.waitloaddata = 0;
                          });
      });;
    }
    showdialogowner(BuildContext context,Bookingshow booking,MotorcycleShow motorcycleShow){
      return showDialog<void>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(UseString.cancelrent),
            content:Text("Brand: "+motorcycleShow.brand
                          +"\nGeneration: "+motorcycleShow.generation
                          +"\n"+UseString.date +" : "+ booking.day.toString()+" "+monthy(booking.month)+" "+booking.year.toString()
                          +"\n"+UseString.time +" : "+ booking.time
                          +"\n"+UseString.price +" : "+ booking.price.toString()+'฿'),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () async {
                  await Firestore.instance.collection('Booking')
                          .document(booking.bookingdocid)
                          .updateData({"ownercanclealert":true,"alreadycheck":true}).whenComplete((){
                            DataFetch.waitloaddata = 0;
                            Navigator.of(context).pop();
                          });
                },
              ),
            ],
          );
        },
      ).then((data) async {
        await Firestore.instance.collection('Booking')
                          .document(booking.bookingdocid)
                          .updateData({"ownercanclealert":true,"alreadycheck":true}).whenComplete((){
                            DataFetch.waitloaddata = 0;
                          });
      });
    }
  showAleartcancel(BuildContext context) async {
    var time;
    if(DataFetch.logincancelshow == 0){
      time =10000;
      DataFetch.logincancelshow = 1;
    }else{
      print('alert');
      time = 100;
    }
    Future.delayed(Duration(milliseconds: time), () {
      if(DataFetch.fetchcancelalert == 0){
        DataFetch.fetchcancelalert = 1;
        Realtime.checkalert = Timer.periodic(Duration(seconds: 1), (timer) async {
          if(DataFetch.waitloaddata == 0){
            DataFetch.waitloaddata = 1;
            Firestore.instance.collection('Booking').where('iscancle',isEqualTo:true).where('ownercanclealert',isEqualTo:false).where('alreadycheck',isNull: true).snapshots().first.then((databook){
              try{
                print('-----');
                var booking= Bookingshow.fromSnapshot(databook.documents.first);
                Firestore.instance.collection('Motorcycle').document(booking.motorcycledocid).get().then((data) async {
                  var motorshow = MotorcycleShow.fromSnapshot(data);
                  // print(booking.ownerid);
                  // print(Datamanager.user.documentid);
                  // print(booking.ownercanclealert);
                  if(booking.rentercanclealert && booking.ownercanclealert ){
                    // print('has cancel');
                    DataFetch.waitloaddata = 0;
                  }else if(!booking.ownercanclealert && booking.ownerid == Datamanager.user.documentid){
                    showdialogowner(context,booking,motorshow);
                  }else{
                    DataFetch.waitloaddata = 0;
                  }
                });
              }catch(error){
                print(error);
                DataFetch.waitloaddata = 0;
              }
            });
            if(DataFetch.waitloaddata == 0){
            DataFetch.waitloaddata = 1;
            Firestore.instance.collection('Booking').where('iscancle',isEqualTo:true).where('rentercanclealert',isEqualTo:false).where('alreadycheck',isNull: true).snapshots().first.then((databook){
              try{
                print('-----');
                var booking= Bookingshow.fromSnapshot(databook.documents.first);
                Firestore.instance.collection('Motorcycle').document(booking.motorcycledocid).get().then((data) async {
                  var motorshow = MotorcycleShow.fromSnapshot(data);
                  print(booking.ownerid);
                  print(Datamanager.user.documentid);
                  print(booking.ownercanclealert);
                  if(booking.rentercanclealert && booking.ownercanclealert ){
                    print('has cancel');
                    DataFetch.waitloaddata = 0;
                  }else if(!booking.rentercanclealert&& booking.ownerid != Datamanager.user.documentid){
                    showdialogrenter(context,booking,motorshow);
                  }else{
                    DataFetch.waitloaddata = 0;
                  }
                });
              }catch(error){
                print(error);
                DataFetch.waitloaddata = 0;
              }
            });
          }
          }
        });
      }
    });
  }
  Widget cancelshow(BuildContext context) {
    print('begin sss');
    showAleartcancel(context);
    return Container();
  }
