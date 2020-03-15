import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:mime_type/mime_type.dart';
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

import '../datamanager.dart';

class Messagepage extends StatefulWidget {
  final message = TextEditingController();
  var image;
  double min = 0;
  bool press = true;
  bool visible = false;
  Color more = Colors.white;
  Color moreicon = PickCarColor.colormain;
  int time1 =0;
  int time2 =0;
  int time3 =0;
  String imagelink = '';
  @override
  _MessagepageState createState() => _MessagepageState();
}

class _MessagepageState extends State<Messagepage> {
  GlobalKey<FormState> messagekey = GlobalKey<FormState>();
  @override
  void initState(){
    // widget.message.text = 'An';
    super.initState();
  }
  
  dispose() {
    // widget.message.dispose();
    super.dispose();
  }
  sentmessage(){
    Message message;
    if(widget.imagelink == ''){
      message = Message(
        arrivaltime: DateTime.now(),
        ownmessage: Datamanager.user.documentid,
        image: null,
        messagevalue: widget.message.text,
      );
    }else{
      message = Message(
        arrivaltime: DateTime.now(),
        ownmessage: Datamanager.user.documentid,
        image: widget.imagelink,
        messagevalue: null,
      );
    }
    Firestore.instance.collection('message')
                      .document(Datamanager.chatprofileshow.documentmessage)
                      .collection('messagegroup')
                      .add(message.toJson());
    Firestore.instance.collection('messagelast')
                      .document(Datamanager.chatprofileshow.documentmessage)
                      .setData(message.toJson());
    widget.imagelink ='';
    
  }
  Future uploadPic(BuildContext context) async{
    String contenttype;
    String basename = widget.image.path.split('/').last;
    StorageReference ref =
        Datamanager.firebasestorage.ref().child("message").child(Datamanager.chatprofileshow.documentmessage);
    StorageUploadTask uploadtask;
    contenttype = mime(widget.image.path);
    uploadtask = ref
        .child(basename)
        .putFile(widget.image, StorageMetadata(contentType: contenttype));
    await uploadtask.onComplete.whenComplete(() async {
      // print('aaa');
      widget.imagelink = await FirebaseStorage.instance.ref().child('message').child(Datamanager.chatprofileshow.documentmessage).child(basename).getDownloadURL();
      sentmessage();
    });
  }
  updatetime() async {
    var chatvalue = Chatprofilehasmessage(
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
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var datasize = MediaQuery.of(context);
    void confirmUpload(BuildContext context){
    showDialog(barrierDismissible: false,context: context,builder:  (BuildContext context){
      return AlertDialog(
        title: Center(
          child: Column(
            children: <Widget>[
              Text("Are you sure?",
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: datasize.textScaleFactor*30,color: PickCarColor.colorFont1), 
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 15),
                      child: RaisedButton(
                        color: PickCarColor.colorbuttom,
                        onPressed: () {
                          uploadPic(context);
                          Navigator.pop(context);
                        },
                        child: Text('Confirm',
                          // style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Color(0x78849E)),
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: datasize.textScaleFactor*15,color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      child: RaisedButton(
                      color: PickCarColor.colorbuttom,
                      onPressed: () {
                        Navigator.pop(context);
                        widget.image = '';
                      },
                      child: Text('Cancel',
                        // style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Color(0x78849E)),
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: datasize.textScaleFactor*15,color: Colors.white),
                      ),
                    ),
                    ),
                  ],
                ),
              ),
            ],
          ) 
        ) 
      );
    }
    );
  }
    Future getImageGallery() async {
      try{
      widget.image = await ImagePicker.pickImage(source: ImageSource.gallery);
      }catch(e){}
      if(widget.image !=null){
        confirmUpload(context);
      }
    }
    Future getImageCamera() async {
      try{
      widget.image = await ImagePicker.pickImage(source: ImageSource.camera);
      }catch(e){}
      if(widget.image !=null){
        confirmUpload(context);
      }
    }
    Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
      var messageshow = Messageshow.fromSnapshot(data);
      if(messageshow.image == null){
        if(messageshow.ownmessage == Datamanager.user.documentid){
        return Container(
          margin: EdgeInsets.only(top:SizeConfig.blockSizeVertical*1,right: SizeConfig.blockSizeHorizontal*3,left:SizeConfig.blockSizeHorizontal*15),
          alignment: Alignment.centerRight,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: PickCarColor.colormain,
            ),
            child: Container(
              margin: EdgeInsets.all(SizeConfig.blockSizeHorizontal*1.5),
              child: Text(messageshow.messagevalue,
                style: TextStyle(fontWeight: FontWeight.normal,fontSize: datasize.textScaleFactor*22,color: Colors.white),
              ),
            ),
          ),
        );
      }else{
        return Container(
          margin: EdgeInsets.only(top:SizeConfig.blockSizeVertical*1,left: SizeConfig.blockSizeHorizontal*3,right: SizeConfig.blockSizeHorizontal*8),
          alignment: Alignment.centerLeft,
          child: Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top:SizeConfig.blockSizeVertical/2),
                width: (SizeConfig.blockSizeHorizontal+SizeConfig.blockSizeVertical)*3,
                height: (SizeConfig.blockSizeHorizontal+SizeConfig.blockSizeVertical)*3,
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                      fit: BoxFit.cover,
                      image: new NetworkImage(
                          Datamanager.imageusershow)
                    )
                  )
              ),
              SizedBox(width: SizeConfig.blockSizeHorizontal,),
              Container(
                margin: EdgeInsets.only(left:SizeConfig.blockSizeHorizontal*9),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: Colors.grey[200],
                ),
                child: Container(
                  margin: EdgeInsets.all(SizeConfig.blockSizeHorizontal*1.5),
                  child: Text(messageshow.messagevalue,
                    style: TextStyle(fontWeight: FontWeight.normal,fontSize: datasize.textScaleFactor*22,color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        );
      }
      }else{
        var image = Image.network(messageshow.image);
        Completer<ui.Image> completer = Completer<ui.Image>();
        image.image
            .resolve(new ImageConfiguration())
            .addListener(ImageStreamListener((ImageInfo info, bool _) {
          completer.complete(info.image);
        }));
          // wait for ImageInfo to finish
        completer.future.then((data){
        });
        if(messageshow.ownmessage == Datamanager.user.documentid){
          // print('aaa');
        return Container(
          width: SizeConfig.blockSizeHorizontal*20,
          height: SizeConfig.blockSizeHorizontal*20,
          margin: EdgeInsets.only(top:SizeConfig.blockSizeVertical*1,right: SizeConfig.blockSizeHorizontal*3),
          alignment: Alignment.centerRight,
          child: Container(
            width: SizeConfig.blockSizeHorizontal*20,
            height: SizeConfig.blockSizeHorizontal*20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Colors.grey,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(messageshow.image),
              ),
            ),
          ),
        );
      }else{
        return FutureBuilder<ui.Image>(
            future: completer.future,
            builder: (BuildContext context, AsyncSnapshot<ui.Image> snapshot) {
              // print(snapshot.data.height);
              // print(snapshot.data.width);
              if (snapshot.hasData) {
                if(snapshot.data.height< snapshot.data.width){
                  return GestureDetector(
                    onTap: (){
                      // Imagesoom.image = NetworkImage(messageshow.image);
                      // Imagesoom.width = snapshot.data.width;
                      // Imagesoom.height = snapshot.data.height;
                      // Navigator.of(context).pushNamed(Datamanager.fullimage);
                    },
                    child: Container(
                      margin: EdgeInsets.only(top:SizeConfig.blockSizeVertical*1,left: SizeConfig.blockSizeHorizontal*3),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*18),
                            width: (SizeConfig.blockSizeHorizontal+SizeConfig.blockSizeVertical)*3,
                            height: (SizeConfig.blockSizeHorizontal+SizeConfig.blockSizeVertical)*3,
                            decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                  fit: BoxFit.fill,
                                  image: new NetworkImage(
                                      Datamanager.imageusershow)
                                )
                              )
                          ),
                          SizedBox(width: SizeConfig.blockSizeHorizontal,),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Colors.grey[200],
                            ),
                            child: Container(
                              width: SizeConfig.blockSizeHorizontal*70,
                              height: SizeConfig.blockSizeHorizontal*40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: Colors.grey,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(messageshow.image),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }else{
                  return GestureDetector(
                    onTap: (){
                      // Imagesoom.image = NetworkImage(messageshow.image);
                      // Imagesoom.width = snapshot.data.width;
                      // Imagesoom.height = snapshot.data.height;
                      // Navigator.of(context).pushNamed(Datamanager.fullimage);
                    },
                    child: Container(
                      margin: EdgeInsets.only(top:SizeConfig.blockSizeVertical*1,left: SizeConfig.blockSizeHorizontal*3),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*28),
                            width: (SizeConfig.blockSizeHorizontal+SizeConfig.blockSizeVertical)*3,
                            height: (SizeConfig.blockSizeHorizontal+SizeConfig.blockSizeVertical)*3,
                            decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                  fit: BoxFit.fill,
                                  image: new NetworkImage(
                                      Datamanager.imageusershow)
                                )
                              )
                          ),
                          SizedBox(width: SizeConfig.blockSizeHorizontal,),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Colors.grey[200],
                            ),
                            child: Container(
                              width: SizeConfig.blockSizeHorizontal*40,
                              height: SizeConfig.blockSizeHorizontal*60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: Colors.grey,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(messageshow.image),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                
              } else {
                return Container();
              }
            },
          );
        }
      }
      
    }
    Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
      SizeConfig().init(context);
      return ListView(
        reverse: true,
        padding: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical*10),
        children: snapshot.map((data) => _buildListItem(context, data)).toList(),
      );
    }
    
    _buildBody(BuildContext context){
      return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('message')
                                  .document(Datamanager.chatprofileshow.documentmessage)
                                  .collection('messagegroup')
                                  .orderBy('arrivaltime',descending: true).snapshots(),
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
    var data = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        flexibleSpace: Image(
            image: AssetImage('assets/images/imagesprofile/appbar/background.png'),
            fit: BoxFit.cover,
          ),
        centerTitle: true,
        title: Text(Datamanager.usershow.name,
            style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*25,color: Colors.white), 
        ),
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left,
          color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: <Widget>[
          _buildBody(context),
        ],
      ),
      bottomSheet:Form(
        key: messagekey,
        child: Container(
          width: SizeConfig.screenWidth,
          height: SizeConfig.blockSizeVertical*8,
          // color: Colors.blue,
          child: Stack(
            children: <Widget>[
              Container(
                width: SizeConfig.blockSizeHorizontal*15,
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      if(widget.press){
                        widget.press = !widget.press;
                        widget.min = 70;
                        widget.more = PickCarColor.colormain;
                        widget.moreicon = Colors.white;
                        widget.visible = true;
                        widget.time1 = 700;
                        widget.time2 = 900;
                        widget.time3 = 1100;
                      }else{
                        widget.press = !widget.press;
                        widget.min = 0;
                        widget.more = Colors.white;
                        widget.moreicon = PickCarColor.colormain;
                        widget.visible = false;
                        widget.time3 = 100;
                        widget.time2 = 200;
                        widget.time1 = 350;
                      }
                    });
                  },
                  child: Stack(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(SizeConfig.blockSizeHorizontal*2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: widget.more,
                        ),
                      ),
                      Center(child: Icon(Icons.more_horiz,color: widget.moreicon,size: SizeConfig.blockSizeHorizontal*7,)),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left:SizeConfig.blockSizeHorizontal*13),
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                        getImageCamera();
                      },
                      child: AnimatedOpacity(
                        opacity: widget.visible ? 1.0 : 0.0,
                        duration: Duration(milliseconds: widget.time1),
                        child: Container(
                          margin: EdgeInsets.only(top:SizeConfig.blockSizeHorizontal*3),
                          child: Icon(Icons.camera_alt,color: PickCarColor.colormain,size: SizeConfig.blockSizeHorizontal*9,),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        getImageGallery();
                      },
                      child: AnimatedOpacity(
                        opacity: widget.visible ? 1.0 : 0.0,
                        duration: Duration(milliseconds: widget.time2),
                        child: Container(
                          margin: EdgeInsets.only(top:SizeConfig.blockSizeHorizontal*3),
                          child: Icon(Icons.photo_library,color: PickCarColor.colormain,size: SizeConfig.blockSizeHorizontal*9,),
                        ),
                      ),
                    ),
                    // AnimatedOpacity(
                    //   opacity: widget.visible ? 1.0 : 0.0,
                    //   duration: Duration(milliseconds: widget.time3),
                    //   child: Container(
                    //     margin: EdgeInsets.only(top:SizeConfig.blockSizeHorizontal*3),
                    //     child: Icon(Icons.location_on,color: PickCarColor.colormain,size: SizeConfig.blockSizeHorizontal*9,),
                    //   ),
                    // ),
                  ],
                ),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                margin: EdgeInsets.only(left:SizeConfig.blockSizeHorizontal*15+widget.min),
                alignment: Alignment.centerRight,
                width: SizeConfig.blockSizeHorizontal*85-widget.min,
                child: Stack(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(SizeConfig.blockSizeHorizontal*1),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(25)
                      ),
                      child: Stack(
                        children: <Widget>[
                        Container(
                            margin: EdgeInsets.only(right:SizeConfig.blockSizeHorizontal*3),
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              child: Icon(Icons.send,color: PickCarColor.colormain,),
                              onTap: (){
                                if(widget.message.text != ''){
                                  sentmessage();
                                  updatetime();
                                }
                                widget.message.text = '';
                              },
                            ),
                          ),
                          Container(
                            width: SizeConfig.blockSizeHorizontal*70,
                            margin: EdgeInsets.only(left:SizeConfig.blockSizeHorizontal*3),
                            // color: Colors.blue,
                            child: TextFormField(
                              onTap: (){
                                setState(() {
                                  if(!widget.press){
                                    widget.press = true;
                                    widget.min = 0;
                                    widget.more = Colors.white;
                                    widget.moreicon = PickCarColor.colormain;
                                    widget.visible = false;
                                    widget.time3 = 100;
                                    widget.time2 = 200;
                                    widget.time1 = 350;
                                  }
                                });
                              },
                              // initialValue:widget.message.text,
                              controller: widget.message,
                              // obscureText: true,
                              // keyboardType: TextInputType.visiblePassword,
                              //onSaved: (val) => password = val,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  hintText: 'An',
                                ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
