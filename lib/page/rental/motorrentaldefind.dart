import 'package:flutter/material.dart';
import 'package:pickcar/models/motorcycle.dart';

class MotorRentalDefind extends StatefulWidget {

 Motorcycle motorcycle;
 MotorRentalDefind({@required this.motorcycle});

  @override
  _MotorRentalDefindState createState() => _MotorRentalDefindState();
}

class _MotorRentalDefindState extends State<MotorRentalDefind> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("${widget.motorcycle.firestoredocid}"),
      ),
    );
  }
}
