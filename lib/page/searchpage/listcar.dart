import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:pickcar/datamanager.dart';
import 'package:pickcar/models/listcarslot.dart';
import 'package:pickcar/widget/profile/profileImage.dart';
class Listcar extends StatefulWidget {
  @override
  _ListcarState createState() => _ListcarState();
}

class _ListcarState extends State<Listcar> {
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
            DataFetch.fetchmotor = 0;
          },
          // tooltip: 'Share',
        ),
      ),
      backgroundColor: PickCarColor.colormain,
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('Motorcycleforrent').where("day", isEqualTo: 14).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.documents);
      },
    );
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
    
      return GestureDetector(
        onTap: (){
          Navigator.of(context).pushNamed(Datamanager.detailsearch);
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
                          width: 230,
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
                                  print(usershow.name);
                                  return Stack(
                                    children: <Widget>[
                                      Container(
                                        width: 190,
                                        height: 45,
                                        color: Colors.transparent,
                                      ),
                                      FutureBuilder(
                                        future: _getImage(context, usershow),
                                        builder: (context, snapshot) {
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
                        Container(
                          margin: EdgeInsets.only(top: 230),
                          child: Text(timeslot.price.toString(),
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: datasize.textScaleFactor*25,color: PickCarColor.colorFont1),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 230),
                          child: Text(' '+Currency.thb,
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: datasize.textScaleFactor*25,color: PickCarColor.colorFont1),
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

  }
}


