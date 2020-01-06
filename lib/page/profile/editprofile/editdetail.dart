import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:pickcar/bloc/profile/editdetail/editdetailbloc.dart';
import 'dart:typed_data';
import 'package:pickcar/datamanager.dart';
// import 'package:pickcar/bloc/profile/editdetailevent.dart';

// import 'package:intl/intl.dart';
// import 'package:intl/date_symbol_data_local.dart';
// int i =0;
class EditDetail extends StatefulWidget {
  @override
  _EditDetail createState() => _EditDetail();
}
class _EditDetail extends State<EditDetail> {
  var _editdetailbloc;
  File _image;
  Uint8List imagefile;
  List<DropdownMenuItem<String>> listDropUniversity = [];
  List<DropdownMenuItem<String>> listDropFaculty = [];

  @override
  void initState() {
    _editdetailbloc = Editdetailbloc(context);
  }
  String universitytext = Datamanager.user.university;
  String factorytext = Datamanager.user.faculty;
  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    var dropdownTextstyle = TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*25,color: PickCarColor.colorFont1);
    void loadDataFacuty(){
      listDropFaculty = [];
      for (var values in Datamanager.faculty2){
        listDropFaculty.add(new DropdownMenuItem(
        child: new Text(values,
            style: dropdownTextstyle,
          ),
        value: values,
        ),
      );
      }
    }
    void loadDataUniversity(){
      listDropUniversity = [];
      for (var values in Datamanager.univeresity2){
        listDropUniversity.add(new DropdownMenuItem(
        child: new Text(values,
            style: dropdownTextstyle,
          ),
        value: values,
        ),
      );
      }
    }
    loadDataFacuty();
    loadDataUniversity();

    // void inti() {
      // super.initState();
      void confirmChange(BuildContext context){
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
                          // uploadPic(context);
                          _editdetailbloc.edtidetail();
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
                          setState((){
                            _image = null;
                          });
                        },
                        child: Text('Cancel',
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
    return Scaffold(
      appBar: AppBar(
       backgroundColor: Colors.white,
       centerTitle: true,
       flexibleSpace: Image(
          image: AssetImage('assets/images/imagesprofile/appbar/background.png'),
          fit: BoxFit.cover,
        ),
       title: Text(UseString.profile+' '+UseString.detail,
          style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*25,color: Colors.white), 
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
        child:Stack(
          children: <Widget>[
            Container(
              width: data.size.width,
              height: data.size.height,
              color: Colors.white,
            ),
            Padding(
              padding: EdgeInsets.only(top:20,left: 10),
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(UseString.name,
                      style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*16,color: PickCarColor.colorFont1),
                    ),
                  ),
                  Container(
                    child: TextFormField(
                      controller: _editdetailbloc.namecontroller,
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: data.textScaleFactor*25,
                          // color: Color.fromRGBO(69,79,99,1)
                      ),
                      decoration: InputDecoration(
                        // border: InputBorder.none,
                        hintText: Datamanager.user.name,
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return UseString.nameemptyval;
                        }
                      },
                    ),
                  ),
                  Container(padding: EdgeInsets.only(top: 10),),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(UseString.university,
                      style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*16,color: PickCarColor.colorFont1),
                    ),
                  ),
                  Container(
                    width: data.size.width,
                    child: DropdownButton(
                      isExpanded: true,
                      items: listDropUniversity,
                      hint: Text(universitytext.toString(),
                        style: TextStyle(fontSize: data.textScaleFactor*25,color: PickCarColor.colorFont1),
                        textAlign: TextAlign.right,
                      ),
                      value: universitytext,
                      onChanged: (value){
                        _editdetailbloc.university = value;
                        setState(() {
                          universitytext =value;
                        });
                      },
                    ),
                  ),
                  // Align(
                  //   alignment: Alignment.centerLeft,
                  //   child: Text(UseString.university,
                  //     style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*16,color: PickCarColor.colorFont1),
                  //   ),
                  // ),
                  // Container(
                  //   child: TextField(
                  //     style: TextStyle(
                  //         fontWeight: FontWeight.normal,
                  //         fontSize: data.textScaleFactor*25,
                  //         // color: Color.fromRGBO(69,79,99,1)
                  //     ),
                  //     decoration: InputDecoration(
                  //       // border: InputBorder.none,
                  //       hintText: Datamanager.user.university,
                  //     ),
                  //   ),
                  // ),
                  Container(padding: EdgeInsets.only(top: 10),),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(UseString.faculty,
                      style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*16,color: PickCarColor.colorFont1),
                    ),
                  ),
                  // DropDownFormField(
                  //   titleText: null,
                  //   hintText: Datamanager.user.faculty,
                    
                  //   value: _editdetailbloc.faculty,
                  //   onSaved: (val) {
                  //     setState(() {
                  //       _editdetailbloc.faculty = val;
                  //     });
                  //   },
                  //   onChanged: (val) {
                  //     setState(() {
                  //       _editdetailbloc.faculty = val;
                  //     });
                  //   },
                  //   dataSource: Datamanager.faculty,
                  //   validator: (val) {
                  //     if (val == null) {
                  //       return UseString.choosefaculty;
                  //     }
                  //   },
                  //   textField: "faculty",
                  //   valueField: "faculty",
                  // ),
                  Container(
                    width: data.size.width,
                    child: DropdownButton(
                      isExpanded: true,
                      items: listDropFaculty,
                      hint: Text(factorytext,
                        style: TextStyle(fontSize: data.textScaleFactor*25,color: PickCarColor.colorFont1),
                        textAlign: TextAlign.right,
                      ),
                      value: factorytext,
                      onChanged: (value){
                        _editdetailbloc.faculty = value;
                        setState(() {
                          factorytext = value;
                        });
                      },
                    ),
                  ),
                //  Align(
                //     alignment: Alignment.centerLeft,
                //     child: Text(UseString.faculty,
                //       style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*16,color: Color.fromRGBO(69,79,99,1)),
                //     ),
                //   ),
                //   Container(
                //     child: TextField(
                //       style: TextStyle(
                //           fontWeight: FontWeight.normal,
                //           fontSize: data.textScaleFactor*25,
                //           // color: Color.fromRGBO(69,79,99,1)
                //       ),
                //       decoration: InputDecoration(
                //         // border: InputBorder.none,
                //         hintText: Datamanager.user.faculty,
                //       ),
                //     ),
                //   ),
                  Container(padding: EdgeInsets.only(top: 10),),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(UseString.telnumber,
                      style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*16,color: Color.fromRGBO(69,79,99,1)),
                    ),
                  ),
                  Container(
                    child: TextFormField(
                      controller: _editdetailbloc.telcontroller,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: data.textScaleFactor*25,
                          // color: Color.fromRGBO(69,79,99,1)
                      ),
                      decoration: InputDecoration(
                        // border: InputBorder.none,
                        hintText: Datamanager.user.tel,
                      ),
                    ),
                  ),
                  Container(padding: EdgeInsets.only(top: 30),),
                  Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 100),
                        alignment: Alignment.center,
                        child: RaisedButton(
                          onPressed: (){
                            confirmChange(context);
                          },
                          color: Colors.white,
                          child: Text(
                              'ตงลง',
                              style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*20,color: Colors.lightBlue),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20),
                        alignment: Alignment.center,
                        child: RaisedButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          color: Colors.white,
                          child: Text(
                              'ยกเลิก',
                              style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*20,color: Colors.lightBlue),
                          ),
                        ),
                      ),
                    ],
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
