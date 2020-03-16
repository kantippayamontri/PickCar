import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:pickcar/datamanager.dart';
import 'package:pickcar/page/tabscreen.dart';
import 'package:pickcar/ui/uisize.dart';
import 'package:pickcar/widget/home/cardrental.dart';
int i=0;
class Fullimage extends StatefulWidget {

  Function gotosearchinHome;

  @override
  _FullimageState createState() => _FullimageState();
}

class _FullimageState extends State<Fullimage> {
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
        body: Container(
          color: Colors.black,
        ));
  }
}
