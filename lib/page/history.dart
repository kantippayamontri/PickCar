import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pickcar/bloc/listcar/listcarbloc.dart';
import 'package:pickcar/bloc/listcar/listcarevent.dart';
import 'package:pickcar/bloc/listcar/listcarstate.dart';
import 'package:pickcar/datamanager.dart';
import 'package:pickcar/models/booking.dart';
import 'package:pickcar/models/boxlocation.dart';
import 'package:pickcar/models/listcarslot.dart';
import 'package:pickcar/models/motorcycle.dart';
import 'package:pickcar/page/registercarlist.dart';
import 'package:pickcar/widget/listcar/listcatitem.dart';

class HistoryPage extends StatefulWidget {
  int indicatorpage = 0;
  var motorshow;
  int i =0;
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> with TickerProviderStateMixin{
  ListCarBloc _listCarBloc;
  
  @override
  void initState() {
    widget.indicatorpage = 0;
    // TODO: implement initState
    _listCarBloc = ListCarBloc(context: this.context);
    _listCarBloc.add(ListCarLoadingDataEvent());
    super.initState();
  }
  String monthy(int month) {
    switch (month) {
      case 1:
        return 'Jan';
        break;
      case 2:
        return 'Feb';
        break;
      case 3:
        return 'Mar';
        break;
      case 4:
        return 'Apr';
        break;
      case 5:
        return 'May';
        break;
      case 6:
        return 'Jun';
        break;
      case 7:
        return 'Jul';
        break;
      case 8:
        return 'Aug';
        break;
      case 9:
        return 'Sep';
        break;
      case 10:
        return 'Oct';
        break;
      case 11:
        return 'Nov';
        break;
      default:
        return 'Dec';
        break;
    }
  }
  @override
  Widget build(BuildContext context) {
    // var a = true;
    // while(a){
    //   try{
    //     print(a);
    //     Realtime.timecar.cancel();
    //     Realtime.timekey.cancel();
    //   }catch(e){
    //     a =false;
    //   } 
    // }
    var data = MediaQuery.of(context);
    final List<Tab> myTabs = <Tab>[
      new Tab(
        child: Container(
          margin: EdgeInsets.only(top: 10),
          child: Text(UseString.bookedhistory,
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*20,color: PickCarColor.colormain), 
            ),
        ),
      ),
      new Tab(
        child: Container(
          margin: EdgeInsets.only(top: 10),
          child: Text(UseString.renthistory,
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*20,color: PickCarColor.colormain), 
          ),
        ),
      ),
    ];

