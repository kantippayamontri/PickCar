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

class ListCarPage extends StatefulWidget {
  int indicatorpage = 0;
  var motorshow;
  int i =0;
  @override
  _ListCarPageState createState() => _ListCarPageState();
}

class _ListCarPageState extends State<ListCarPage> with TickerProviderStateMixin{
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
          child: Text(UseString.booked,
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*20,color: PickCarColor.colormain), 
            ),
        ),
      ),
      new Tab(
        child: Container(
          margin: EdgeInsets.only(top: 10),
          child: Text(UseString.registercar,
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*20,color: PickCarColor.colormain), 
          ),
        ),
      ),
    ];
    TabController _tabController;
    _tabController = new TabController(vsync: this, length: myTabs.length,initialIndex: widget.indicatorpage);
     Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
      var booking;
      var datasize = MediaQuery.of(context);
      booking = Bookingshow.fromSnapshot(data);
      return GestureDetector(
        onTap: (){
          Datamanager.motorcycleShow = widget.motorshow;
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
                    child: Text(UseString.notbooked,
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: datasize.textScaleFactor*30,color: PickCarColor.colorFont1), 
                    ),
                  );
                }else if(snapshot.hasData){
                  widget.motorshow = MotorcycleShow.fromSnapshot(snapshot.data);
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
                            image: NetworkImage(widget.motorshow.motorfrontlink),
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
                            child: Text(widget.motorshow.brand +" "+ widget.motorshow.generation,
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: datasize.textScaleFactor*25,color: PickCarColor.colormain), 
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            // margin: EdgeInsets.only(left: 10),
                            child: Text(UseString.date +" : "+ booking.day.toString()+" "+monthy(booking.month)+" "+booking.year.toString(),
                              style: TextStyle(fontWeight: FontWeight.bold,fontSize: datasize.textScaleFactor*20,color: PickCarColor.colorFont1), 
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(left: 10),
                            child: Text(UseString.time +" : "+ booking.time,
                              style: TextStyle(fontWeight: FontWeight.bold,fontSize: datasize.textScaleFactor*20,color: PickCarColor.colorFont1), 
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(left: 10),
                            child: Text(UseString.price +" : "+ booking.price.toString()+'฿',
                              style: TextStyle(fontWeight: FontWeight.bold,fontSize: datasize.textScaleFactor*20,color: PickCarColor.colorFont1), 
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
    Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
      return ListView(
        padding: const EdgeInsets.only(top: 20.0),
        children: snapshot.map((data) => _buildListItem(context, data)).toList(),
      );
    }
    body(BuildContext context){
      if(widget.indicatorpage == 0){
        // return RaisedButton(
        //   onPressed: (){
        //     Navigator.of(context).pushNamed(Datamanager.receivecar);
        //   },
        //   child: Text('goto receive booked'),
        // );
        return StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection('Booking')
                      .where("myid", isEqualTo: Datamanager.user.documentid)
                      .orderBy("day")
                      .snapshots(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return Container(
                height: data.size.height/1.4,
                child: Center(
                  child: Text(UseString.notbooked,
                    style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*30,color: PickCarColor.colorFont1),
                  ),
                ),
              );
            }
            if (!snapshot.hasData) {
              return Container(
                height: data.size.height/1.4,
                child: Center(
                  child: Text(UseString.notbooked,
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
        return Registercarlist();
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
        title: Text(UseString.logo,
            style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*25,color: Colors.white), 
        ),
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left,
          color: Colors.transparent,
          ),
          onPressed: () {
            // Navigator.pop(context);
          },
        ),
      ),
      body: body(context),
      );
  }
}