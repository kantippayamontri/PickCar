import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pickcar/datamanager.dart';
import 'package:pickcar/models/listcarslot.dart';
import 'package:pickcar/widget/profile/profileImage.dart';
class Listcar extends StatefulWidget {
  @override
  _ListcarState createState() => _ListcarState();
}

class _ListcarState extends State<Listcar> {
  @override
  void initState() {
    DataFetch.fetchpiority = 0;
    DataFetch.checkhavedata = 0;
    super.initState();
  }
   int checkmatch(Listcarslot timeslot){
    var slot =timeslot.timeslotlist;
      var indexs = [];
      var slot1 = true;
      var slot2 = true;
      var slot3 = true;
      var slot4 = true;
      var slot5 = true;
      var slot6 = true;
      int isintime = 0;
      print(slot);
      if(slot1){
        indexs.add(slot.indexOf("8.00 - 9.30"));
      }
      if(slot2){
        indexs.add(slot.indexOf("9.30 - 11.00"));
      }
      if(slot3){
        indexs.add(slot.indexOf("11.00 - 12.30"));
      }
      if(slot4){
        indexs.add(slot.indexOf("13.00 - 14.30"));
      }
      if(slot5){
        indexs.add(slot.indexOf("14.30 - 16.00"));
      }
      if(slot6){
        indexs.add(slot.indexOf("16.00 - 17.30"));
      }
      print(indexs);
      for(var slots in indexs) {
        if(slots != -1){
          isintime += 1;
        }
      }
      print(isintime);
      return isintime;
  }
  Widget loaddata(BuildContext context){
    var datasize = MediaQuery.of(context);
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('Motorcycleforrent').where("day", isEqualTo: 25).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) { 
          print("wait");
          return Container(
          height: datasize.size.height/1.4,
          child: Center(
            child: Text(UseString.notfound,
              style: TextStyle(fontWeight: FontWeight.normal,fontSize: datasize.textScaleFactor*36,color: Colors.white),
            ),
          ),
        );
      }else{
        return loaddata2(context, snapshot.data.documents);
      }
      },
    );
  }
   Widget loaddata2(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => loaddata3(context, data)).toList(),
    );
  }

  uploadpiority(Listcarslot timeshow,int priority){
    Datamanager.firestore.collection('Motorcycleforrent')
                          .document(timeshow.motorforrentdocid)
                          .updateData({'priority' : priority})
                          .whenComplete((){
                            print('complete add priority');
                          });
  }
  Widget loaddata3(BuildContext context, DocumentSnapshot data) {
    var datasize = MediaQuery.of(context);
    var timesshow = Listcarslot.fromSnapshot(data);
    if(timesshow.ownerdocid != Datamanager.user.documentid){
      int priority = checkmatch(timesshow);
      uploadpiority(timesshow,priority);
    }
    return Container();
  }
  Widget load(BuildContext context){
    if(DataFetch.fetchpiority == 0){
      return loaddata(context);
    }else{
      return Container();
    }
  }
  wait(){
    Future.delayed(const Duration(milliseconds: 1000), () {
      // print('wait');
      DataFetch.fetchpiority = 1;
      setState(() {
      });
    });
  }
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Listcar"),
        backgroundColor: Colors.transparent, 
        elevation: 0.0, 
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left,
          color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
            DataFetch.fetchpiority = 0;
          },
          // tooltip: 'Share',
        ),
      ),
      backgroundColor: PickCarColor.colormain,
      body: Stack(
        children: <Widget>[
          load(context),
          _buildBody(context),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    var datasize = MediaQuery.of(context);
    if(DataFetch.fetchpiority == 0){
      wait();
      return Center(
        child: Container(
          width: datasize.size.width,
          height: datasize.size.height,
          color: PickCarColor.colormain,
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 120),
                child: SpinKitCircle(
                  color: Colors.white,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                child:  Text(UseString.searching,
                  style: TextStyle(fontWeight: FontWeight.normal,fontSize: datasize.textScaleFactor*25,color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      );
    }else{
      return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('Motorcycleforrent').where("day", isEqualTo: 25).orderBy('priority', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
             return Container(
              height: datasize.size.height/1.4,
              child: Center(
                child: Text(UseString.notfound,
                  style: TextStyle(fontWeight: FontWeight.normal,fontSize: datasize.textScaleFactor*36,color: Colors.white),
                ),
              ),
            );
          }else{
            return _buildList(context, snapshot.data.documents);
          }
        },
      );
    }
  }
 

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }
  
  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    var datasize = MediaQuery.of(context);
    final timeslot = Listcarslot.fromSnapshot(data);
    var imageusershow;
    MotorcycleShow motorshow;
    Usershow usershow;
    Future<DocumentSnapshot> fetchdatamotorcycle(String docid) async {
    return await Datamanager.firestore.collection('Motorcycle')
                          .document(docid)
                          .get();
    }
    Future<String> _getImage(BuildContext context,Usershow usershow) async {
     return await FirebaseStorage.instance
                                  .ref()
                                  .child('User')
                                  .child(usershow.uid)
                                  .child(usershow.profilepicpath+'.'+usershow.profilepictype).getDownloadURL();
    }
    addgroupchat(Usershow usershow){
      Datamanager.firestore.collection('chat')
                            .document(Datamanager.user.documentchat)
                            .collection('groupchat').document(usershow.documentid);
    }
    // timeslot.ownerdocid != Datamanager.user.documentid &&
    if( timeslot.university == 'Chaing Mai University'){
      if(checkmatch(timeslot) != 0){
          return GestureDetector(
            onTap: (){
              Datamanager.usershow = usershow;
              Datamanager.motorcycleShow = motorshow;
              Datamanager.listcarslot = timeslot;
              Datamanager.usershow.imageurl = imageusershow;
              Navigator.of(context).pushNamed(Datamanager.slottiempage);
            },
            child: FutureBuilder<DocumentSnapshot>(
            future: fetchdatamotorcycle(timeslot.motorcycledocid), 
            builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if( snapshot.connectionState == ConnectionState.waiting){
                  return Stack(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            //  color: Colors.black,
                          ),
                          width: datasize.size.width,
                          height: 300,
                          child: Image.asset('assets/images/imagesearch/background.png',fit: BoxFit.fill,),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20,left: 30),
                          color: Colors.grey,
                          width: 320,
                          height: 26,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 60,top: 58),
                          color: Colors.grey[600],
                          width: 190,
                          height: 160,
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 228,left: 20),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(left: 10),
                                    width: 45,
                                    height: 45,
                                    decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey,
                                      )
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 10),),
                                Container(
                                  color: Colors.grey,
                                  width: 140,
                                  height: 30,
                                ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 230,left: 30),
                              width: 120,
                              height: 30,
                              color: Colors.grey,
                            ),
                          ],
                        ),


                        Container(
                          margin: EdgeInsets.only(left: 270,top: 60),
                          width: 50,
                          height: 20,
                          color: Colors.grey,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 280,top: 88),
                          child: Column(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(top: 8),
                                height: 20,
                                width: 100,
                                color: Colors.grey,
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 8),
                                height: 20,
                                width: 100,
                                color: Colors.grey,
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 8),
                                height: 20,
                                width: 100,
                                color: Colors.grey,
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 8),
                                height: 20,
                                width: 100,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
              }else{
                  if (snapshot.hasError)
                    return Center(child: Text('Error: ${snapshot.error}'));
                  else{
                    motorshow = MotorcycleShow.fromSnapshot(snapshot.data);
                    // print(motorshow.generation+' '+ motorshow.brand);
                    return Stack(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            //  color: Colors.black,
                          ),
                          width: datasize.size.width,
                          height: 300,
                          child: Image.asset('assets/images/imagesearch/background.png',fit: BoxFit.fill,),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20,left: 30),
                          child: Text(motorshow.brand+" "+motorshow.generation),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 60,top: 58),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            //  color: Colors.black,
                            image: new DecorationImage(
                                              fit: BoxFit.fill,
                                              image: new NetworkImage(
                                                  motorshow.motorleftlink)
                                            )
                          ),
                          width: 190,
                          height: 160,
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              width: 350,
                              height: 50,
                              margin: EdgeInsets.only(left: 20,top: 228),
                              // color: Colors.black,
                              child:  GestureDetector(
                                onTap: (){
                                  // addgroupchat(usershow);
                                  print('tttt');
                                  Datamanager.usershow = usershow;
                                  Datamanager.motorcycleShow = motorshow;
                                  Datamanager.listcarslot = timeslot;
                                  Navigator.of(context).pushNamed(Datamanager.editdetail);
                                },
                                child: StreamBuilder<QuerySnapshot>(
                                  stream: Firestore.instance.collection('User').where("uid", isEqualTo: motorshow.owneruid).snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting){
                                      return LinearProgressIndicator();
                                    }else if(snapshot.hasError){
                                      return LinearProgressIndicator();
                                    }else{
                                      var datadocument;
                                      snapshot.data.documents.map((data){
                                        datadocument = data;
                                      }).toList();
                                      usershow = Usershow.fromSnapshot(datadocument);
                                      return Stack(
                                        children: <Widget>[
                                          Container(
                                            width: 350,
                                            height: 45,
                                            color: Colors.transparent,
                                          ),
                                          FutureBuilder(
                                            future: _getImage(context, usershow),
                                            builder: (context, snapshot) {
                                              imageusershow = snapshot.data;
                                              if (snapshot.connectionState == ConnectionState.waiting){
                                                return Container(
                                                );
                                              }
                                              if (snapshot.hasError){
                                                return Container(
                                                );
                                              }else{
                                                return Row(
                                                  children: <Widget>[
                                                    Container(
                                                      margin: EdgeInsets.only(left: 10),
                                                      child: Text(UseString.forrent,
                                                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: datasize.textScaleFactor*20,color: PickCarColor.colorcmu),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(left: 10),
                                                      width: 45,
                                                      height: 45,
                                                      decoration: new BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        image: new DecorationImage(
                                                            fit: BoxFit.fill,
                                                            image: new NetworkImage(
                                                                snapshot.data)
                                                          )
                                                        )
                                                    ),
                                                    Padding(padding: EdgeInsets.only(left: 10),),
                                                    Text(usershow.name,
                                                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: datasize.textScaleFactor*25,color: PickCarColor.colorcmu),
                                                    ),
                                                  ],
                                                );
                                              }
                                            },
                                          ),
                                        ],
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 270,top: 60),
                          child: Text(UseString.detail,
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: datasize.textScaleFactor*18,color: PickCarColor.colorFont2),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 280,top: 88),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    height: 25,
                                    width: 25,
                                    child: Image.asset('assets/images/imagesearch/gears.png',fit: BoxFit.fill,),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 2),
                                    child: Text(motorshow.gear+' ',
                                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: datasize.textScaleFactor*16,color: PickCarColor.colorFont2),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(top: 5),
                                    height: 25,
                                    width: 25,
                                    child: Image.asset('assets/images/imagesearch/cc.png',fit: BoxFit.fill,),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 2,top: 5),
                                    child: Text(motorshow.cc.toString()+' '+UseString.cc,
                                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: datasize.textScaleFactor*16,color: PickCarColor.colorFont2),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(top: 5),
                                    height: 25,
                                    width: 25,
                                    child: Image.asset('assets/images/imagesearch/gas.png',fit: BoxFit.fill,),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 2,top: 5),
                                    child: Text(motorshow.cc.toString()+' '+UseString.cc,
                                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: datasize.textScaleFactor*16,color: PickCarColor.colorFont2),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(top: 5),
                                    height: 25,
                                    width: 25,
                                    child: Image.asset('assets/images/imagesearch/color.png',fit: BoxFit.fill,),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 2,top: 5),
                                    child: Text(motorshow.color.toString(),
                                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: datasize.textScaleFactor*16,color: PickCarColor.colorFont2),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
              }
            },
          ),
        );
      }else{
        return Container(
          height: datasize.size.height/1.4,
          child: Center(
            child: Text(UseString.notfound,
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: datasize.textScaleFactor*36,color: PickCarColor.colorFont2),
            ),
          ),
        );
      }
    }else{
      return Container(
        height: datasize.size.height/1.4,
        child: Center(
          child: Text(UseString.notfound,
            style: TextStyle(fontWeight: FontWeight.normal,fontSize: datasize.textScaleFactor*36,color: Colors.white),
          ),
        ),
      );
    }
  }
}


