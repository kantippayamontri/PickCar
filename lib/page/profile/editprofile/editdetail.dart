import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'dart:typed_data';

// import 'package:intl/intl.dart';
// import 'package:intl/date_symbol_data_local.dart';
// int i =0;
class EditDetail extends StatefulWidget {
  int i=0;
  @override
  _EditDetail createState() => _EditDetail();
}
class _EditDetail extends State<EditDetail> {
  File _image;
  Uint8List imagefile;
  List<DropdownMenuItem<String>> listDrop = [];
  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    void loadData(){
      listDrop = [];
      listDrop.add(new DropdownMenuItem(
        child: new Text('Address1',
            style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*25,color: Color.fromRGBO(69,79,99,1)),
          ),
        value: "changmai",
        ),
      );
      listDrop.add(new DropdownMenuItem(
        child: new Text('Address2',
            style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*25,color: Color.fromRGBO(69,79,99,1)),
          ),
        value: "changmai2",
        ),
      );
      listDrop.add(new DropdownMenuItem(
        child: new Text('Address3',
            style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*25,color: Color.fromRGBO(69,79,99,1)),
          ),
        value: "changmai3",
        ),
      );
    }
    loadData();

    // void inti() {
      // super.initState();
      void getProfile(){
        if(widget.i==0){
          print("run");
          var maxSize = 7*1024*1024;
          final StorageReference ref = FirebaseStorage.instance.ref()
          .child("profile")
          .child("id");
          ref.child("a.png").getData(maxSize).then((data){
            this.setState((){
              widget.i=1;
              imagefile = data;
            });
          }).catchError((error){
            print("------");
            debugPrint(error.toString());
          });
        }
      }
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

    // }
    // @override
    // void initState() {
    //     super.initState();
    //     print("a");
    // }
    
    Widget checkImage(){
      getProfile();
      if(imagefile == null){
        return Container();
      }else{
        // var _img = I.decodeImage(imagefile);
        //  File('_img.png')..writeAsBytesSync(I.encodePng(_img));
        return Image.memory(imagefile,fit: BoxFit.fill,);
      }
    }

    return Scaffold(
      appBar: AppBar(
       backgroundColor: Colors.white,
       centerTitle: true,
       flexibleSpace: Image(
          image: AssetImage('asset/appbar/background.png'),
          fit: BoxFit.cover,
        ),
       title: Text('Profile Details',
          style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*25,color: Colors.white), 
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
                    child: Text('ชื่อ',
                      style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*16,color: Color.fromRGBO(69,79,99,1)),
                    ),
                  ),
                  Container(
                    child: TextField(
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: data.textScaleFactor*25,
                          // color: Color.fromRGBO(69,79,99,1)
                      ),
                      decoration: InputDecoration(
                        // border: InputBorder.none,
                        hintText: 'Namtam Snow'
                      ),
                    ),
                  ),
                  Container(padding: EdgeInsets.only(top: 10),),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('ที่อยู่',
                      style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*16,color: Color.fromRGBO(69,79,99,1)),
                    ),
                  ),
                  Container(
                    child: TextField(
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: data.textScaleFactor*25,
                          // color: Color.fromRGBO(69,79,99,1)
                      ),
                      decoration: InputDecoration(
                        // border: InputBorder.none,
                        hintText: '12/5'
                      ),
                    ),
                  ),
                  Container(padding: EdgeInsets.only(top: 10),),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('จังหวัด',
                      style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*25,color: Color.fromRGBO(69,79,99,1)),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 10),
                    width: data.size.width,
                    child: DropdownButton(
                      isExpanded: true,
                      items: listDrop,
                      hint: Text("เลือก จังหวัด",
                        style: TextStyle(fontSize: data.textScaleFactor*25),
                        textAlign: TextAlign.right,
                      ),
                      onChanged: (value){
                        print(value);
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('อำเภอ',
                      style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*25,color: Color.fromRGBO(69,79,99,1)),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 10),
                    width: data.size.width,
                    child: DropdownButton(
                      isExpanded: true,
                      items: listDrop,
                      hint: Text("เลือก อำเภอ",
                        style: TextStyle(fontSize: data.textScaleFactor*25),
                        textAlign: TextAlign.right,
                      ),
                      onChanged: (value){
                        print(value);
                      },
                    ),
                  ),
                   Align(
                    alignment: Alignment.centerLeft,
                    child: Text('ตำบล',
                      style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*25,color: Color.fromRGBO(69,79,99,1)),
                    ),
                  ),
                  Container(
                    width: data.size.width,
                    child: DropdownButton(
                      isExpanded: true,
                      items: listDrop,
                      hint: Text("เลือก ตำบล",
                        style: TextStyle(fontSize: data.textScaleFactor*25),
                        textAlign: TextAlign.right,
                      ),
                      onChanged: (value){
                        print(value);
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('รหัสไปรษณีย์',
                      style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*16,color: Color.fromRGBO(69,79,99,1)),
                    ),
                  ),
                  Container(
                    child: TextField(
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: data.textScaleFactor*25,
                          // color: Color.fromRGBO(69,79,99,1)
                      ),
                      decoration: InputDecoration(
                        // border: InputBorder.none,
                        hintText: '50130'
                      ),
                      keyboardType: TextInputType.number
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
