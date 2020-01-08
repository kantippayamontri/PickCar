import 'package:flutter/material.dart';
import 'package:pickcar/bloc/motorrentaldefind/motorrentaldefindbloc.dart';
import 'package:pickcar/models/motorcycle.dart';

class MotorRentalDefindPage extends StatefulWidget {
  Motorcycle motorcycle;
  MotorRentalDefindPage({@required this.motorcycle});

  @override
  _MotorRentalDefindPageState createState() => _MotorRentalDefindPageState();
}

class _MotorRentalDefindPageState extends State<MotorRentalDefindPage> {
  MotorRentalDefindBloc _motorRentalDefindBloc;
  @override
  void initState() {
    // TODO: implement initState
    _motorRentalDefindBloc = MotorRentalDefindBloc(context: this.context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("MotorRentalDefindPage"),
      ),
    );
  }
}
