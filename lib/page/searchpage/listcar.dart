import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:pickcar/datamanager.dart';
import 'package:pickcar/models/listcarslot.dart';
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
      
      return FutureBuilder<DocumentSnapshot>(
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
                    height: 250,
                    child: Image.asset('assets/images/imagesearch/background.png',fit: BoxFit.fill,),
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
                    width: 180,
                    height: 160,
                    child: Image.network(motorshow.motorleftlink,fit: BoxFit.fill,),
                  ),
                  Container(
                    width: 200,
                    height: 50,
                    margin: EdgeInsets.only(left: 20,top: 228),
                    // color: Colors.black,
                    child:  StreamBuilder<QuerySnapshot>(
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
                                    return Container(
                                      child: Image.network(snapshot.data),
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
                ],
              );
            }
        }
      },
    );
  }
}


