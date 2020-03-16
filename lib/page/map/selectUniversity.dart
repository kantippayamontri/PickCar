import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flat_icons_flutter/flat_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:pickcar/bloc/profile/changpassword/changpasswordbloc.dart';
import 'package:pickcar/models/universityplace.dart';
import 'package:pickcar/ui/uisize.dart';
import 'dart:typed_data';

import '../../datamanager.dart';

// import 'package:intl/intl.dart';
// import 'package:intl/date_symbol_data_local.dart';
// int i =0;
class SelectUniversity extends StatefulWidget {
  final universityname = TextEditingController();
  final latitude = TextEditingController();
  final longtutude = TextEditingController();
  bool adduniversityname = true;
  String dropdownValue = 'Choose University';
  String adduniversity ='';
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  _SelectUniversityState createState() => _SelectUniversityState();
}
class _SelectUniversityState extends State<SelectUniversity> {
  dispose() {
    widget.universityname.dispose();
    widget.latitude.dispose();
    widget.longtutude.dispose();
    super.dispose();
  }
  showwarning(BuildContext context){
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(UseString.fill),
          // content: Text(UseString.pleaseselectdetail),
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
  @override
  Widget build(BuildContext context) {
    var sizeappbar = AppBar().preferredSize.height;
    double sizetapbar = MediaQuery.of(context).padding.top;
    SizeConfig().init(context);
    widget.formkey = GlobalKey<FormState>();
    final data = MediaQuery.of(context);
    if(widget.adduniversityname){
      Datamanager.universitylist = ['Choose University'];
      Firestore.instance.collection('universityplace').snapshots()
                      .listen((data){
                        data.documents.map((data){
                          var document = Universityplaceshow.fromSnapshot(data);
                          Datamanager.universitylist.add(document.universityname);
                        }).toString();
                        // print(universitylist);
                        setState(() {
                          widget.adduniversityname = false;
                        });
                      });
    }
    print(Datamanager.universitylist);
    return Scaffold(
      appBar: AppBar(
       backgroundColor: Colors.white,
       flexibleSpace: Image(
          image: AssetImage('assets/images/imagesprofile/appbar/background.png'),
          fit: BoxFit.cover,
        ),
       centerTitle: true,
       title: Text(UseString.detail,
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
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              width: SizeConfig.screenWidth,
              height: SizeConfig.blockSizeVertical*100 - (sizeappbar+sizetapbar),
              color: Colors.grey[200],
            ),
            Column(
              children: <Widget>[
                Container(
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.blockSizeVertical*5,
                  alignment: Alignment.center,
                  color: Colors.white,
                  child: Text('Add University',
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*25,color: PickCarColor.colorFont1), 
                  ),
                ),
                Container(
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.blockSizeVertical*13,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        child: Image.asset('assets/images/imagelogin/textinput.png',fit: BoxFit.fill,)
                      ),
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(left:SizeConfig.blockSizeHorizontal*7,right: SizeConfig.blockSizeHorizontal*7),
                          child: TextFormField(
                            
                            onTap: (){
                            },
                            // initialValue:widget.message.text,
                            controller: widget.universityname,
                            // obscureText: true,
                            // keyboardType: TextInputType.visiblePassword,
                            //onSaved: (val) => password = val,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                hintText: 'University name',
                              ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.blockSizeVertical*13,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        child: Image.asset('assets/images/imagelogin/textinput.png',fit: BoxFit.fill,)
                      ),
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(left:SizeConfig.blockSizeHorizontal*7,right: SizeConfig.blockSizeHorizontal*7),
                          child: TextFormField(
                            keyboardType: TextInputType.numberWithOptions(signed:true),
                            onTap: (){
                            },
                            // initialValue:widget.message.text,
                            controller: widget.latitude,
                            // obscureText: true,
                            // keyboardType: TextInputType.visiblePassword,
                            //onSaved: (val) => password = val,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                hintText: 'Latitude',
                              ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.blockSizeVertical*13,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        child: Image.asset('assets/images/imagelogin/textinput.png',fit: BoxFit.fill,)
                      ),
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(left:SizeConfig.blockSizeHorizontal*7,right: SizeConfig.blockSizeHorizontal*7),
                          child: TextFormField(
                            keyboardType: TextInputType.numberWithOptions(signed:true),
                            onTap: (){
                            },
                            // initialValue:widget.message.text,
                            controller: widget.longtutude,
                            // obscureText: true,
                            // keyboardType: TextInputType.visiblePassword,
                            //onSaved: (val) => password = val,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                hintText: 'Longitude',
                              ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top:SizeConfig.blockSizeVertical*53 -(sizeappbar+sizetapbar)),
              child: Column(
                children: <Widget>[
                  RaisedButton(
                    color: PickCarColor.colorbuttom,
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(15.0),
                      // side: BorderSide(color: Colors.red)
                    ),
                    onPressed: () async {
                      if(widget.longtutude.text != ''&&widget.latitude.text !=''&&widget.universityname.text != ''){
                        var refuniversity = await Datamanager.firestore.collection('universityplace')
                                                                      .add({'Universityname':widget.universityname.text,
                                                                      'latitude':double.parse(widget.latitude.text),'longitude':double.parse(widget.longtutude.text)
                                                                      ,'docid':null});
                        var docid = refuniversity.documentID;
                        await Datamanager.firestore.collection('universityplace').document(docid)
                                                                        .updateData({'docid':docid}).whenComplete((){
                                                                          setState(() {
                                                                            widget.longtutude.text='';
                                                                            widget.latitude.text ='';
                                                                            widget.universityname.text = '';
                                                                          });
                                                                        });
                        widget.adduniversityname = true;
                      }else{
                        showwarning(context);
                      }
                    },
                    child: Text(UseString.adduniversity,
                        style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*20,color: Colors.white), 
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top:SizeConfig.blockSizeVertical*3),
                    width: SizeConfig.screenWidth,
                    height: SizeConfig.blockSizeVertical*5,
                    alignment: Alignment.center,
                    color: Colors.white,
                    child: Text('Add Location',
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*25,color: PickCarColor.colorFont1), 
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left:SizeConfig.blockSizeHorizontal*3,right:SizeConfig.blockSizeHorizontal*3),
                    width: double.infinity,
                    // color: Colors.white,
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: widget.dropdownValue,
                      icon: Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      // underline: Container(
                      //   height: 2,
                      //   color: Colors.deepPurpleAccent,
                      // ),
                      onChanged: (String newValue) {
                        setState(() {
                          SetUniversity.university = newValue;
                          widget.dropdownValue = newValue;
                        });
                      },
                      items: Datamanager.universitylist
                        .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        })
                        .toList(),
                    ),
                  ),
                  Center(
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top:SizeConfig.blockSizeVertical*1.2),
                          width: SizeConfig.screenWidth,
                          height: SizeConfig.blockSizeVertical*13,
                          child: GestureDetector(
                            child: RaisedButton(
                              color: PickCarColor.colormain,
                              onPressed: (){
                                if(widget.dropdownValue !='Choose University'){
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pushNamed(Datamanager.boxselectadmin);
                                }
                                // Navigator.of(context).pushNamed(Datamanager.detailsearch);
                              },
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.https,color: Colors.white,size: (SizeConfig.blockSizeHorizontal+SizeConfig.blockSizeVertical)*4,),
                                  Text("Add Box Location",
                                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*25,color: Colors.white), 
                                  ),
                                  // Icon(Icons.keyboard_arrow_right,color: Colors.white,size: (SizeConfig.blockSizeHorizontal+SizeConfig.blockSizeVertical)*4,),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: SizeConfig.screenWidth,
                          height: SizeConfig.blockSizeVertical*13,
                          child: RaisedButton(
                            color: PickCarColor.colorbuttom,
                            onPressed: (){
                              if(widget.dropdownValue !='Choose University'){
                                Navigator.of(context).pop();
                                Navigator.of(context).pushNamed(Datamanager.placeselectadmin);
                              }
                              // Navigator.of(context).pushNamed(Datamanager.detailsearch);
                            },
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.place,color: Colors.white,size: (SizeConfig.blockSizeHorizontal+SizeConfig.blockSizeVertical)*4,),
                                Text("Add Place location",
                                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*25,color: Colors.white), 
                                ),
                                // Icon(Icons.keyboard_arrow_right,color: Colors.white,size: (SizeConfig.blockSizeHorizontal+SizeConfig.blockSizeVertical)*4,),
                              ],
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
    );
  }
}