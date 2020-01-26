import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pickcar/datamanager.dart';
import 'package:pickcar/models/listcarslot.dart';


class SlotTimePage extends StatefulWidget {
  @override
  _SlotTimePageState createState() => _SlotTimePageState();
}

class _SlotTimePageState extends State<SlotTimePage> {
  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
       backgroundColor: Colors.white,
       flexibleSpace: Image(
          image: AssetImage('assets/images/imagesprofile/appbar/background.png'),
          fit: BoxFit.cover,
        ),
       centerTitle: true,
       title: Text(UseString.selecttime,
          style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*25,color: Colors.white), 
       ),
       leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left,
          color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
            DataFetch.fetchpiority = 0;
            DataFetch.checkhavedata = 0;
            DataFetch.checknotsamenoresult = 0;
            DataFetch.checknothaveslottime = 0;
            Datamanager.motorcycleShow = null;
            Datamanager.usershow= null;
            Datamanager.listcarslot= null;
            Datamanager.slottime= null;
          },
        ),
      ),
      // backgroundColor: PickCarColor.colormain,
      body: _buildBody(context),
    );
  }
  Widget _buildBody(BuildContext context) {
    print(Datamanager.listcarslot.motorforrentdocid);
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('MotorcycleforrentSlot')
                                .where("motorforrentdocid", isEqualTo: Datamanager.listcarslot.motorforrentdocid)
                                .snapshots(),
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
    final slottime = Slottime.fromSnapshot(data);
    return GestureDetector(
      onTap: (){
        Datamanager.slottime = slottime;
        Navigator.of(context).pushNamed(Datamanager.detailsearch);
      },
      child: Container(
        // margin: EdgeInsets.only(top: 5),
        width: datasize.size.width,
        height: 100,
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(10),
          //  color: Colors.grey[300],
           image: new DecorationImage(
            fit: BoxFit.fill,
            image: new AssetImage(
                'assets/images/imagesearch/card.png'),
          )
        ),
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 30),
              width: 50,
              height: 50,
              child: Image.asset('assets/images/imagesearch/cc.png'),
            ),
            Container(
              margin: EdgeInsets.only(left:20),
              child: Text(slottime.timeslot,
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: datasize.textScaleFactor*25,color: PickCarColor.colorFont2), 
              ),
            ),
            Container(
              margin: EdgeInsets.only(left:35),
              child: Text(slottime.price.toString()+' '+Currency.thb,
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: datasize.textScaleFactor*25,color: PickCarColor.colorFont2), 
              ),
            ),
          ],
        ),
      ),
    );
  }
}

