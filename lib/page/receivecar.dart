import 'dart:async';
import 'package:pickcar/models/booking.dart';
import 'package:pickcar/models/boxslotnumber.dart';
import 'package:pickcar/models/chat.dart';
import 'package:pickcar/models/listcarslot.dart';
import 'package:pickcar/ui/uisize.dart';
import 'package:quiver/async.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pickcar/datamanager.dart';
import 'package:pickcar/models/boxlocation.dart';
import 'package:pickcar/models/boxslotrentshow.dart';
import 'package:pickcar/models/placelocation.dart';

class Receivecar extends StatefulWidget {
  String showtextkey = UseString.notavailable;
  String showtextcar = UseString.notavailable;
  String status_key = "Not Available";
  String status_car = "Not Available";
  // double width = 100;
  double height = 0;
  double top = 560;
  var colorchange =Colors.white;
  var colorchange2 =Colors.white;
  bool statebutton = false;
  bool statebutton2 = false;
  bool _visible1 = true;
  bool _visible2 = true;
  var locationshow;
  var boxshow;
  var colorkey = Colors.red[600];
  var colorcar = Colors.red[600];
  @override
  _ReceivecarState createState() => _ReceivecarState();
}

class _ReceivecarState extends State<Receivecar> {
  CarouselSlider carouselSlider;
  int _current = 0;
  List imgList = [
    Datamanager.motorcycleShow.motorfrontlink,
    Datamanager.motorcycleShow.motorrightlink,
    Datamanager.motorcycleShow.motorleftlink,
    Datamanager.motorcycleShow.motorbacklink,
  ];
 
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }
  @override
  void initState() {
    widget.showtextkey = UseString.notavailable;
    widget.showtextcar = UseString.notavailable;
    widget.statebutton = false;
    widget.statebutton2 = false;
    widget._visible1 = true;
    widget._visible2 = true;
    Realtime.timecar = Timer.periodic(Duration(days: 1), (timer){});
    Realtime.timekey = Timer.periodic(Duration(days: 1), (timer){});
    Checkopenkey.checkkey = false;
    Checkopenkey.checkcar = false;
    DataFetch.checkkey = 0;
    DataFetch.fetchhavecar = 0;
    DataFetch.waitlocation = 0;
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
  fetchboxandlocation() async {
    if(DataFetch.waitlocation ==0){
      await Firestore.instance.collection('boxlocation').document(Datamanager.booking.boxplacedocid).get().then((data){
        Datamanager.boxlocationshow = BoxlocationShow.fromSnapshot(data);
      });
      await Firestore.instance.collection('placelocation').document(Datamanager.booking.motorplacelocdocid).get().then((data){
        Datamanager.placelocationshow = PlacelocationShow.fromSnapshot(data);
      });
      await Firestore.instance.collection('BoxslotRent').document(Datamanager.booking.boxslotrentdocid).get().then((data){
        Datamanager.boxslotrentshow = Boxslotrentshow.fromSnapshot(data);
      });
      Future.delayed(const Duration(milliseconds: 500), () async {
      await Firestore.instance.collection('box')
                    .document(Datamanager.booking.boxdocid)
                    .collection("boxslot")
                    .document(Datamanager.boxslotrentshow.boxslotdocid)
                    .get()
                    .then((data){
          Datamanager.boxslotnumbershow = Boxslotnumbershow.fromSnapshot(data);
        });
      });
      Future.delayed(const Duration(milliseconds: 500), () {
        print('wait');
        // print(Datamanager.boxslotnumbershow.name);
        DataFetch.waitlocation = 1;
        setState(() {
        });
      });
    }
  }
  Widget key(BuildContext context){
    SizeConfig().init(context);
    var data = MediaQuery.of(context);
    return GestureDetector(
      onTap: (){
        // Realtime.timekey.cancel();
        // Realtime.timecar.cancel();
        // Navigator.of(context).pushNamed(Datamanager.openkey);
        setState(() {
          
          if(widget.statebutton && Datamanager.booking.status != 'working'){
            widget.colorchange = Colors.white;
            widget.statebutton = false;
            widget.colorchange2 = Colors.white;
            widget.statebutton2 = false;
            widget._visible1 = !widget._visible1;
            Navigator.of(context).pushNamed(Datamanager.receivekeymap);
            if(!widget._visible2){
              widget._visible2 = !widget._visible2;
            }
          }else if(widget.statebutton && Datamanager.booking.status == 'working'){
            widget.colorchange2 = Colors.white;
            widget.statebutton2 = false;
            widget.colorchange = Colors.white;
            widget.statebutton = false;
            widget._visible1 = !widget._visible1;
            Navigator.of(context).pushNamed(Datamanager.addlocation);
            if(!widget._visible2){
              widget._visible2 = !widget._visible2;
            }
          }else{
            widget.colorchange = PickCarColor.colormain;
            widget.statebutton = true;
            widget._visible1 = !widget._visible1;
          }
          
        });
      },
      child: AnimatedContainer(
        duration: Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*64),
        width: (data.size.width/2) -SizeConfig.blockSizeVertical/2,
        height: SizeConfig.blockSizeVertical*20,
        color: widget.colorchange,
        child: Stack(
          children: <Widget>[
            AnimatedOpacity(
              opacity: widget._visible1 ? 1.0 : 0.0,
              duration: Duration(milliseconds: 500),
              child: Center(
                child: Container(
                  margin: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical*7),
                  width: SizeConfig.blockSizeHorizontal*20,
                  height: SizeConfig.blockSizeVertical*15,
                  child: Image.asset('assets/images/imagereceivecar/keyicon.png',fit: BoxFit.fill),
                ),
              ),
            ),
            AnimatedOpacity(
              opacity: widget._visible1 ? 1.0 : 0.0,
              duration: Duration(milliseconds: 500),
              child: Container(
                // alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*12,left: SizeConfig.blockSizeHorizontal*5),
                width: double.infinity,
                height: SizeConfig.blockSizeVertical*15,
                child: Column(
                  children: <Widget>[
                    Flexible(
                      child: Text(UseString.key,
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*20,color: PickCarColor.colorFont1), 
                      ),
                    ),
                    Flexible(
                      child: Text(widget.showtextkey,
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*20,color: widget.colorkey), 
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //--------------
            AnimatedOpacity(
              opacity: widget._visible1 ? 0.0 : 1.0,
              duration: Duration(milliseconds: 500),
              child: Center(
                child: Container(
                  margin: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical*7),
                  width: SizeConfig.blockSizeHorizontal*20,
                  height: SizeConfig.blockSizeVertical*15,
                  child: Image.asset('assets/images/imagereceivecar/lockicon.png',fit: BoxFit.fill),
                ),
              ),
            ),
            AnimatedOpacity(
              opacity: widget._visible1 ? 0.0 : 1.0,
              duration: Duration(milliseconds: 500),
              child: Container(
                // alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*13,left: SizeConfig.blockSizeHorizontal*3),
                width: double.infinity,
                height: SizeConfig.blockSizeVertical*15,
                child: Column(
                  children: <Widget>[
                    Flexible(
                      child: Text(UseString.openlocker,
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*20,color: Colors.white), 
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget location(BuildContext context){
    var data = MediaQuery.of(context);
    return GestureDetector(
      onTap: (){
        // Realtime.timekey.cancel();
        // Realtime.timecar.cancel();
        // Navigator.of(context).pushNamed(Datamanager.openkey);
        setState(() {
          if(widget.statebutton2 && Datamanager.motorcycleShow.currentlongitude != null  && Datamanager.motorcycleShow.currentlatitude != null && widget.status_car == 'Available'){
            widget.colorchange2 = Colors.white;
            widget.statebutton2 = false;
            widget._visible2 = !widget._visible2;
            Navigator.of(context).pushNamed(Datamanager.bookedmap);
          }else{
            widget.colorchange2 = PickCarColor.colormain;
            widget.statebutton2 = true;
            widget._visible2 = !widget._visible2;
          }
          if(widget._visible2 && widget.status_car == 'Not Available'){
            widget.colorchange2 = Colors.white;
          }
        });
      },
      child: AnimatedContainer(
        duration: Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
        margin: EdgeInsets.only(top:SizeConfig.blockSizeVertical*64,left: (data.size.width/2) +SizeConfig.blockSizeVertical/2),
        width: (data.size.width/2) -SizeConfig.blockSizeVertical/2,
        height: SizeConfig.blockSizeVertical*20,
        color: widget.colorchange2,
        child: Stack(
          children: <Widget>[
            AnimatedOpacity(
              opacity: widget._visible2 ? 1.0 : 0.0,
              duration: Duration(milliseconds: 500),
              child: Center(
                child: Container(
                  margin: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical*7),
                  width: SizeConfig.blockSizeHorizontal*20,
                  height: SizeConfig.blockSizeVertical*15,
                  child: Image.asset('assets/images/imagereceivecar/motorcycleicon.png',fit: BoxFit.fill),
                ),
              ),
            ),
            AnimatedOpacity(
              opacity: widget._visible2 ? 1.0 : 0.0,
              duration: Duration(milliseconds: 500),
              child: Container(
                // alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*12,left: SizeConfig.blockSizeHorizontal*5),
                width: double.infinity,
                height: SizeConfig.blockSizeVertical*15,
                child: Column(
                  children: <Widget>[
                    Flexible(
                      child: Text(UseString.motor,
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*20,color: PickCarColor.colorFont1), 
                      ),
                    ),
                    Flexible(
                      child: Text(widget.showtextcar,
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*20,color: widget.colorcar), 
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //==============
            AnimatedOpacity(
              opacity: widget._visible2 ? 0.0 : 1.0,
              duration: Duration(milliseconds: 500),
              child: Center(
                child: Container(
                  margin: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical*7),
                  width: SizeConfig.blockSizeHorizontal*20,
                  height: SizeConfig.blockSizeVertical*15,
                  child: Image.asset('assets/images/imagereceivecar/mapicon.png',fit: BoxFit.fill),
                ),
              ),
            ),
            AnimatedOpacity(
              opacity: widget._visible2 ? 0.0 : 1.0,
              duration: Duration(milliseconds: 500),
              child: Container(
                // alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*13,left: SizeConfig.blockSizeHorizontal*3),
                width: double.infinity,
                height: SizeConfig.blockSizeVertical*15,
                child: Column(
                  children: <Widget>[
                    Flexible(
                      child: Text(UseString.maploacation,
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*20,color: Colors.white), 
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void startTimer() {
  if(DataFetch.checkkey == 0){
    DataFetch.checkkey =1;
    Realtime.timekey = Timer.periodic(Duration(seconds: 5), (timer) async {
      print(DateTime.now());
      await Firestore.instance.collection('BoxslotRent').document(Datamanager.booking.boxslotrentdocid).get().then((data){
        Datamanager.boxslotrentshow = Boxslotrentshow.fromSnapshot(data);
        // print(Datamanager.booking.day);
        // print(Datamanager.boxslotrentshow);
        if(Datamanager.boxslotrentshow.iskey){
          setState(() {
            Realtime.timekey.cancel();
            widget.status_key = "Available";
          });
        }
      });
    });
  }
  
}
fetchcaravai() async {
  if(DataFetch.fetchhavecar==0){
      await Firestore.instance.collection('Booking').document(Datamanager.booking.bookingdocid).get().then((data){
        Datamanager.booking = Bookingshow.fromSnapshot(data);
      });
      await Firestore.instance.collection('Motorcycle').document(Datamanager.booking.motorcycledocid).get().then((data){
        Datamanager.motorcycleShow = MotorcycleShow.fromSnapshot(data);
      });
      String a =Datamanager.booking.time;
      var result = a.split("-")[0].replaceAll(new RegExp(r' '), '').split(".");
      var minute =int.parse(result[1]);
      var hour =int.parse(result[0]);
      if(minute == 0){
        minute = 45;
        hour = hour-1;
      }else{
        minute = minute -15;
      }
      var now = DateTime.now().hour+(DateTime.now().minute/100);
      var time = hour+(minute/100);
      print(time);
      if(DateTime.now().day == Datamanager.booking.day 
        &&DateTime.now().month == Datamanager.booking.month 
        &&DateTime.now().year == Datamanager.booking.year 
        && now >=time 
        && Datamanager.motorcycleShow.currentlatitude != null
        && Datamanager.motorcycleShow.currentlongitude != null){
          setState(() {
            DataFetch.fetchhavecar = 1;
            widget.status_car = "Available";
          });
        }else{
        DataFetch.fetchhavecar=1;
        Realtime.timecar = Timer.periodic(Duration(seconds: 5), (timer) async {
           now = DateTime.now().hour+(DateTime.now().minute/100);
          print(now);
          if(DateTime.now().day == Datamanager.booking.day 
          &&DateTime.now().month == Datamanager.booking.month 
          &&DateTime.now().year == Datamanager.booking.year 
          && now >=time
          && Datamanager.motorcycleShow.currentlatitude != null
          && Datamanager.motorcycleShow.currentlongitude != null){
      // print(DateTime.now().hour.toString() +" " + hour.toString()+" "+DateTime.now().minute.toString()+" "+minute.toString());
          setState(() {
            Realtime.timecar.cancel();
            DataFetch.fetchhavecar = 1;
            widget.status_car = "Available";
          });
          }
        });
      }
    }
}
@override
void dispose() {
  Realtime.timekey.cancel();
  Realtime.timecar.cancel();
  Realtime.timekey =null;
  Realtime.timecar =null;
  super.dispose();
}
  @override
  Widget build(BuildContext context) {
    // print(Datamanager.booking.boxslotrentdocid);
    var data = MediaQuery.of(context);
    if(DataFetch.waitlocation ==1){
      if(!Datamanager.boxslotrentshow.iskey){
        startTimer();
      }else{
        DataFetch.checkkey =1;
        widget.status_key = "Available";
      }
      fetchcaravai();
      if(widget.status_key == "Not Available"){
        Checkopenkey.checkkey = false;
        widget.showtextkey = UseString.notavailable;
        widget.colorkey = Colors.red[600];
      }else if(widget.status_key == "Available"){
        Checkopenkey.checkkey = true;
        widget.showtextkey = UseString.available;
        widget.colorkey = Colors.green;
      }
      if(Datamanager.booking.status == 'working'){
        widget.showtextkey = UseString.working;
        widget.colorkey = Colors.green;
      }
      if(widget.status_car == "Not Available"){
        widget.showtextcar = UseString.notavailable;
        widget.colorcar = Colors.red[600];
        Checkopenkey.checkcar = false;
      }else if(widget.status_car == "Available"){
        Checkopenkey.checkcar = true;
        widget.showtextcar = UseString.available;
        widget.colorcar = Colors.green;
      }
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          flexibleSpace: Image(
              image: AssetImage('assets/images/imagesprofile/appbar/background.png'),
              fit: BoxFit.cover,
            ),
          centerTitle: true,
          title: Center(
            child: Text(UseString.detail,
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*25,color: Colors.white), 
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.keyboard_arrow_left,
            color: Colors.white,
            ),
            onPressed: () {
              // Realtime.timekey.cancel();
              // Realtime.timecar.cancel();
              Navigator.pop(context);
            },
          ),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              width: data.size.width,
              height: data.size.height,
              color: Colors.grey[400],
            ),
            // Container(
            //   margin: EdgeInsets.only(top: data.size.height),
            //   width: data.size.width,
            //   height: 400,
            //   color: Colors.grey[400],
            // ),
            Container(
              width: data.size.width,
              height: SizeConfig.blockSizeVertical*63,
              color: Colors.white,
              child: Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical,left: SizeConfig.blockSizeHorizontal),
                        child: Text(Datamanager.motorcycleShow.brand +" "+ Datamanager.motorcycleShow.generation,
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*30,color: PickCarColor.colorFont1), 
                        ),
                      ),
                      Container(
                        // margin: EdgeInsets.only(top: 60),
                        width: SizeConfig.blockSizeHorizontal*90,
                        height: SizeConfig.blockSizeVertical*30,
                        // color: Colors.black,
                        child: Container(
                          child: Stack(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              carouselSlider = CarouselSlider(
                                height: SizeConfig.blockSizeVertical*25,
                                initialPage: 0,
                                enlargeCenterPage: true,
                                // autoPlay: true,
                                // reverse: false,
                                // enableInfiniteScroll: true,
                                // autoPlayInterval: Duration(seconds: 2),
                                // autoPlayAnimationDuration: Duration(milliseconds: 2000),
                                // pauseAutoPlayOnTouch: Duration(seconds: 10),
                                // scrollDirection: Axis.horizontal,
                                onPageChanged: (index) {
                                  setState(() {
                                    _current = index;
                                  });
                                },
                                items: imgList.map((imgUrl) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return Container(
                                        width: MediaQuery.of(context).size.width,
                                        margin: EdgeInsets.symmetric(horizontal: 10.0),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                        ),
                                        child: Image.network(
                                          imgUrl,
                                          fit: BoxFit.fill,
                                        ),
                                      );
                                    },
                                  );
                                }).toList(),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*25),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: map<Widget>(imgList, (index, url) {
                                    return Container(
                                      width: SizeConfig.blockSizeHorizontal*2.5,
                                      height: SizeConfig.blockSizeVertical*2.5,
                                      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: _current == index ? PickCarColor.colormain : Colors.grey,
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical,left:  SizeConfig.blockSizeHorizontal*3),
                        child: Text(UseString.date+" : "+ Datamanager.booking.day.toString()+" "+monthy(Datamanager.booking.month)+" "+Datamanager.booking.year.toString(),
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*22,color: PickCarColor.colorFont1), 
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical,left:  SizeConfig.blockSizeHorizontal*3),
                        child: Text(UseString.time+" : "+Datamanager.booking.time,
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*22,color: PickCarColor.colorFont1), 
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical,left:  SizeConfig.blockSizeHorizontal*3),
                        child: Text(UseString.locationplace+" : "+ Datamanager.placelocationshow.name + ' '+ UseString.inuniversity +' '+ Datamanager.booking.university,
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*22,color: PickCarColor.colorFont1), 
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical,left:  SizeConfig.blockSizeHorizontal*3),
                        child: Text(UseString.price+" : "+ Datamanager.booking.priceaddtax.toString(),
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*22,color: PickCarColor.colorFont1), 
                        ),
                      ),
                      
                    ],
                  ),
                ],
              ),
            ),
            key(context),
            location(context),
            
            GestureDetector(
              onTap: () async {
                var chatvalueowner;
                var chatvalue;
                var check = await Firestore.instance.collection('chat')
                          .document(Datamanager.user.documentid)
                          .collection('chatgroup')
                          .document(Datamanager.usershow.documentid).get();
                if(check.data == null){
                  var message = Firestore.instance.collection('message').document();
                  chatvalueowner = Chatprofile(
                    documentcontact: Datamanager.usershow.documentid,
                    name: Datamanager.usershow.name,
                    arrivaltime: DateTime.now(),
                    documentmessage: message.documentID,
                  );
                  chatvalue = Chatprofile(
                    documentcontact: Datamanager.user.documentid,
                    name: Datamanager.user.name,
                    arrivaltime: DateTime.now(),
                    documentmessage: message.documentID,
                  );
                  await Firestore.instance.collection('chat')
                          .document(Datamanager.user.documentid)
                          .collection('chatgroup')
                          .document(Datamanager.usershow.documentid)
                          .setData(chatvalueowner.toJson());
                  await Firestore.instance.collection('chat')
                            .document(Datamanager.usershow.documentid)
                            .collection('chatgroup')
                            .document(Datamanager.user.documentid)
                            .setData(chatvalue.toJson());
                }else{
                  chatvalueowner = Chatprofilehasmessage(
                    documentcontact: Datamanager.usershow.documentid,
                    name: Datamanager.usershow.name,
                    arrivaltime: DateTime.now(),
                  );
                  chatvalue = Chatprofilehasmessage(
                    documentcontact: Datamanager.user.documentid,
                    name: Datamanager.user.name,
                    arrivaltime: DateTime.now(),
                  );
                  await Firestore.instance.collection('chat')
                          .document(Datamanager.user.documentid)
                          .collection('chatgroup')
                          .document(Datamanager.usershow.documentid)
                          .updateData(chatvalueowner.toJson());
                  await Firestore.instance.collection('chat')
                            .document(Datamanager.usershow.documentid)
                            .collection('chatgroup')
                            .document(Datamanager.user.documentid)
                            .updateData(chatvalue.toJson());
                }
                Firestore.instance.collection('chat')
                          .document(Datamanager.user.documentid)
                          .collection('chatgroup')
                          .document(Datamanager.usershow.documentid).get().then((data){
                            var a = Chatprofileshow.fromSnapshot(data);
                            // print(a.documentmessage);
                            Datamanager.chatprofileshow = Chatprofileshow.fromSnapshot(data);
                            Navigator.of(context).pushNamed(Datamanager.messagepage);
                          });
              },
              child: Container(
                margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*85),
                width: double.infinity,
                height: SizeConfig.blockSizeVertical*5,
                color: Colors.white,
                child: Center(
                  child: Text(UseString.contactowner,
                    style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*22,color: PickCarColor.colorFont1), 
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }else{
      fetchboxandlocation();
      return Container(
        width: double.infinity,
        // height:data.size.height,
        color: PickCarColor.colormain,
        alignment: Alignment.bottomCenter,
        child: SpinKitCircle(
          color: Colors.white,
        ),
      );
    }
  }
}

