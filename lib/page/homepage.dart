import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:pickcar/datamanager.dart';
import 'package:pickcar/page/tabscreen.dart';
import 'package:pickcar/ui/uisize.dart';
import 'package:pickcar/widget/home/cardrental.dart';
int i=0;
class HomePage extends StatefulWidget {

  Function gotosearchinHome;

  HomePage({@required this.gotosearchinHome});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AppBar appbar;
  

  @override
  void initState() {
    // TODO: implement initState
    appbar = AppBar();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    void _gotorental() {
      Navigator.of(context).pushNamed(Datamanager.search);
      // TabScreenPage(index: 1);
    }

    void _gotoregister(){
      Navigator.of(context).pushNamed(Datamanager.registerpage);
    }
    var data = MediaQuery.of(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          flexibleSpace: Image(
            image:
                AssetImage('assets/images/imagesprofile/appbar/background.png'),
            fit: BoxFit.cover,
          ),
          centerTitle: true,
          title: Container(
            width: SizeConfig.blockSizeHorizontal*20,
            child: Image.asset('assets/images/imagelogin/logo.png',fit: BoxFit.fill,)
          ),
          leading: IconButton(
            icon: Icon(
              Icons.keyboard_arrow_left,
              color: Colors.transparent,
            ),
            onPressed: () {
              // Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          // margin: EdgeInsets.fromLTRB(0, appbar.preferredSize.height + MediaQuery.of(context).padding.top, 0, 0),
          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CardRental(
                      height: constraints.maxHeight,
                      width: constraints.maxWidth,
                      title: UseString.rentaltitle,
                      buttontext: UseString.rentalbutton,
                      tap: widget.gotosearchinHome,//_gotorental,
                      imageurl: 'assets/images/imagemain/forrent.png',
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.1,
                    ),
                    CardRental(
                      height: constraints.maxHeight,
                      width: constraints.maxWidth,
                      title: UseString.registertitle,
                      buttontext: UseString.registerbutton,
                      tap: _gotoregister,
                      imageurl: 'assets/images/imagemain/forregister.png',
                    ),
                    // Container(
                    //     alignment: Alignment.centerLeft,
                    //     margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical,left:  SizeConfig.blockSizeHorizontal*3),
                    //     child: RaisedButton(
                    //       onPressed: (){
                    //         Navigator.of(context).pushNamed(Datamanager.selectUniversity);
                    //       },
                    //     ),
                    //   ),
                  ],
                ),
              );
            },
          ),
        ));
  }
}
