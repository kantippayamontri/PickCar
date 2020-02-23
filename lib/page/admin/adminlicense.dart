import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pickcar/datamanager.dart';
import 'package:pickcar/models/listcarslot.dart';
import 'package:pickcar/page/tabscreen.dart';
import 'package:pickcar/ui/uisize.dart';
import 'package:pickcar/widget/home/cardrental.dart';
int i=0;
class Adminlicense extends StatefulWidget {
  bool loading = false;
  String name = "";
  var image;
  String typelicense = 'driver';
  Function gotosearchinHome;
  var license = true;
  Color licensedriver = PickCarColor.colormain;
  Color licensecar = PickCarColor.colorbuttom;
  Usershow userdata;
  MotorcycleShow motordata;
  @override
  _AdminlicenseState createState() => _AdminlicenseState();
}

class _AdminlicenseState extends State<Adminlicense> {
  AppBar appbar;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var datasize = MediaQuery.of(context);
     Widget _buildListItemdriver(BuildContext context, DocumentSnapshot data) {
      //  Color colorselect = Color.fromARGB(0, 255, 255, 255);
      var usershow = Usershow.fromSnapshot(data);
      loadpicture() async {
        var maxSize = 7*1024*1024;
              final StorageReference ref = FirebaseStorage.instance.ref()
              .child("User")
              .child(usershow.uid);
              await ref.child(usershow.driveliscensecarpath+"." + usershow.driveliscensecarpictype).getData(maxSize).then((data){
                widget.image = data;
              }).whenComplete((){
                print('aaa');
                setState(() {
                  widget.loading = false;
                  widget.name = usershow.name;
                  widget.userdata = usershow;
                });
              });
      }
      if(usershow.driveliscensecarpath != null && usershow.driveliscensecarpictype != null){
        return GestureDetector(
          onTap: (){
            setState(() {
              loadpicture();
              widget.loading = true;
            });
            // Future.delayed(const Duration(milliseconds: 2000), () {
              
            // });
          },
          child: Container(
            margin: EdgeInsets.only(top:SizeConfig.blockSizeVertical,bottom: SizeConfig.blockSizeVertical,left:SizeConfig.blockSizeHorizontal*3,right:SizeConfig.blockSizeHorizontal*3),
            width: SizeConfig.screenWidth,
            height: SizeConfig.blockSizeVertical*10,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color.fromARGB(60, 255, 255, 255),
            ),
            child: Stack(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(top:SizeConfig.blockSizeVertical,left:SizeConfig.blockSizeHorizontal*3),
                  width: SizeConfig.blockSizeHorizontal*40,
                  height: SizeConfig.blockSizeVertical*8,
                  // color: Colors.blue,
                  child: Text(usershow.name,
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: datasize.textScaleFactor*28,color: Colors.black), 
                  ),
                ),
              ],
            ),
          ),
        );
      }else{
        return Container();
      }
      
    }
    Widget _buildListdriver(BuildContext context, List<DocumentSnapshot> snapshot) {
      SizeConfig().init(context);
      return ListView(
        padding: EdgeInsets.only(top:SizeConfig.blockSizeVertical),
        children: snapshot.map((data) => _buildListItemdriver(context, data)).toList(),
      );
    }
    _buildBodydriver(BuildContext context){
      return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('User')
                                  .where('isapprove', isEqualTo: 'wait')
                                  .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
             return Container(
            );
          }else{
            // print(snapshot.data.documents);
            // return Container();
            return _buildListdriver(context, snapshot.data.documents);
          }
        },
      );
    }
    Widget _buildListItemcar(BuildContext context, DocumentSnapshot data) {
      var motorshow = MotorcycleShow.fromSnapshot(data);
      Usershow usershow;
      return GestureDetector(
        onTap: (){
          setState(() {
            widget.image = motorshow.motorownerliscenselink;
            widget.name = usershow.name;
            widget.userdata = usershow;
            widget.motordata = motorshow;
          });
        },
        child: Container(
          margin: EdgeInsets.only(top:SizeConfig.blockSizeVertical,bottom: SizeConfig.blockSizeVertical,left:SizeConfig.blockSizeHorizontal*3,right:SizeConfig.blockSizeHorizontal*3),
          width: SizeConfig.screenWidth,
          height: SizeConfig.blockSizeVertical*10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color.fromARGB(60, 255, 255, 255),
          ),
          child: Stack(
            children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(top:SizeConfig.blockSizeVertical,left:SizeConfig.blockSizeHorizontal*3),
                width: SizeConfig.blockSizeHorizontal*88,
                height: SizeConfig.blockSizeVertical*4,
                // color: Colors.blue,
                child: Text(motorshow.brand +" " + motorshow.generation,
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: datasize.textScaleFactor*24,color: Colors.black), 
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection('User')
                                          .where('uid', isEqualTo: motorshow.owneruid)
                                          .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container(
                    );
                  }else{
                    var datadocument;
                    snapshot.data.documents.map((data){
                      datadocument = data;
                    }).toList();
                    usershow = Usershow.fromSnapshot(datadocument);
                    // print(snapshot.data.documents);
                    // return Container();
                    return Container(
                      margin: EdgeInsets.only(top:SizeConfig.blockSizeVertical*5,left:SizeConfig.blockSizeHorizontal*3),
                      width: SizeConfig.blockSizeHorizontal*88,
                      height: SizeConfig.blockSizeVertical*4,
                      // color: Colors.blue,
                      child: Text('By '+usershow.name,
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: datasize.textScaleFactor*24,color: Colors.black), 
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      );
    }
    Widget _buildListcar(BuildContext context, List<DocumentSnapshot> snapshot) {
      SizeConfig().init(context);
      return ListView(
        padding: EdgeInsets.only(top:SizeConfig.blockSizeVertical),
        children: snapshot.map((data) => _buildListItemcar(context, data)).toList(),
      );
    }
    _buildBodycar(BuildContext context){
      return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('Motorcycle')
                                  .where('isapprove', isEqualTo: 'wait')
                                  .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
             return Container(
            );
          }else{
            // print(snapshot.data.documents);
            // return Container();
            return _buildListcar(context, snapshot.data.documents);
          }
        },
      );
    }
    imageforapprove(BuildContext context){
      if(widget.loading){
        return Container(
          color: PickCarColor.colormain,
          child: SpinKitCircle(
            color: Colors.white,
          )
        );
      }else{
        if(widget.typelicense =='driver'){
          if(widget.image == null){
            return Center(child: Text("No select data"));
          }else{
            return Image.memory(widget.image,fit: BoxFit.cover);
          }
        }else{
          if(widget.image == null){
            return Center(child: Text("No select data"));
          }else{
            return Image.network(widget.image,fit: BoxFit.fill,
              loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
              if (loadingProgress == null) return child;
                return Container(
                  color: PickCarColor.colormain,
                  child: SpinKitCircle(
                    color: Colors.white,
                  )
                );
              },
            );
            // return Image.network(widget.image,fit: BoxFit.cover);
          }
        }
      }
    }
    void confirmApprove(BuildContext context,String type,Color color){
      showDialog(barrierDismissible: false,context: context,builder:  (BuildContext context){
        return AlertDialog(
          title: Center(
            child: Column(
              children: <Widget>[
                Text(UseString.areyou+" "+type+"?",
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: SizeConfig.blockSizeHorizontal*5,color: color), 
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*4),
                        child: RaisedButton(
                          color: color,
                          onPressed: () {
                            if(widget.typelicense == "driver"){
                              Firestore.instance.collection('User')
                                                .document(widget.userdata.documentid).updateData({'isapprove':type}).whenComplete((){
                                                  setState(() {
                                                    widget.image = null;
                                                    widget.name = '';
                                                    widget.userdata =null;
                                                    widget.motordata = null;
                                                  });
                                                });
                            }
                            if(widget.typelicense == "car"){
                              Firestore.instance.collection('Motorcycle')
                                              .document(widget.motordata.firestoredocid).updateData({'isapprove':type}).whenComplete((){
                                                setState(() {
                                                  widget.image = null;
                                                    widget.name = '';
                                                    widget.userdata =null;
                                                    widget.motordata = null;
                                                });
                                              });
                          }
                            Navigator.pop(context);
                          },
                          child: Text('Confirm',
                            // style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Color(0x78849E)),
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: datasize.textScaleFactor*15,color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*4),
                        child: RaisedButton(
                        color: color,
                        onPressed: () {
                          Navigator.pop(context);
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
  showwarning(BuildContext context){
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(UseString.pleaseselecttitle),
          content: Text(UseString.pleaseselectdetail),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
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
        title: Text(UseString.license,
            style: TextStyle(fontWeight: FontWeight.bold,fontSize: datasize.textScaleFactor*25,color: Colors.white), 
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
      body: Column(
        children: <Widget>[
          Container(
            height: SizeConfig.blockSizeVertical*58.2,
            width: SizeConfig.screenWidth,
            // color: Colors.black,
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left:SizeConfig.blockSizeHorizontal*3),
                  height: SizeConfig.blockSizeVertical*9.2,
                  // color: Colors.black,
                  width: SizeConfig.screenWidth,
                  alignment: Alignment.centerLeft,
                  child: Text("Name: "+widget.name,
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: datasize.textScaleFactor*25,color: Colors.black), 
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top:SizeConfig.blockSizeVertical*9.1,left: SizeConfig.blockSizeHorizontal*5),
                  height: SizeConfig.blockSizeVertical*40,
                  width: SizeConfig.blockSizeHorizontal*90,
                  // color: PickCarColor.colormain,
                  child:imageforapprove(context),
                ),
                Container(
                  margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*50.1,left: SizeConfig.blockSizeHorizontal*20),
                  // color: Colors.black,
                  child: Row(
                    children: <Widget>[
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                          // side: BorderSide(color: Colors.red)
                        ),
                        color: PickCarColor.colorbuttom,
                        onPressed: (){
                          if(widget.userdata != null){
                            confirmApprove(context,'Approve',PickCarColor.colormain);
                          }else{
                            showwarning(context);
                          }
                          
                        },
                        child: Text(UseString.approve,
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: datasize.textScaleFactor*25,color: Colors.white), 
                        ),
                      ),
                      SizedBox(width: SizeConfig.blockSizeHorizontal*2,),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                          // side: BorderSide(color: Colors.red)
                        ),
                        color: Colors.red,
                        onPressed: (){
                          if(widget.userdata != null){
                            confirmApprove(context,'Reject',Colors.red);
                          }else{
                            showwarning(context);
                          }
                          
                        },
                        child: Text(UseString.reject,
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: datasize.textScaleFactor*25,color: Colors.white), 
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Container(
                height: SizeConfig.blockSizeVertical*6,
                width: SizeConfig.screenWidth,
                // color: Colors.blue,
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          widget.image = null;
                          widget.typelicense = 'driver';
                          widget.license = true;
                          widget.licensedriver = PickCarColor.colormain;
                          widget.licensecar = PickCarColor.colorbuttom;
                        });
                      },
                      child: Container(
                        height: SizeConfig.blockSizeVertical*6,
                        width: SizeConfig.screenWidth/2,
                        color: widget.licensedriver,
                        child: Center(
                          child: Text('Driver License',
                              style: TextStyle(fontWeight: FontWeight.bold,fontSize: datasize.textScaleFactor*22,color: Colors.white), 
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          widget.typelicense = 'car';
                          widget.image = null;
                          widget.license = false;
                          widget.licensedriver = PickCarColor.colorbuttom;
                          widget.licensecar = PickCarColor.colormain;
                          widget.name ='';
                        });
                      },
                      child: Container(
                        alignment: Alignment.centerRight,
                        height: SizeConfig.blockSizeVertical*6,
                        width: SizeConfig.screenWidth/2,
                        color: widget.licensecar,
                        child: Center(
                          child: Text('Vehicle registration',
                              style: TextStyle(fontWeight: FontWeight.bold,fontSize: datasize.textScaleFactor*22,color: Colors.white), 
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Visibility(
            visible: widget.license,
            child: Container(
              height: SizeConfig.blockSizeVertical*24,
              width: SizeConfig.screenWidth,
              color: PickCarColor.colormain,
              child: Stack(
                children: <Widget>[
                  _buildBodydriver(context),
                ],
              ),
            ),
          ),
          Visibility(
            visible: !widget.license,
            child: Container(
              height: SizeConfig.blockSizeVertical*24,
              width: SizeConfig.screenWidth,
              color: PickCarColor.colormain,
              child: Stack(
                children: <Widget>[
                  _buildBodycar(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
