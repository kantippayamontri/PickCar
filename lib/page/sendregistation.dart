import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime_type/mime_type.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:pickcar/bloc/profile/editdetail/editdetailbloc.dart';
import 'dart:typed_data';
import 'package:pickcar/datamanager.dart';
import 'package:pickcar/ui/uisize.dart';
// import 'package:pickcar/bloc/profile/editdetailevent.dart';

// import 'package:intl/intl.dart';
// import 'package:intl/date_symbol_data_local.dart';
// int i =0;
class Sendregistation extends StatefulWidget {
  double heightimage = 0;
  bool visible = true;
  bool loading = false;
  var image;
  File imagefile;
  var imagetype = "default";
  @override
  _SendregistationState createState() => _SendregistationState();
}
class _SendregistationState extends State<Sendregistation> {
  @override
  void initState() {
    widget.image = "assets/images/imagemain/exampleregistration.jpg";
  }
  String universitytext = Datamanager.user.university;
  String factorytext = Datamanager.user.faculty;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var data = MediaQuery.of(context);
    AppBar appbar = AppBar(
       backgroundColor: Colors.white,
       centerTitle: true,
       flexibleSpace: Image(
          image: AssetImage('assets/images/imagesprofile/appbar/background.png'),
          fit: BoxFit.cover,
        ),
       title: Text(UseString.vehicleregistration,
          style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*25,color: Colors.white), 
       ),
       leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left,
          color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          // tooltip: 'Share',
        ),
      );
      var sizeappbar = AppBar().preferredSize.height;
      double sizetapbar = MediaQuery.of(context).padding.top;
    
    showwarningWait(BuildContext context){
      return showDialog<void>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(UseString.sendregistration),
            content: Text(UseString.pleasewaitbody),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
    shownotselect(BuildContext context){
      return showDialog<void>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(UseString.pleaseuploadcar),
            // content: Text(UseString.pleasewaitbody),
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
    uploaddata() async {
      String contenttype;
      String ext;
      // String basename = widget.imagefile.path.split('/').last;
      StorageReference ref =
          Datamanager.firebasestorage.ref().child("Motorcycle").child(Datamanager.motorcycle.firestoredocid);
      StorageUploadTask uploadtask;
      contenttype = mime(widget.imagefile.path);
      ext = contenttype.split('/').last;
      uploadtask = ref
          .child("registration"+".${ext}")
          .putFile(widget.imagefile, StorageMetadata(contentType: contenttype));
      await uploadtask.onComplete.whenComplete(() async {
        // print('aaa');
        var imagelink =await Datamanager.firebasestorage.ref().child("Motorcycle")
                                          .child(Datamanager.motorcycle.firestoredocid)
                                          .child("registration"+".${ext}")
                                          .getDownloadURL();
        await Firestore.instance.collection('Motorcycle').document(Datamanager.motorcycle.firestoredocid)
                  .updateData({"motorownerliscenselink":imagelink,"isapprove":"wait"})
                  .whenComplete((){
                    setState(() {
                      showwarningWait(context);
                      widget.loading = false;
                    });
                  });

        
      });
    }
    uploadpicture(BuildContext context){
      setState(() {
        widget.loading = true;
        uploaddata();
      });
    }
    imageselect(BuildContext context){
      if(widget.imagetype == 'default'){
        return AssetImage(widget.image);
      }else{
        return FileImage(widget.imagefile);
      }
      
    }
    Future getImageGallery() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
      if(image !=null){
        setState(() {
          widget.imagefile = image;
          widget.imagetype = 'hasimage';
          widget.heightimage =0;
          widget.visible = true;
        });
      }
    }
    Future getImageCamera() async {
      var image = await ImagePicker.pickImage(source: ImageSource.camera);
      if(image !=null){
        setState(() {
          widget.imagefile = image;
          widget.imagetype = 'hasimage';
          widget.heightimage =0;
          widget.visible = true;
        });
      }
    }
    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child:Stack(
          children: <Widget>[
            Container(
              // margin: EdgeInsets.only(top:SizeConfig.blockSizeVertical*65),
              width: SizeConfig.screenWidth,
              height: SizeConfig.blockSizeVertical*75,
              child: Container(
                margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*3,right:SizeConfig.blockSizeHorizontal*3,top: SizeConfig.blockSizeVertical*3,bottom: SizeConfig.blockSizeVertical*5),
                decoration: BoxDecoration(
                  // color: Colors.purple,
                  borderRadius: BorderRadius.circular(0),
                  image: DecorationImage(
                    image: imageselect(context),
                    fit: BoxFit.fill,
                  ), 
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                getImageCamera();
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                margin: EdgeInsets.only(top:SizeConfig.blockSizeVertical*82.7 -(sizeappbar+sizetapbar)-widget.heightimage),
                width: SizeConfig.screenWidth,
                height: SizeConfig.blockSizeVertical*10,
                color: PickCarColor.colormain,
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 300),
                  opacity: !widget.visible? 1.0 : 0.0,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.camera_alt,color: Colors.white,size: SizeConfig.blockSizeVertical*6,),
                      Text(UseString.camera,
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*25,color: Colors.white), 
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                if(widget.visible == true){
                  setState(() {
                    widget.visible = false;
                    widget.heightimage = SizeConfig.blockSizeVertical*10;
                  });
                }else{
                  getImageGallery();
                }
              },
              child: Container(
                margin: EdgeInsets.only(top:SizeConfig.blockSizeVertical*82.7 -(sizeappbar+sizetapbar)),
                width: SizeConfig.screenWidth,
                height: SizeConfig.blockSizeVertical*10,
                color: PickCarColor.colorbuttom,
                child: Stack(
                  children: <Widget>[
                    Center(
                      child: AnimatedOpacity(
                        duration: Duration(milliseconds: 150),
                        opacity: widget.visible? 1.0 : 0.0,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.file_upload,color: Colors.white,size: SizeConfig.blockSizeVertical*6,),
                            Text(UseString.uploadregistration,
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*25,color: Colors.white), 
                            ),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: AnimatedOpacity(
                        duration: Duration(milliseconds: 150),
                        opacity: !widget.visible? 1.0 : 0.0,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.camera,color: Colors.white,size: SizeConfig.blockSizeVertical*6,),
                            Text(UseString.galley,
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*25,color: Colors.white), 
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                if(widget.imagefile != null){
                  uploadpicture(context);
                }else{
                  shownotselect(context);
                }
              },
              child: Container(
                margin: EdgeInsets.only(top:SizeConfig.blockSizeVertical*92.7 -(sizeappbar+sizetapbar)),
                width: SizeConfig.screenWidth,
                height: SizeConfig.blockSizeVertical*7.3,
                color: Colors.blueAccent,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.save_alt,color: Colors.white,size: SizeConfig.blockSizeVertical*6,),
                    Text(UseString.save,
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*25,color: Colors.white), 
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: widget.loading,
              child: Container(
                width: SizeConfig.screenWidth,
                height: SizeConfig.blockSizeVertical*100-((sizeappbar+sizetapbar)/2),
                color: PickCarColor.colormain,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SpinKitCircle(
                      color: Colors.white,
                    ),
                    Text(UseString.uploadding,
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*25,color: Colors.white), 
                    ),
                  ],
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
