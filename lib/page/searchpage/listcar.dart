
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pickcar/datamanager.dart';
import 'package:pickcar/models/boxlocation.dart';
import 'package:pickcar/models/chat.dart';
import 'package:pickcar/models/listcarslot.dart';
import 'package:pickcar/models/placelocation.dart';
import 'package:pickcar/page/chatpage.dart';
import 'package:pickcar/ui/uisize.dart';
import 'package:pickcar/widget/profile/profileImage.dart';

import '../../datamanager.dart';
import '../../datamanager.dart';
import '../../datamanager.dart';
class Listcar extends StatefulWidget {
  int countnotfound = 0;
  int totalnotfound = 0;
  int day = TimeSearch.today.day;
  String university = SearchString.university;
  @override
  _ListcarState createState() => _ListcarState();
}

class _ListcarState extends State<Listcar> {
  @override
  void initState() {
    DataFetch.waitplace =0;
    DataFetch.fetchpiority = 0;
    DataFetch.checkhavedata = 0;
    DataFetch.checknotsamenoresult = 99;
    DataFetch.checknothaveslottime = 0;
    Datamanager.placelocationshow = null;
    Datamanager.motorcycleShow = null;
    Datamanager.usershow= null;
    Datamanager.listcarslot= null;
    Datamanager.slottime= null;
    // Datamanager.slottime =null;
    super.initState();
  }
  loaddatatype(){
    var time;
    if(TimeSearch.time1){
      time = "8.00 - 9.15";
    }else if(TimeSearch.time2){
      time = "9.30 - 10.45";
    }else if(TimeSearch.time3){
      time = "11.00 - 12.15";
    }else if(TimeSearch.time4){
      time = "13.00 - 14.15";
    }else if(TimeSearch.time5){
      time = "14.30 - 15.45";
    }else{
      time = "16.00 - 17.30";
    }
    if(SearchString.type == UseString.rent1){
      return Firestore.instance.collection('Singleforrent')
                      .where("day", isEqualTo: widget.day)
                      .where('iscancle',isEqualTo: false)
                      .where("motorplacelocdocid", isEqualTo: Datamanager.placelocationshow.docplaceid)
                      .where("time", isEqualTo: time)
                      .snapshots();
    }else if(SearchString.type == UseString.rent2){
      return Firestore.instance.collection('Singleforrent')
                      .where('iscancle',isEqualTo: false)
                      .where("day", isEqualTo: widget.day)
                      // .where("motorplacelocdocid", isEqualTo: Datamanager.placelocationshow.docplaceid)
                      .snapshots();
    }else{
      return Firestore.instance.collection('Singleforrent')
                      .where("day", isEqualTo: widget.day)
                      .where('iscancle',isEqualTo: false)
                      // .where("motorplacelocdocid", isEqualTo: Datamanager.placelocationshow.docplaceid)
                      .snapshots();
    }
    
  }
  fetchlocation(){
    if(DataFetch.fetchpiority == 0){
      Datamanager.firestore.collection('placelocation')
                          .where("name", isEqualTo: SearchString.location)
                          .getDocuments()
                          .then((data){
                            data.documents.map((datadoc){
                              DataFetch.waitplace =1;
                              Datamanager.placelocationshow = PlacelocationShow.fromSnapshot(datadoc);
                            }).toList();
                          });            
    }
  }
  wait(){
    Future.delayed(const Duration(milliseconds: 1000), () {
      print('wait');
      DataFetch.waitplace = 1;
      setState(() {
      });
    });
  }
  Widget build(BuildContext context) {
    SizeConfig();
    fetchlocation();
    var datasize = MediaQuery.of(context);
    // print(Datamanager.placelocationshow);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Container(
          width: SizeConfig.blockSizeHorizontal*20,
          child: Image.asset('assets/images/imagelogin/logo.png',fit: BoxFit.fill,)
        ),
        backgroundColor: Colors.transparent, 
        elevation: 0.0, 
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left,
          color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
            DataFetch.waitplace = 0;
          },
          // tooltip: 'Share',
        ),
      ),
      backgroundColor: PickCarColor.colormain,
      body: Stack(
        children: <Widget>[
          _buildBody(context),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    var datasize = MediaQuery.of(context);
    if(DataFetch.waitplace == 0){
      wait();
      return Center(
        child: Container(
          width: datasize.size.width,
          height: datasize.size.height,
          color: PickCarColor.colormain,
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 120),
                child: SpinKitCircle(
                  color: Colors.white,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                child:  Text(UseString.searching,
                  style: TextStyle(fontWeight: FontWeight.normal,fontSize: datasize.textScaleFactor*25,color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      );
    }else{
      return StreamBuilder<QuerySnapshot>(
        stream: loaddatatype(),
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
  }
 

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    widget.totalnotfound = snapshot.length;
    if(widget.totalnotfound > 0){
      return ListView(
        padding: const EdgeInsets.only(top: 20.0),
        children: snapshot.map((data) => _buildListItem(context, data)).toList(),
      );
    }else{
      var datasize = MediaQuery.of(context);
      return Container(
          height: datasize.size.height/1.4,
          child: Center(
            child: Text(UseString.notfound,
              style: TextStyle(fontWeight: FontWeight.normal,fontSize: datasize.textScaleFactor*36,color: Colors.white),
            ),
          ),
        );
    }
  }
  
  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    var datasize = MediaQuery.of(context);
    final timeslot = Listcarslot.fromSnapshot(data);
    Firestore.instance.collection('boxlocation')
                          .document(timeslot.boxplacedocid).get()
                          .then((data){
                            Datamanager.boxlocationshow = BoxlocationShow.fromSnapshot(data);
                          });
    var imageusershow;
    MotorcycleShow motorshow;
    Usershow usershow;
    Future<DocumentSnapshot> fetchdatamotorcycle(String docid) async {
    return await Datamanager.firestore.collection('Motorcycle')
                          .document(docid)
                          .get();
    }
    Future<String> _getImage(BuildContext context,Usershow usershow) async {
     return await FirebaseStorage.instance
                                  .ref()
                                  .child('User')
                                  .child(usershow.uid)
                                  .child(usershow.profilepicpath+'.'+usershow.profilepictype).getDownloadURL();
    }
    // addgroupchat(Usershow usershow){
    //   Datamanager.firestore.collection('chat')
    //                         .document(Datamanager.user.documentchat)
    //                         .collection('groupchat').document(usershow.documentid);
    // }
    // print(Datamanager.user.documentid + ' '+timeslot.university+' '+timeslot.ownerdocid);
    // print(Datamanager.placelocationshow);
    if( timeslot.ownerdocid != Datamanager.user.documentid && timeslot.university == widget.university){
          return GestureDetector(
            onTap: (){
              Datamanager.usershow = usershow;
              Datamanager.motorcycleShow = motorshow;
              Datamanager.listcarslot = timeslot;
              Datamanager.usershow.imageurl = imageusershow;
              Navigator.of(context).pushNamed(Datamanager.detailsearch);
            },
            child: FutureBuilder<DocumentSnapshot>(
            future: fetchdatamotorcycle(timeslot.motorcycledocid), 
            builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if( snapshot.connectionState == ConnectionState.waiting){
                  return Stack(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            //  color: Colors.black,
                          ),
                          width: datasize.size.width,
                          height: 300,
                          child: Image.asset('assets/images/imagesearch/background.png',fit: BoxFit.fill,),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20,left: 30),
                          color: Colors.grey,
                          width: 320,
                          height: 26,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 60,top: 58),
                          color: Colors.grey[600],
                          width: 190,
                          height: 160,
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 228,left: 20),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(left: 10),
                                    width: 45,
                                    height: 45,
                                    decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey,
                                      )
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 10),),
                                Container(
                                  color: Colors.grey,
                                  width: 140,
                                  height: 30,
                                ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 230,left: 30),
                              width: 120,
                              height: 30,
                              color: Colors.grey,
                            ),
                          ],
                        ),


                        Container(
                          margin: EdgeInsets.only(left: 270,top: 60),
                          width: 50,
                          height: 20,
                          color: Colors.grey,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 280,top: 88),
                          child: Column(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(top: 8),
                                height: 20,
                                width: 100,
                                color: Colors.grey,
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 8),
                                height: 20,
                                width: 100,
                                color: Colors.grey,
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 8),
                                height: 20,
                                width: 100,
                                color: Colors.grey,
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 8),
                                height: 20,
                                width: 100,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
              }else{
                  if (snapshot.hasError)
                    return Center(child: Text('Error: ${snapshot.error}'));
                  else{
                    motorshow = MotorcycleShow.fromSnapshot(snapshot.data);
                    // print(motorshow.generation+' '+ motorshow.brand);
                    return Stack(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            //  color: Colors.black,
                          ),
                          width: datasize.size.width,
                          height: 300,
                          child: Image.asset('assets/images/imagesearch/background.png',fit: BoxFit.fill,),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20,left: 30),
                          child: Text(motorshow.brand+" "+motorshow.generation),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 30,top: 75),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            //  color: Colors.black,
                            image: new DecorationImage(
                                              fit: BoxFit.fill,
                                              image: new NetworkImage(
                                                  motorshow.motorleftlink)
                                            )
                          ),
                          width: 220,
                          height: 140,
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              width: 350,
                              height: 50,
                              margin: EdgeInsets.only(left: 20,top: 228),
                              // color: Colors.black,
                              child:  GestureDetector(
                                onTap: () async {
                                  Datamanager.imageusershow = imageusershow;
                                  // addgroupchat(usershow);
                                  Datamanager.usershow = usershow;
                                  Datamanager.motorcycleShow = motorshow;
                                  Datamanager.listcarslot = timeslot;
                                  var chatvalue;
                                  var check = await Firestore.instance.collection('chat')
                                            .document(Datamanager.user.documentid)
                                            .collection('chatgroup')
                                            .document(Datamanager.usershow.documentid).get();
                                  if(check.data == null){
                                    var message = Firestore.instance.collection('message').document();
                                    chatvalue = Chatprofile(
                                      documentcontact: Datamanager.usershow.documentid,
                                      name: Datamanager.usershow.name,
                                      arrivaltime: DateTime.now(),
                                      documentmessage: message.documentID,
                                    );
                                    await Firestore.instance.collection('chat')
                                            .document(Datamanager.user.documentid)
                                            .collection('chatgroup')
                                            .document(Datamanager.usershow.documentid)
                                            .setData(chatvalue.toJson());
                                    await Firestore.instance.collection('chat')
                                              .document(Datamanager.usershow.documentid)
                                              .collection('chatgroup')
                                              .document(Datamanager.user.documentid)
                                              .setData(chatvalue.toJson());
                                  }else{
                                    chatvalue = Chatprofilehasmessage(
                                      documentcontact: Datamanager.usershow.documentid,
                                      name: Datamanager.usershow.name,
                                      arrivaltime: DateTime.now(),
                                    );
                                     await Firestore.instance.collection('chat')
                                            .document(Datamanager.user.documentid)
                                            .collection('chatgroup')
                                            .document(Datamanager.usershow.documentid)
                                            .updateData(chatvalue.toJson());
                                    await Firestore.instance.collection('chat')
                                              .document(Datamanager.usershow.documentid)
                                              .collection('chatgroup')
                                              .document(Datamanager.user.documentid)
                                              .updateData(chatvalue.toJson());
                                  }
                                  Firestore.instance.collection('chat')
                                            .document(Datamanager.user.documentid)
                                            .collection('chatgroup')
                                            .document(Datamanager.usershow.documentid).get().then((data){
                                              var a = Chatprofileshow.fromSnapshot(data);
                                              // print(a.documentmessage);
                                              Datamanager.chatprofileshow = Chatprofileshow.fromSnapshot(data);
                                              Navigator.of(context).pushNamed(Datamanager.messagepage);
                                            });
                                  // print(Datamanager.chatprofileshow.documentmessage);
                                },
                                child: StreamBuilder<QuerySnapshot>(
                                  stream: Firestore.instance.collection('User').where("uid", isEqualTo: motorshow.owneruid).snapshots(),
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
                                      return Stack(
                                        children: <Widget>[
                                          Container(
                                            width: 350,
                                            height: 45,
                                            color: Colors.transparent,
                                          ),
                                          FutureBuilder(
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
                                                      margin: EdgeInsets.only(left: 10),
                                                      child: Text(UseString.forrent,
                                                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: datasize.textScaleFactor*20,color: PickCarColor.colorcmu),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(left: 10),
                                                      width: 45,
                                                      height: 45,
                                                      decoration: new BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        image: new DecorationImage(
                                                            fit: BoxFit.fill,
                                                            image: new NetworkImage(
                                                                snapshot.data)
                                                          )
                                                        )
                                                    ),
                                                    Padding(padding: EdgeInsets.only(left: 10),),
                                                    Text(usershow.name,
                                                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: datasize.textScaleFactor*25,color: PickCarColor.colorcmu),
                                                    ),
                                                  ],
                                                );
                                              }
                                            },
                                          ),
                                        ],
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 270,top: 60),
                          child: Text(UseString.detail,
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: datasize.textScaleFactor*18,color: PickCarColor.colorFont2),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 280,top: 88),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    height: 25,
                                    width: 25,
                                    child: Image.asset('assets/images/imagesearch/gears.png',fit: BoxFit.fill,),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 2),
                                    child: Text(motorshow.gear+' ',
                                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: datasize.textScaleFactor*16,color: PickCarColor.colorFont2),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(top: 5),
                                    height: 25,
                                    width: 25,
                                    child: Image.asset('assets/images/imagesearch/cc.png',fit: BoxFit.fill,),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 2,top: 5),
                                    child: Text(motorshow.cc.toString()+' '+UseString.cc,
                                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: datasize.textScaleFactor*16,color: PickCarColor.colorFont2),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(top: 5),
                                    height: 25,
                                    width: 25,
                                    child: Image.asset('assets/images/imagesearch/gas.png',fit: BoxFit.fill,),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 2,top: 5),
                                    child: Text(motorshow.motorgas.toString(),
                                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: datasize.textScaleFactor*16,color: PickCarColor.colorFont2),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(top: 5),
                                    height: 25,
                                    width: 25,
                                    child: Image.asset('assets/images/imagesearch/color.png',fit: BoxFit.fill,),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 2,top: 5),
                                    child: Text(motorshow.color.toString(),
                                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: datasize.textScaleFactor*16,color: PickCarColor.colorFont2),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
              }
            },
          ),
        );
    }else{
      widget.countnotfound++;
      print(widget.countnotfound);
      print(widget.totalnotfound);
      if(widget.countnotfound == widget.totalnotfound){
        return Container(
          height: datasize.size.height/1.4,
          child: Center(
            child: Text(UseString.notfound,
              style: TextStyle(fontWeight: FontWeight.normal,fontSize: datasize.textScaleFactor*36,color: Colors.white),
            ),
          ),
        );
      }else{
        return Container();
      }
    }
  }
}


