import 'package:carousel_slider/carousel_slider.dart';
import 'package:flat_icons_flutter/flat_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:pickcar/bloc/profile/changpassword/changpasswordbloc.dart';
import 'dart:typed_data';

import '../../datamanager.dart';

// import 'package:intl/intl.dart';
// import 'package:intl/date_symbol_data_local.dart';
// int i =0;
class SelectUniversity extends StatefulWidget {
  String dropdownValue = 'Choose University';
  String adduniversity ='';
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  _SelectUniversityState createState() => _SelectUniversityState();
}
class _SelectUniversityState extends State<SelectUniversity> {
  
  @override
  Widget build(BuildContext context) {
    widget.formkey = GlobalKey<FormState>();
    final data = MediaQuery.of(context);
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
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 30,left: 20,right: 20),
            width: double.infinity,
            child: DropdownButton<String>(
              value: widget.dropdownValue,
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(
                color: Colors.deepPurple
              ),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String newValue) {
                setState(() {
                  SetUniversity.university = newValue;
                  widget.dropdownValue = newValue;
                });
              },
              items: Datamanager.universityforadmin
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
                SizedBox(height: 20,),
                RaisedButton(
                  onPressed: () async {
                    var refuniversity = await Datamanager.firestore.collection('universityplace').add(Datamanager.universitydatabase);
                    var docuniversityid = refuniversity.documentID;
                    print(docuniversityid);
                    Datamanager.firestore.collection('universityplace')
                                        .document(docuniversityid)
                                        .updateData({'docid': docuniversityid})
                                        .whenComplete((){
                                          setState(() {
                                            widget.adduniversity = 'complete';
                                          });
                                        });
                    // Navigator.of(context).pushNamed(Datamanager.detailsearch);
                  },
                  child: Text("set university list name"),
                ),
                Text(widget.adduniversity),
                SizedBox(height: 20,),
                RaisedButton(
                  onPressed: (){
                    if(widget.dropdownValue !='Choose University'){
                      Navigator.of(context).pushNamed(Datamanager.boxselectadmin);
                    }
                    // Navigator.of(context).pushNamed(Datamanager.detailsearch);
                  },
                  child: Text("goto box"),
                ),
                SizedBox(height: 20,),
                RaisedButton(
                  onPressed: (){
                    if(widget.dropdownValue !='Choose University'){
                      Navigator.of(context).pushNamed(Datamanager.placeselectadmin);
                    }
                    // Navigator.of(context).pushNamed(Datamanager.detailsearch);
                  },
                  child: Text("goto place"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}