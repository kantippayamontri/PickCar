import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:pickcar/bloc/profile/changpassword/changpasswordbloc.dart';
import 'dart:typed_data';

import '../../../datamanager.dart';

// import 'package:intl/intl.dart';
// import 'package:intl/date_symbol_data_local.dart';
// int i =0;
class ChangePassword extends StatefulWidget {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  _ChangePassword createState() => _ChangePassword();
}
class _ChangePassword extends State<ChangePassword> {
  File _image;
  Uint8List imagefile;
  var _changepassword;
  List<DropdownMenuItem<String>> listDrop = [];
  @override
  void initState() {
    _changepassword = Changpasswordbloc(context);
  }
  @override
  Widget build(BuildContext context) {
    // widget.formkey = GlobalKey<FormState>();
    final data = MediaQuery.of(context);
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
                    child: Text(UseString.currentpass,
                      style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*16,color: PickCarColor.colorFont1),
                    ),
                  ),
                  Form(
                    key: widget.formkey,
                    child: TextFormField(
                      controller: _changepassword.currentpass,
                      obscureText: true,
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: data.textScaleFactor*25,
                          // color: Color.fromRGBO(69,79,99,1)
                      ),
                      validator: (value){
                        if(value != Datamanager.user.password){
                          return UseString.passwordinvalid;
                        }
                      },
                      decoration: InputDecoration(
                        // border: InputBorder.none,
                        // hintText: 'Namtam Snow'
                      ),
                    ),
                  ),
                  Container(padding: EdgeInsets.only(top: 10),),
                  Row(children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(UseString.forgetpass,
                          style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*14,color: PickCarColor.colorFont1),
                        ),
                      ),
                      Container(
                        width: 70,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(Datamanager.emailsend);
                          },
                          child: Text("Click",
                            style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*14,color: Colors.lightBlue,decoration: TextDecoration.underline,),
                            ),
                        ),
                      ),
                    ],
                  ),
                  Container(padding: EdgeInsets.only(top: 30),),
                  Row(
                    children: <Widget>[
                      Container(
                        width: data.size.width-20,
                        alignment: Alignment.center,
                        child: RaisedButton(
                          onPressed: (){
                            // Navigator.of(context).pushNamed(Datamanager.changepassword);
                            if(widget.formkey.currentState.validate()){
                              _changepassword.matchpassword(context);
                            }
                          },
                          color: Colors.white,
                          child: Text(
                              'Next',
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
