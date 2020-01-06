import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mime_type/mime_type.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:pickcar/bloc/profile/editprofile/editprofilebloc.dart';
import 'package:pickcar/bloc/profile/editprofile/editprofileevent.dart';
import 'dart:typed_data';
import 'dart:async';

import 'package:pickcar/datamanager.dart';
import 'package:pickcar/widget/profile/profileImage.dart';
class EditProfile extends StatefulWidget {
  int i =0;
 @override
 _EditProfileState createState() {
   return _EditProfileState();
 }
}
class _EditProfileState extends State<EditProfile> {
  File _image;
  File profile;
  File motordri;
  File idcard;
  File universitycard;
  Uint8List imagefile;
  var _editprofilebloc;
  @override
  void initState() {
    _editprofilebloc = EditProfilebloc(context);
  }
 @override
 Widget build(BuildContext context) {
  final data = MediaQuery.of(context);
  void confirmUpload(BuildContext context,String type){
    showDialog(context: context,builder:  (BuildContext context){
      return AlertDialog(
        title: Center(
          child: Column(
            children: <Widget>[
              Text("Are you sure?",
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*30,color: PickCarColor.colorFont1), 
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 15),
                      child: RaisedButton(
                        color: Colors.lightBlue,
                        onPressed: () {
                          if(type == "profileimg"){
                            _editprofilebloc.add(ChangeProfileImage(context,profile));
                          }else if(type == "motorliscense"){
                            _editprofilebloc.add(ChangeDriMotor(context,motordri));
                          }else if(type == "idcard"){
                            _editprofilebloc.add(ChangeIDCardImage(context,idcard));
                          }else if(type == "universitycard"){
                            _editprofilebloc.add(ChangeUniversityCardImage(context,universitycard));
                          } 
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: Text('Confirm',
                          // style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Color(0x78849E)),
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*15,color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      child: RaisedButton(
                      color: Colors.lightBlue,
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        setState((){
                          if(type == "profileimg"){
                            profile = null;
                          }else if(type == "motorliscense"){
                            motordri = null;
                          }else if(type == "idcard"){
                            idcard = null;
                          }else if(type == "universitycard"){
                            universitycard = null;
                          }
                        });
                      },
                      child: Text('Cancle',
                        // style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Color(0x78849E)),
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*15,color: Colors.white),
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
  Future getImageGallery(String type) async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if(type == "profileimg"){
        profile = image;
      }else if(type == "motorliscense"){
        motordri = image;
      }else if(type == "idcard"){
        idcard = image;
      }else if(type == "universitycard"){
        universitycard = image;
      } 
        print('Image Path $image');
        if(image != null){
          confirmUpload(context,type);
        }else{
          Navigator.pop(context);
        }
        // uploadPic(context);
    });
  }
  Future getImageCamera(String type) async {
  var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      if(type == "profileimg"){
        profile = image;
      }else if(type == "motorliscense"){
        motordri = image;
      }else if(type == "idcard"){
        idcard = image;
      }else if(type == "universitycard"){
        universitycard = image;
      } 
        print('Image Path $image');
        if(image != null){
          confirmUpload(context,type);
        }else{
          Navigator.pop(context);
        }
        // uploadPic(context);
    });
  }
  Column listColumn(String type){
    return Column(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.camera_alt),
          title: Text(UseString.camera),
          onTap: (){
            getImageCamera(type);
          },
        ),
        ListTile(
          leading: Icon(Icons.image),
          title: Text(UseString.galley),
          onTap: (){
            getImageGallery(type);
          },
        ),
      ],
    );
  }

  void bottompopup(String type){
    showModalBottomSheet(
      context: context,
      builder: (context){
        return Container(
          height: 120,
          child: listColumn(type),
        );
      }
    );
  }
   
   return Scaffold(
     appBar: AppBar(
       backgroundColor: Colors.white,
       centerTitle: true,
       flexibleSpace: Image(
          image: AssetImage('assets/images/imagesprofile/appbar/background.png'),
          fit: BoxFit.cover,
        ),
       title: Stack(children: <Widget>[
         Text('Edit Profile',
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*25,color: Colors.white), 
          ),
        ],
       ),
       
       leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left,
          color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          // tooltip: 'Share',
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              width: data.size.width,
              height: data.size.height,
              color: Colors.white,
            ),
            Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 20,left: 30),
                      child: Text(UseString.profileimg,
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*20,color: PickCarColor.colorFont1),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(top: 10,right: 30),
                      child: RaisedButton(
                        onPressed: (){
                          bottompopup("profileimg");
                        },
                        color: Colors.white,
                        child: Text(
                            UseString.edit,
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*20,color: Colors.lightBlue),
                          ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 10),
                  width: data.size.width/2,
                  height: data.size.height/3,
                  child: Center(
                    child: (profile!=null)?Image.file(
                      profile,
                      fit: BoxFit.fill,
                    ): 
                    imageProfile(ImageProfiles.profileUrl),
                  ),
                ),
                Container(
                  width: data.size.width,
                  height: 1,
                  color: Colors.grey[300],
                ),
                Stack(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 20,left: 30),
                      child: Text(UseString.profilede,
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*20,color: PickCarColor.colorFont1),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(top: 10,right: 30),
                      child: RaisedButton(
                        onPressed: (){
                           Navigator.of(context).pushNamed(Datamanager.editdetail);
                        },
                        color: Colors.white,
                        child: Text(
                            UseString.edit,
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*20,color: Colors.lightBlue),
                          ),
                      ),
                    ),
                  ],
                ),
                //text edit
                Container(
                  padding: EdgeInsets.only(top: 5,left: 10,right: 10),
                  child: ButtonTheme(
                    minWidth: data.size.width,
                    child: FlatButton(
                      color: Colors.white,
                      textColor: Color.fromRGBO(69,79,99,1),
                      onPressed: () {
                        Navigator.of(context).pushNamed(Datamanager.editdetail);
                      },
                      child: SizedBox(
                        width: double.infinity,
                        child: Row(children: <Widget>[
                              Icon(
                                Icons.account_box
                              ),
                              Text(
                              '   '+UseString.name+' '+Datamanager.user.name,
                              textAlign: TextAlign.left,
                              style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*18,color: PickCarColor.colorFont1),
                            ),
                          ],
                        ), 
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10,right: 10),
                  child: ButtonTheme(
                    minWidth: data.size.width,
                    child: FlatButton(
                      color: Colors.white,
                      textColor: Color.fromRGBO(69,79,99,1),
                      onPressed: () {
                        Navigator.of(context).pushNamed(Datamanager.editdetail);
                      },
                      child: SizedBox(
                        width: double.infinity,
                        child: Row(children: <Widget>[
                              Icon(
                                Icons.school
                              ),
                              Text(
                              '   '+UseString.facultyof+' '+Datamanager.user.faculty,
                              textAlign: TextAlign.left,
                              style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*18,color: PickCarColor.colorFont1),
                            ),
                          ],
                        ), 
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10,right: 10),
                  child: ButtonTheme(
                    minWidth: data.size.width,
                    child: FlatButton(
                      color: Colors.white,
                      textColor: Color.fromRGBO(69,79,99,1),
                      onPressed: () {
                        Navigator.of(context).pushNamed(Datamanager.editdetail);
                      },
                      child: SizedBox(
                        width: double.infinity,
                        child: Row(children: <Widget>[
                              Icon(
                                Icons.account_balance,
                              ),
                              Text(
                              '   '+Datamanager.user.university,
                              textAlign: TextAlign.left,
                              style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*18,color: PickCarColor.colorFont1),
                            ),
                          ],
                        ), 
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 5,left: 10,right: 10),
                  child: ButtonTheme(
                    minWidth: data.size.width,
                    child: FlatButton(
                      color: Colors.white,
                      textColor: Color.fromRGBO(69,79,99,1),
                      onPressed: () {
                        Navigator.of(context).pushNamed(Datamanager.editdetail);
                      },
                      child: SizedBox(
                        width: double.infinity,
                        child: Row(children: <Widget>[
                              Icon(
                                Icons.call
                              ),
                              Text(
                              '   '+Datamanager.user.tel,
                              textAlign: TextAlign.left,
                              style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*18,color: PickCarColor.colorFont1),
                            ),
                          ],
                        ), 
                      ),
                    ),
                  ),
                ),
                //
                Container(
                  width: data.size.width,
                  height: 1,
                  color: Colors.grey[300],
                ),
                Stack(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 20,left: 30),
                      child: Text(UseString.motorliscense,
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*20,color: PickCarColor.colorFont1),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(top: 10,right: 30),
                      child: RaisedButton(
                        onPressed: (){
                          bottompopup("motorliscense");
                        },
                        color: Colors.white,
                        child: Text(
                            UseString.edit,
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*20,color: Colors.lightBlue),
                          ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 10),
                  width: data.size.width/2,
                  height: data.size.height/3,
                  child: Center(
                    child: (motordri!=null)?Image.file(
                      motordri,
                      fit: BoxFit.fill,
                    ): 
                    imageProfile(ImageProfiles.drimotorcard),
                  ),
                ),
                Container(
                  width: data.size.width,
                  height: 1,
                  color: Colors.grey[300],
                ),
                Stack(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 20,left: 30),
                      child: Text(UseString.idcard,
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*20,color: PickCarColor.colorFont1),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(top: 10,right: 30),
                      child: RaisedButton(
                        onPressed: (){
                          bottompopup("idcard");
                        },
                        color: Colors.white,
                        child: Text(
                            UseString.edit,
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*20,color: Colors.lightBlue),
                          ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 10),
                  width: data.size.width/2,
                  height: data.size.height/3,
                  child: Center(
                    child: (idcard!=null)?Image.file(
                      idcard,
                      fit: BoxFit.fill,
                    ): 
                    imageProfile(ImageProfiles.idcard),
                  ),
                ),
                Container(
                  width: data.size.width,
                  height: 1,
                  color: Colors.grey[300],
                ),
                Stack(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 20,left: 30),
                      child: Text(UseString.universitycard,
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*20,color: PickCarColor.colorFont1),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(top: 10,right: 30),
                      child: RaisedButton(
                        onPressed: (){
                          bottompopup("universitycard");
                        },
                        color: Colors.white,
                        child: Text(
                            UseString.edit,
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*20,color: Colors.lightBlue),
                          ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 10),
                  width: data.size.width/2,
                  height: data.size.height/3,
                  child: Center(
                    child: (universitycard!=null)?Image.file(
                      universitycard,
                      fit: BoxFit.fill,
                    ): 
                    imageProfile(ImageProfiles.universitycard),
                  ),
                ),
                Container(
                  width: data.size.width,
                  height: 1,
                  color: Colors.grey[300],
                ),
                Stack(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 20,left: 30),
                      child: Text(UseString.email,
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*20,color: PickCarColor.colorFont1),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(top: 10,right: 30),
                      child: RaisedButton(
                        onPressed: (){
                          // Navigator.pushNamed(context, '/EditEmail');
                        },
                        color: Colors.white,
                        child: Text(
                            'Connect',
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*20,color: Colors.lightBlue),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(top: 10),
                ),
                Container(
                  width: data.size.width,
                  height: 1,
                  color: Colors.grey[300],
                ),
                Stack(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 20,left: 30),
                      child: Text('Password',
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*20,color: PickCarColor.colorFont1),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(top: 10,right: 30),
                      child: RaisedButton(
                        onPressed: (){
                          Navigator.pushNamed(context, '/ChangePassword');
                        },
                        color: Colors.white,
                        child: Text(
                            'Change',
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*20,color: Colors.lightBlue),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(top: 10),
                ),
                Container(
                  width: data.size.width,
                  height: 1,
                  color: Colors.grey[300],
                ),
              ],
            ),
          ],
        ),
      ),
   );
 }
}