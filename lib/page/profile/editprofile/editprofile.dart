import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mime_type/mime_type.dart';
import 'dart:io';
import 'package:path/path.dart';
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
  Uint8List imagefile;
  // void getProfile(){
  //   if(widget.i==0){
  //     print("run");
  //     var maxSize = 7*1024*1024;
  //     final StorageReference ref = FirebaseStorage.instance.ref()
  //     .child("profile")
  //     .child("id");
  //     ref.child("a.png").getData(maxSize).then((data){
  //       this.setState((){
  //         widget.i=1;
  //         imagefile = data;
  //       });
  //     }).catchError((error){
  //       print("------");
  //       debugPrint(error.toString());
  //     });
  //   }
  // }
  
  Future uploadPic(BuildContext context) async{
    String contenttype;
    String ext;
    StorageReference ref =
        Datamanager.firebasestorage.ref().child("User").child(Datamanager.user.uid);
    StorageUploadTask uploadtask;
    bool check = true;

    contenttype = mime(_image.path);
    ext = contenttype.split('/').last;
    uploadtask = ref
        .child("profile.${ext}")
        .putFile(_image, StorageMetadata(contentType: contenttype));
    await uploadtask.onComplete;
    if (uploadtask.isComplete) {
      print("upload profile success");
      Datamanager.user.profileimgtype = ext;
      // await Datamanager.firestore
      //       .collection('User')
      //       .where(field)
      //       .then((val){
      //         if(val.documents.length > 0){
      //             print(val.documents[0].data["field"]);
      //         }
      //         else{
      //             print("Not Found");
      //         }
      //       });
            // .document(Datamanager.user.uid)
            // .document()
            // .where("uid", isEqualTo: Datamanager.user.uid)
            // .updateData({'profilepictype': ext});
        print("Sign Up User Successful");
    } else {
      check = false;
    }
      
  }
  // Widget checkImage(){
  //   getProfile();
  //   if(imagefile == null){
  //     return Container();
  //   }else{
  //     // var _img = I.decodeImage(imagefile);
  //     //  File('_img.png')..writeAsBytesSync(I.encodePng(_img));
  //     return Image.memory(imagefile,fit: BoxFit.fill,);
  //   }
  // }
 @override
 Widget build(BuildContext context) {
  int _selectedIndex = 3;
  final data = MediaQuery.of(context);
  void confirmUpload(BuildContext context){
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
                        uploadPic(context);
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
                          _image = null;
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
  Future getImageGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
        print('Image Path $_image');
        if(image != null){
          confirmUpload(context);
        }else{
          Navigator.pop(context);
        }
        // uploadPic(context);
    });
  }
  Future getImageCamera() async {
  var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
        print('Image Path $_image');
        if(image != null){
          confirmUpload(context);
        }else{
          Navigator.pop(context);
        }
        // uploadPic(context);
    });
  }
  Column listColumn(){
    return Column(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.camera_alt),
          title: Text('Camera'),
          onTap: (){
            getImageCamera();
          },
        ),
        ListTile(
          leading: Icon(Icons.image),
          title: Text('Gallery'),
          onTap: (){
            getImageGallery();
          },
        ),
      ],
    );
  }

  void bottompopup(){
    showModalBottomSheet(
      context: context,
      builder: (context){
        return Container(
          height: 120,
          child: listColumn(),
        );
      }
    );
  }
   
   return Scaffold(
     appBar: AppBar(
       backgroundColor: Colors.white,
       centerTitle: true,
       flexibleSpace: Image(
          image: AssetImage('asset/appbar/background.png'),
          fit: BoxFit.cover,
        ),
       title: Stack(children: <Widget>[
         Text('Edit Profile',
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*25,color: Colors.white), 
          ),
        ],
       ),
       
       leading: IconButton(
          icon: Icon(Icons.arrow_left,
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
                      child: Text('Profile Image',
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*20,color: PickCarColor.colorFont1),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(top: 10,right: 30),
                      child: RaisedButton(
                        onPressed: (){
                          bottompopup();
                        },
                        color: Colors.white,
                        child: Text(
                            'Edit',
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
                    child: (_image!=null)?Image.file(
                      _image,
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
                      child: Text('Profile Details',
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
                            'Edit',
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
                              '   '+Datamanager.user.university+' '+UseString.university,
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
                      child: Text('Email',
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