import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
import 'package:pickcar/models/chat.dart';
import 'package:pickcar/models/listcarslot.dart';
import 'package:pickcar/models/user.dart';
import 'package:pickcar/ui/uisize.dart';
import 'package:url_launcher/url_launcher.dart';

class Chatpage extends StatefulWidget {
  String url = 'assets/images/keyopen/gif.gif';
  double zoom = 14;
  int i=0;
  bool receivekey = false;
  double unlock = 20;
  @override
  _ChatpageState createState() => _ChatpageState();
}

class _ChatpageState extends State<Chatpage> {
  @override
  void initState(){
    super.initState();
  }
  
  dispose() {

  super.dispose();
}
  @override
  Widget build(BuildContext context) {
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
    SizeConfig().init(context);
    var data = MediaQuery.of(context);
    var datasize = MediaQuery.of(context);
    var imageusershow;
    Future<String> _getImage(BuildContext context,Usershow usershow) async {
     return await FirebaseStorage.instance
                                  .ref()
                                  .child('User')
                                  .child(usershow.uid)
                                  .child(usershow.profilepicpath+'.'+usershow.profilepictype).getDownloadURL();
    }
    Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
      var usershow;
      Chatprofileshow chatshow = Chatprofileshow.fromSnapshot(data);
      return GestureDetector(
        onTap: (){
          Datamanager.imageusershow = imageusershow;
          // addgroupchat(usershow);
          Datamanager.usershow = usershow;
          Datamanager.chatprofileshow = chatshow;
          Navigator.of(context).pushNamed(Datamanager.messagepage);
        },
        child: Container(
          margin: EdgeInsets.only(top:SizeConfig.blockSizeVertical*1),
          // width: SizeConfig.blockSizeHorizontal*75,
          height: SizeConfig.blockSizeVertical*13,
          // color: Colors.blue,
          child: Container(
            margin: EdgeInsets.only(left:SizeConfig.blockSizeHorizontal*6,right:SizeConfig.blockSizeHorizontal*6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Color.fromARGB(20, 0, 0, 0),
            ),
            child: Stack(
              children: <Widget>[
                StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance.collection('User').where("documentid", isEqualTo: chatshow.documentcontact).snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting){
                      return LinearProgressIndicator();
                    }else if(snapshot.hasError){
                      return LinearProgressIndicator();
                    }else{
                      var datadocument;
                      snapshot.data.documents.map((data){
                        datadocument = data;
                      }).toList();
                      usershow = Usershow.fromSnapshot(datadocument);
                      return FutureBuilder(
                        future: _getImage(context, usershow),
                        builder: (context, snapshot) {
                          imageusershow = snapshot.data;
                          if (snapshot.connectionState == ConnectionState.waiting){
                            return Container(
                            );
                          }
                          if (snapshot.hasError){
                            return Container(
                            );
                          }else{
                            return Row(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical,left: SizeConfig.blockSizeHorizontal*2,bottom: SizeConfig.blockSizeVertical),
                                  width: (SizeConfig.blockSizeVertical+SizeConfig.blockSizeHorizontal)*7,
                                  height: (SizeConfig.blockSizeVertical+SizeConfig.blockSizeHorizontal)*7,
                                  decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: new DecorationImage(
                                        fit: BoxFit.fill,
                                        image: new NetworkImage(
                                            snapshot.data)
                                      )
                                    )
                                ),
                                Stack(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(left:SizeConfig.blockSizeHorizontal*3,top: SizeConfig.blockSizeHorizontal*3),
                                      height: SizeConfig.blockSizeVertical*10,
                                      width: SizeConfig.blockSizeHorizontal*62,
                                      // color: Colors.blue,
                                      child: Text(chatshow.name,
                                          style: TextStyle(fontWeight: FontWeight.normal,fontSize: datasize.textScaleFactor*30,color: Colors.black), 
                                      ),
                                    ),
                                    StreamBuilder<DocumentSnapshot>(
                                      stream: Firestore.instance.collection('messagelast').document(chatshow.documentmessage).snapshots(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState == ConnectionState.waiting){
                                          return Container(
                                          );
                                        }
                                        if (snapshot.hasError){
                                          return Container(
                                          );
                                        }else{
                                          try{
                                            var messagelast = Messageshow.fromSnapshot(snapshot.data);
                                            if(messagelast.messagevalue != null){
                                              if(messagelast.ownmessage == Datamanager.user.documentid){
                                                return Container(
                                                  margin: EdgeInsets.only(top:SizeConfig.blockSizeVertical*7,left: SizeConfig.blockSizeHorizontal*3),
                                                  child: Text(UseString.you+" : " +messagelast.messagevalue+" - "+chatshow.arrivaltime.day.toString()+" "+monthy(chatshow.arrivaltime.month)+'.',
                                                    style: TextStyle(fontWeight: FontWeight.normal,fontSize: datasize.textScaleFactor*20,color: Colors.grey[600]), 
                                                  ),
                                                );
                                              }else{
                                                return Container(
                                                  margin: EdgeInsets.only(top:SizeConfig.blockSizeVertical*7,left: SizeConfig.blockSizeHorizontal*3),
                                                  child: Text(chatshow.name+" : " +messagelast.messagevalue+" - "+chatshow.arrivaltime.day.toString()+" "+monthy(chatshow.arrivaltime.month)+'.',
                                                    style: TextStyle(fontWeight: FontWeight.normal,fontSize: datasize.textScaleFactor*20,color: Colors.grey[600]), 
                                                  ),
                                                );
                                              }
                                            }else{
                                              return Container(
                                                margin: EdgeInsets.only(top:SizeConfig.blockSizeVertical*7,left: SizeConfig.blockSizeHorizontal*3),
                                                child: Text(chatshow.name +" "+UseString.sentimage+" - "+chatshow.arrivaltime.day.toString()+" "+monthy(chatshow.arrivaltime.month)+'.',
                                                  style: TextStyle(fontWeight: FontWeight.normal,fontSize: datasize.textScaleFactor*20,color: Colors.grey[600]), 
                                                ),
                                              );
                                            }
                                          }catch (error){
                                            return Container(
                                              margin: EdgeInsets.only(top:SizeConfig.blockSizeVertical*7,left: SizeConfig.blockSizeHorizontal*3),
                                              child: Text(UseString.sayhi+" " +chatshow.name,
                                                  style: TextStyle(fontWeight: FontWeight.normal,fontSize: datasize.textScaleFactor*20,color: Colors.grey[600]), 
                                                ),
                                            );
                                          }
                                        }
                                      }
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }
                        },
                      );
                    }
                  }
                ),
              ],
            ),
          ),
        ),
      );
    }
    Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
      SizeConfig().init(context);
      return ListView(
        padding: EdgeInsets.only(top:SizeConfig.blockSizeVertical),
        children: snapshot.map((data) => _buildListItem(context, data)).toList(),
      );
    }
    
    _buildBody(BuildContext context){
      return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('chat')
                                  .document(Datamanager.user.documentid)
                                  .collection('chatgroup')
                                  .orderBy('arrivaltime',descending: true)
                                  .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
             return Container(
              height: datasize.size.height/1.4,
              child: Center(
                child: Text(UseString.notfound,
                  style: TextStyle(fontWeight: FontWeight.normal,fontSize: datasize.textScaleFactor*36,color: Colors.white),
                ),
              ),
            );
          }else{
            // print(snapshot.data.documents);
            // return Container();
            return _buildList(context, snapshot.data.documents);
          }
        },
      );
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        flexibleSpace: Image(
            image: AssetImage('assets/images/imagesprofile/appbar/background.png'),
            fit: BoxFit.cover,
          ),
        centerTitle: true,
        title: Text(UseString.chatprofile,
            style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*25,color: Colors.white), 
        ),
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left,
          color: Colors.transparent,
          ),
          onPressed: () {
          },
        ),
      ),
      body: Stack(
        children: <Widget>[
          _buildBody(context),
        ],
      ),
    );
  }
}
