import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pickcar/datamanager.dart';
import 'package:pickcar/models/boxlocation.dart';
import 'package:pickcar/models/placelocation.dart';

class Receivecar extends StatefulWidget {
  String showtext = UseString.notavailable;
  String status = "Not Available";
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
  var color = Colors.red[600];
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
    widget.showtext = UseString.notavailable;
    widget.statebutton = false;
    widget.statebutton2 = false;
    widget._visible1 = true;
    widget._visible2 = true;
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
  fetchboxandlocation(){
    if(DataFetch.waitlocation ==0){
      Firestore.instance.collection('boxlocation').document(Datamanager.booking.boxplacedocid).get().then((data){
        Datamanager.boxlocationshow = BoxlocationShow.fromSnapshot(data);
      });
      Firestore.instance.collection('placelocation').document(Datamanager.booking.motorplacelocdocid).get().then((data){
        Datamanager.placelocationshow = PlacelocationShow.fromSnapshot(data);
      });
      Future.delayed(const Duration(milliseconds: 1000), () {
        print('wait');
        print(Datamanager.placelocationshow.name);
        DataFetch.waitlocation = 1;
        setState(() {
        });
    });
    }
  }
  Widget key(BuildContext context){
    var data = MediaQuery.of(context);
    return GestureDetector(
      onTap: (){
        // Navigator.of(context).pushNamed(Datamanager.openkey);
        setState(() {
          if(widget.statebutton){
            widget.colorchange = Colors.white;
            widget.statebutton = false;
            Navigator.of(context).pushNamed(Datamanager.openkey);
            widget._visible1 = !widget._visible1;
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
        margin: EdgeInsets.only(top: 404),
        width: (data.size.width/2) -2,
        height: 156,
        color: widget.colorchange,
        child: Stack(
          children: <Widget>[
            AnimatedOpacity(
              opacity: widget._visible1 ? 1.0 : 0.0,
              duration: Duration(milliseconds: 500),
              child: Center(
                child: Container(
                  margin: EdgeInsets.only(bottom: 60),
                  width: 80,
                  height: 80,
                  child: Image.asset('assets/images/imagereceivecar/keyicon.png',fit: BoxFit.fill),
                ),
              ),
            ),
            AnimatedOpacity(
              opacity: widget._visible1 ? 1.0 : 0.0,
              duration: Duration(milliseconds: 500),
              child: Container(
                // alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 100,left: 20),
                width: double.infinity,
                height: 80,
                child: Column(
                  children: <Widget>[
                    Text(UseString.key,
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*20,color: PickCarColor.colorFont1), 
                    ),
                    Text(widget.showtext,
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*20,color: widget.color), 
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
                  margin: EdgeInsets.only(bottom: 60),
                  width: 80,
                  height: 80,
                  child: Image.asset('assets/images/imagereceivecar/lockicon.png',fit: BoxFit.fill),
                ),
              ),
            ),
            AnimatedOpacity(
              opacity: widget._visible1 ? 0.0 : 1.0,
              duration: Duration(milliseconds: 500),
              child: Container(
                // alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 100,left: 10),
                width: double.infinity,
                height: 80,
                child: Column(
                  children: <Widget>[
                    Text(UseString.openlocker,
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*20,color: Colors.white), 
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
        // Navigator.of(context).pushNamed(Datamanager.openkey);
        setState(() {
          if(widget.statebutton2){
            widget.colorchange2 = Colors.white;
            widget.statebutton2 = false;
            widget._visible2 = !widget._visible2;
            Navigator.of(context).pushNamed(Datamanager.bookedmap);
          }else{
            widget.colorchange2 = PickCarColor.colormain;
            widget.statebutton2 = true;
            widget._visible2 = !widget._visible2;
          }
        });
      },
      child: AnimatedContainer(
        duration: Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
        margin: EdgeInsets.only(top: 404,left: (data.size.width/2) +2),
        width: (data.size.width/2) -2,
        height: 156,
        color: widget.colorchange2,
        child: Stack(
          children: <Widget>[
            AnimatedOpacity(
              opacity: widget._visible2 ? 1.0 : 0.0,
              duration: Duration(milliseconds: 500),
              child: Center(
                child: Container(
                  margin: EdgeInsets.only(bottom: 60),
                  width: 80,
                  height: 80,
                  child: Image.asset('assets/images/imagereceivecar/motorcycleicon.png',fit: BoxFit.fill),
                ),
              ),
            ),
            AnimatedOpacity(
              opacity: widget._visible2 ? 1.0 : 0.0,
              duration: Duration(milliseconds: 500),
              child: Container(
                // alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 100,left: 20),
                width: double.infinity,
                height: 80,
                child: Column(
                  children: <Widget>[
                    Text(UseString.motor,
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*20,color: PickCarColor.colorFont1), 
                    ),
                    Text(widget.showtext,
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*20,color: widget.color), 
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
                  margin: EdgeInsets.only(bottom: 60),
                  width: 80,
                  height: 80,
                  child: Image.asset('assets/images/imagereceivecar/mapicon.png',fit: BoxFit.fill),
                ),
              ),
            ),
            AnimatedOpacity(
              opacity: widget._visible2 ? 0.0 : 1.0,
              duration: Duration(milliseconds: 500),
              child: Container(
                // alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 100,left: 10),
                width: double.infinity,
                height: 80,
                child: Column(
                  children: <Widget>[
                    Text(UseString.maploacation,
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*20,color: Colors.white), 
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

  @override
  Widget build(BuildContext context) {
    if(widget.status == "Not Available"){
      widget.showtext = UseString.notavailable;
      widget.color = Colors.red[600];
    }else if(widget.status == "Available"){
      widget.showtext = UseString.available;
      widget.color = Colors.green;
    }else{
      widget.showtext = UseString.wait;
      widget.color = Colors.blueAccent;
    }
    var data = MediaQuery.of(context);

    fetchboxandlocation();
    if(DataFetch.waitlocation ==1){
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          flexibleSpace: Image(
              image: AssetImage('assets/images/imagesprofile/appbar/background.png'),
              fit: BoxFit.cover,
            ),
          centerTitle: true,
          title: Text(UseString.detail,
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
              height: 400,
              color: Colors.white,
              child: Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 10,left: 10),
                        child: Text(Datamanager.motorcycleShow.brand +" "+ Datamanager.motorcycleShow.generation,
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*30,color: PickCarColor.colorFont1), 
                        ),
                      ),
                      Container(
                        // margin: EdgeInsets.only(top: 60),
                        width: 370,
                        height: 240,
                        // color: Colors.black,
                        child: Container(
                          child: Stack(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              carouselSlider = CarouselSlider(
                                height: 200.0,
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
                                margin: EdgeInsets.only(top: 200),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: map<Widget>(imgList, (index, url) {
                                    return Container(
                                      width: 10.0,
                                      height: 10.0,
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
                        margin: EdgeInsets.only(top: 10,left: 10),
                        child: Text(UseString.date+" : "+ Datamanager.booking.day.toString()+" "+monthy(Datamanager.booking.month)+" "+Datamanager.booking.year.toString(),
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*20,color: PickCarColor.colorFont1), 
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(top: 10,left: 10),
                        child: Text(UseString.time+" : "+Datamanager.booking.time,
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*20,color: PickCarColor.colorFont1), 
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(top: 10,left: 10),
                        child: Text(UseString.locationplace+" : "+ Datamanager.placelocationshow.name + ' '+ UseString.inuniversity +' '+ Datamanager.booking.university,
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*20,color: PickCarColor.colorFont1), 
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            key(context),
            location(context),
            // animationbuttom(context),
            // GestureDetector(
            //   onTap: (){
            //     setState(() {
            //       // widget.width = data.size.width;
            //       if(widget.statebutton){
            //         widget.height = 0;
            //         widget.top = 560;
            //         widget.statebutton = false;
            //       }else{
            //         widget.height = 156;
            //         widget.top = 404;
            //         widget.statebutton = true;
            //       }
            //     });
            //   },
            //   child: Container(
            //     width: 100,
            //     height: 50,
            //     margin: EdgeInsets.only(top: 404,left: 155),
            //     // color: Colors.black,
            //     child: Image.asset('assets/images/imagereceivecar/buttommap2.png',fit: BoxFit.fill),
            //   ),
            // ),
            
            GestureDetector(
              onTap: (){
                // Navigator.of(context).pushNamed(Datamanager.bookedmap);
                // Navigator.of(context).pushNamed(Datamanager.animatedContainerApp);
              },
              child: Container(
                margin: EdgeInsets.only(top: 564),
                width: double.infinity,
                height: 40,
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
