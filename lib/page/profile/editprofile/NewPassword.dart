import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:pickcar/bloc/profile/newpassword/newpasswordbloc.dart';
import 'dart:typed_data';

import 'package:pickcar/datamanager.dart';

// import 'package:intl/intl.dart';
// import 'package:intl/date_symbol_data_local.dart';
// int i =0;
class NewPassword extends StatefulWidget {
  TextEditingController newp;
  TextEditingController repeatp;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  _NewPassword createState() => _NewPassword();
}
class _NewPassword extends State<NewPassword> {
  var _newpasswordbloc;
  @override
  void initState() {
    _newpasswordbloc = Newpasswordbloc(context);
  }
  @override
  build(BuildContext context) {
    final data = MediaQuery.of(context);
      // widget.formkey = GlobalKey<FormState>();
      void confirmChange(BuildContext context){
      showDialog(context: context,builder:  (BuildContext context){
        return AlertDialog(
          title: Center(
            child: Column(
              children: <Widget>[
                Text("Are you sure?",
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*30,color: Color.fromRGBO(69,79,99,1)), 
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
                          _newpasswordbloc.matchpassword();
                          Navigator.pop(context);
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
    return Scaffold(
      appBar: AppBar(
       backgroundColor: Colors.white,
       flexibleSpace: Image(
          image: AssetImage('assets/images/imagesprofile/appbar/background.png'),
          fit: BoxFit.cover,
        ),
       centerTitle: true,
       title: Text(UseString.changepass,
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
        child:Form(
          key: widget.formkey,
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
                    Container(padding: EdgeInsets.only(top: 10),),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(UseString.newpass,
                        style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*16,color: Color.fromRGBO(69,79,99,1)),
                      ),
                    ),
                    Container(
                      child:TextFormField(
                        controller: _newpasswordbloc.newpassword,
                        obscureText: true,
                        validator: (value){
                          if (value.isEmpty) {
                            return UseString.passwordtypeval;
                          }

                          if (value.length < 6) {
                            return UseString.passwordlenght;
                          }
                          if((_newpasswordbloc.repeatpassword.text != _newpasswordbloc.newpassword.text )&& value.isNotEmpty ){
                            return UseString.passworddontsame;
                          }
                          return null;
                        },
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: data.textScaleFactor*25,
                            // color: Color.fromRGBO(69,79,99,1)
                        ),
                        decoration: InputDecoration(
                          // errorText: textcheck1,
                          // border: InputBorder.none,
                          // hintText: '12/5'
                        ),
                      ),
                    ),
                    Container(padding: EdgeInsets.only(top: 10),),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(UseString.repeatpass,
                        style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*16,color: Color.fromRGBO(69,79,99,1)),
                      ),
                    ),
                    Container(
                      child: TextFormField(
                        controller: _newpasswordbloc.repeatpassword,
                        obscureText: true,
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: data.textScaleFactor*25,
                            // color: Color.fromRGBO(69,79,99,1)
                        ),
                        validator: (value){
                          if (value.isEmpty) {
                            
                            return UseString.passwordtypeval;
                          }
                          if (value.length < 6) {
                            
                            return UseString.passwordlenght;
                          }
                          if((_newpasswordbloc.newpassword.text != _newpasswordbloc.repeatpassword.text) && value.isNotEmpty ){
                            return UseString.passworddontsame;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          // border: InputBorder.none,
                          // hintText: '12/5'
                          // errorText: textcheck2,
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
                              // print(_newpasswordbloc.newpassword.text);
                              // print(_newpasswordbloc.repeatpassword.text);
                              var from = widget.formkey.currentState;
                              print(_newpasswordbloc.newpassword.text);
                              print(_newpasswordbloc.repeatpassword.text);
                              if(from.validate()){
                                if(_newpasswordbloc.newpassword.text == _newpasswordbloc.repeatpassword.text){
                                  confirmChange(context);
                                }
                              }
                            },
                            color: Colors.white,
                            child: Text(
                                'Confirm',
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
                              Navigator.pop(context);
                            },
                            color: Colors.white,
                            child: Text(
                                'Cancel',
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
      ),
    );
  }
}