    TabController _tabController;
    _tabController = new TabController(vsync: this, length: myTabs.length,initialIndex: widget.indicatorpage);
    widgetcard(Bookingshow booking,var datasize,BuildContext context){
      var motorshow;
       return GestureDetector(
        onTap: (){
          Datamanager.motorcycleShow = motorshow;
          Datamanager.booking = booking;
          // Datamanager.placelocationshow = widget.locationshow;
          // Datamanager.boxlocationshow= widget.boxshow;
          Navigator.of(context).pushNamed(Datamanager.receivecar);
        },
        child: Stack(
          children: <Widget>[
            Container(
              width: datasize.size.width,
              height: 150,
              child: Image.asset('assets/images/imagesearch/card.png',fit: BoxFit.fill,),
            ),
            FutureBuilder<DocumentSnapshot>(
              future: Firestore.instance.collection('Motorcycle').document(booking.motorcycledocid).get(),
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 50),
                      child: SpinKitCircle(
                        color: PickCarColor.colormain,
                      ),
                    ),
                  );
                }
                if (!snapshot.hasData) {
                  return Container(
                    width: double.infinity,
                    child: Text(UseString.donthavehistory,
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: datasize.textScaleFactor*30,color: PickCarColor.colorFont1), 
                    ),
                  );
                }else if(snapshot.hasData){
                  motorshow = MotorcycleShow.fromSnapshot(snapshot.data);
                  // print(snapshot.data.documents);
                  // return Container();
                  return Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 20,left: 30),
                        width: 150,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: NetworkImage(motorshow.motorfrontlink),
                            fit: BoxFit.fill,
                          ),
                        ),
                        // child: Image.network(widget.motorshow.motorfrontlink,fit: BoxFit.fill,),
                      ),
                      Column(
                        children: <Widget>[
                          SizedBox(height: 15,),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text(motorshow.brand +" "+ motorshow.generation,
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: datasize.textScaleFactor*25,color: Colors.grey), 
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            // margin: EdgeInsets.only(left: 10),
                            child: Text(UseString.date +" : "+ booking.day.toString()+" "+monthy(booking.month)+" "+booking.year.toString(),
                              style: TextStyle(fontWeight: FontWeight.bold,fontSize: datasize.textScaleFactor*20,color: Colors.grey), 
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(left: 10),
                            child: Text(UseString.time +" : "+ booking.time,
                              style: TextStyle(fontWeight: FontWeight.bold,fontSize: datasize.textScaleFactor*20,color: Colors.grey), 
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(left: 10),
                            child: Text(UseString.price +" : "+ booking.price.toString()+'฿',
                              style: TextStyle(fontWeight: FontWeight.bold,fontSize: datasize.textScaleFactor*20,color: Colors.grey), 
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }else{
                  return Container();
                }
              },
            ),
          ],
        ),
      );
    }
    Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
      var booking;
      var datasize = MediaQuery.of(context);
      booking = Bookingshow.fromSnapshot(data);
      return widgetcard(booking,datasize,context);
    }
    Widget _buildListItemrent(BuildContext context, DocumentSnapshot data) {
      var booking;
      var datasize = MediaQuery.of(context);
      booking = Bookingshow.fromSnapshot(data);
      return widgetcard(booking,datasize,context);
    }
    Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
      return ListView(
        padding: const EdgeInsets.only(top: 20.0),
        children: snapshot.map((data) => _buildListItem(context, data)).toList(),
      );
    }
     Widget _buildListrent(BuildContext context, List<DocumentSnapshot> snapshot) {
      return ListView(
        padding: const EdgeInsets.only(top: 20.0),
        children: snapshot.map((data) => _buildListItemrent(context, data)).toList(),
      );
    }
    body(BuildContext context){
      if(widget.indicatorpage == 0){
        return StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection('Booking')
                      .where("myid", isEqualTo: Datamanager.user.documentid)
                      .where("status", isEqualTo: "end")
                      .orderBy("startdate")
                      .snapshots(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return Container(
                height: data.size.height/1.4,
                child: Center(
                  child: Text(UseString.donthavehistory,
                    style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*30,color: PickCarColor.colorFont1),
                  ),
                ),
              );
            }
            if (!snapshot.hasData) {
              return Container(
                height: data.size.height/1.4,
                child: Center(
                  child: Text(UseString.donthavehistory,
                    style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*30,color: PickCarColor.colorFont1),
                  ),
                ),
              );
            }else{
              // print(snapshot.data.documents);
              // return Container();
              return _buildList(context, snapshot.data.documents);
            }
          },
        ); 
      }else{
         return StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection('Booking')
                      .where("ownerid", isEqualTo: Datamanager.user.documentid)
                      .where("status", isEqualTo: "end")
                      .orderBy("startdate")
                      .snapshots(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return Container(
                height: data.size.height/1.4,
                child: Center(
                  child: Text(UseString.donthavehistory,
                    style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*30,color: PickCarColor.colorFont1),
                  ),
                ),
              );
            }
            if (!snapshot.hasData) {
              return Container(
                height: data.size.height/1.4,
                child: Center(
                  child: Text(UseString.donthavehistory,
                    style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*30,color: PickCarColor.colorFont1),
                  ),
                ),
              );
            }else{
              // print(snapshot.data.documents);
              // return Container();
              return _buildListrent(context, snapshot.data.documents);
            }
          },
        ); 
      }
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        flexibleSpace: Image(
            image: AssetImage('assets/images/imagesprofile/appbar/background.png'),
            fit: BoxFit.cover,
          ),
        centerTitle: true,
        bottom: TabBar(
            controller: _tabController,
            labelColor: PickCarColor.colormain,
            tabs: myTabs,
            indicatorColor: PickCarColor.colormain,
            onTap: (data){
              setState(() {
                widget.indicatorpage=data;
                print(widget.indicatorpage);
                widget.i =0;
              });
            },
          ),
        title: Text(UseString.history,
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
      body: body(context),
      );
  }
}