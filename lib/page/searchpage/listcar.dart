import 'package:cloud_firestore/cloud_firestore.dart';
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
    Future<DocumentSnapshot> fetchdatamotorcycle(String docid) async {
    return await Datamanager.firestore.collection('Motorcycle')
                          .document(docid)
                          .get();
    }
      
      return FutureBuilder<DocumentSnapshot>(
      future: fetchdatamotorcycle(timeslot.motorcycledocid), // function where you call your api
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if( snapshot.connectionState == ConnectionState.waiting){
            return  Center(child: Text('Please wait its loading...'));
        }else{
            if (snapshot.hasError)
              return Center(child: Text('Error: ${snapshot.error}'));
            else{
              motorshow = MotorcycleShow.fromSnapshot(snapshot.data);
              // print(motorshow.generation+' '+ motorshow.brand);
              return Stack(
                children: <Widget>[
                  Text(motorshow.generation),
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
            }
        }
      },
    );
  }
}


