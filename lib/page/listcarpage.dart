import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
import 'package:pickcar/ui/uisize.dart';
import 'package:pickcar/widget/listcar/listcatitem.dart';

class ListCarPage extends StatefulWidget {
  bool visible = false;
  List<Bookingshow> listbook = new List();
  List<MotorcycleShow> listmotorshow = new List();
  int indicatorpage = 0;
  var motorshow;
  int i =0;
  double width = 0;
  bool datasent = false;
  bool showdialog = true;
  String type;
  @override
  _ListCarPageState createState() => _ListCarPageState();
}

class _ListCarPageState extends State<ListCarPage> with TickerProviderStateMixin{
  ListCarBloc _listCarBloc;
  
  @override
  void initState() {
    // widget.nub = true;
    // widget.width = 0;
    // widget.visible = false;
    // widget.indicatorpage = 0;
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
  
  showwarningcancel(BuildContext context,Bookingshow booking) async {
    var datasize = MediaQuery.of(context);
     showDialog(barrierDismissible: false,context: context,builder:  (BuildContext context){
        return AlertDialog(
          title: Center(
            child: Column(
              children: <Widget>[
                Text(UseString.areyousure,
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: SizeConfig.blockSizeHorizontal*5,color: PickCarColor.colorFont1), 
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*4),
                        child: RaisedButton(
                          color: PickCarColor.colorbuttom,
                          onPressed: () {
                            Firestore.instance.collection('Booking')
                                        .document(booking.bookingdocid)
                                        .updateData({'iscancle':true,'rentercanclealert':true})
                                        .whenComplete(() async {
                                          Booking book = Booking(
                                            times:booking.time,
                                            day:booking.day,
                                            month:booking.month,
                                            year:booking.year,
                                            price:booking.price,
                                            motorcycledocid:booking.motorcycledocid,
                                            ownerid:booking.ownerid,
                                            bookingdocid:booking.bookingdocid,
                                            boxdocid:booking.boxdocid,
                                            boxplacedocid:booking.boxplacedocid,
                                            boxslotrentdocid:booking.boxslotrentdocid,
                                            motorplacelocdocid:booking.motorplacelocdocid,
                                            university:booking.university,
                                            status:null,
                                            startdate:booking.startdate,
                                            iscancle:false,
                                            ownercanclealert:false,
                                            rentercanclealert:false,
                                            docid: booking.bookingdocid,
                                          );
                                          print(booking.ownerid);
                                          await Firestore.instance.collection('Singleforrent')
                                                            .document(booking.bookingdocid)
                                                            .setData(book.toJson())
                                                            .whenComplete(() async {
                                                              await Firestore.instance.collection('history')
                                                                    .document(Datamanager.user.documentid)
                                                                    .collection('historylist')
                                                                    .document(booking.bookingdocid)
                                                                    .updateData({'ishistory':true,'iscancel':true,"whocancel":"renter"});
                                                              await Firestore.instance.collection('history')
                                                                    .document(booking.ownerid)
                                                                    .collection('historylist')
                                                                    .document(booking.bookingdocid)
                                                                    .updateData({'ishistory':true,'iscancel':true,"whocancel":"renter"});
                                                              Navigator.pop(context);
                                                            }); 
                                          
                                        });
                          },
                          child: Text('Confirm',
                            // style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Color(0x78849E)),
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: datasize.textScaleFactor*15,color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*4),
                        child: RaisedButton(
                        color: PickCarColor.colorbuttom,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancel',
                          // style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Color(0x78849E)),
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: datasize.textScaleFactor*15,color: Colors.white),
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
  showcancelbooking(BuildContext context){
    var data = MediaQuery.of(context);
    if(widget.indicatorpage == 0){
      return Stack(
        children: <Widget>[
          Visibility(
              visible: !widget.visible,
              child: Container(
                margin: EdgeInsets.only(right:SizeConfig.blockSizeHorizontal*5,top: SizeConfig.blockSizeVertical),
                child: IconButton(
                  icon: Icon(Icons.reorder,color: Colors.white,size: SizeConfig.blockSizeHorizontal*10,),
                  onPressed: (){
                    setState(() {
                        widget.visible = true;
                        widget.width = SizeConfig.blockSizeHorizontal *12;
                    });
                  },
                ),
              ),
            ),
            Visibility(
              visible: widget.visible,
              child: Container(
                margin: EdgeInsets.only(top:SizeConfig.blockSizeVertical*2),
                child: FlatButton(
                  child: Text(UseString.cancelappbar,
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*16,color: Colors.white),
                  ),
                  onPressed: (){
                    setState(() {
                        widget.visible = false;
                        widget.width = 0;
                    });
                  },
                ),
              ),
            ),
        ],
      );
    }else{
      return Container();
    }
    
  }
  @override
  Widget build(BuildContext context) {
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
      Bookingshow booking;
      var datasize = MediaQuery.of(context);
      booking = Bookingshow.fromSnapshot(data);
      return GestureDetector(
        onTap: () async {
          Datamanager.motorcycleShow = widget.motorshow;
          Datamanager.booking = booking;
          // Datamanager.placelocationshow = widget.locationshow;
          // Datamanager.boxlocationshow= widget.boxshow;
          
          await Firestore.instance.collection('User').document(booking.ownerid).get().then((data) async {
            Usershow usershow = Usershow.fromSnapshot(data);
            Datamanager.usershow = usershow;
            var image = FirebaseStorage.instance
                .ref()
                .child('User')
                .child(usershow.uid)
                .child(usershow.profilepicpath+'.'+usershow.profilepictype);
            image.getDownloadURL().then((data){
              Datamanager.imageusershow = data;
              Navigator.of(context).pushNamed(Datamanager.receivecar);
            });
          });
        },
        child: Stack(
          children: <Widget>[
            Container(
              width: datasize.size.width,
              height: SizeConfig.blockSizeVertical*21,
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
                  return Stack(
                    children: <Widget>[
                      Visibility(
                        visible: widget.visible,
                        child: Container(
                          margin: EdgeInsets.only(left:SizeConfig.blockSizeHorizontal*8,top: SizeConfig.blockSizeVertical*1.5),
                          width: widget.width-SizeConfig.blockSizeHorizontal*5,
                          height: SizeConfig.blockSizeVertical*17,
                          decoration: BoxDecoration(
                            // borderRadius: BorderRadius.circular(14),
                            color: Colors.red,
                          ),
                        ),
                      ),
                      Visibility(
                        visible: widget.visible,
                        child: Container(
                          margin: EdgeInsets.only(left:SizeConfig.blockSizeHorizontal*3,top: SizeConfig.blockSizeVertical*1.5),
                          width: widget.width,
                          height: SizeConfig.blockSizeVertical*17,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.red,
                          ),
                          child: IconButton(
                            icon: Icon(Icons.clear),
                            color: Colors.white,
                            onPressed: (){
                              showwarningcancel(context,booking);
                            },
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: SizeConfig.blockSizeHorizontal*5,left: widget.width+SizeConfig.blockSizeHorizontal*5),
                        width: SizeConfig.blockSizeHorizontal*35,
                        height: SizeConfig.blockSizeVertical*14,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: NetworkImage(widget.motorshow.motorfrontlink),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      
                      Container(
                        margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*43+widget.width,top: SizeConfig.blockSizeVertical*3,right: SizeConfig.blockSizeHorizontal*3),
                        width: SizeConfig.blockSizeVertical*31,
                        child: AutoSizeText(widget.motorshow.brand +" "+ widget.motorshow.generation,
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: datasize.textScaleFactor*22,color: PickCarColor.colormain), 
                        maxLines: 1,
                        ),
                      ),
                      Container(
                        // color: Colors.black,
                        margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*44+widget.width,top: SizeConfig.blockSizeVertical*7,right: SizeConfig.blockSizeHorizontal*3),
                        width: SizeConfig.blockSizeVertical*31,
                        // color: Colors.black,
                        height: SizeConfig.blockSizeVertical*11,
                        child: AutoSizeText(UseString.date +" : "+ booking.day.toString()+" "+monthy(booking.month)+" "+booking.year.toString()
                                +"\n"+UseString.time +" : "+ booking.time+"\n"+UseString.price +" : "+ booking.price.toString()+'฿',
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: datasize.textScaleFactor*20,color: PickCarColor.colorFont1), 
                        maxLines: 3,
                        ),
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
      SizeConfig().init(context);
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
                      .where('iscancle',isEqualTo: false)
                      .where("isinhistory", isEqualTo: false)
                      .orderBy("startdate")
                      .snapshots(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return Container(
                // height: data.size.height/1.4,
                // child: Center(
                //   child: Text(UseString.notbooked,
                //     style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*30,color: PickCarColor.colorFont1),
                //   ),
                // ),
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
              if(snapshot.data.documents.length !=0){
                return _buildList(context, snapshot.data.documents);
              }else{
                return Center(
                  child: Text(UseString.notbooked,
                    style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*30,color: PickCarColor.colorFont1),
                  ),
                );
              }
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
                widget.i =0;
              });
            },
          ),
        actions: <Widget>[
          showcancelbooking(context),
        ],
        title: Container(
          width: SizeConfig.blockSizeHorizontal*20,
          child: Image.asset('assets/images/imagelogin/logo.png',fit: BoxFit.fill,)
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
  dispose() {
    // Realtime.checkalert.cancel();
  super.dispose();
  }
}