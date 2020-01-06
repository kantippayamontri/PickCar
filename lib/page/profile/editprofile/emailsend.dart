import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:pickcar/bloc/profile/emailsend/emailsendbloc.dart';
import 'dart:typed_data';

import '../../../datamanager.dart';

// import 'package:intl/intl.dart';
// import 'package:intl/date_symbol_data_local.dart';
// int i =0;
class EmailSend extends StatefulWidget {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  _EmailSend createState() => _EmailSend();
}
class _EmailSend extends State<EmailSend> {
  File _image;
  Uint8List imagefile;
  var _emailsend;
  List<DropdownMenuItem<String>> listDrop = [];
  @override
  void initState() {
    _emailsend = Emailsendbloc(context);
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
       title: Text(UseString.forgetpasspage,
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
                    child: Text(UseString.enteraccount,
                      style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*16,color: PickCarColor.colorFont1),
                    ),
                  ),
                  Form(
                    key: widget.formkey,
                    child: TextFormField(
                      controller: _emailsend.currentemail,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: data.textScaleFactor*25,
                      ),
                      validator: (value){
                        if(value != Datamanager.user.email){
                          return UseString.emailinvalid;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        // border: InputBorder.none,
                        // hintText: 'Namtam Snow'
                      ),
                    ),
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
                              _emailsend.matchemail(context);
                            }
                          },
                          color: Colors.white,
                          child: Text(
                              UseString.send,
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
