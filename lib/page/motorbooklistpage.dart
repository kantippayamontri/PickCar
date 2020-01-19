import 'package:flutter/material.dart';
import 'package:pickcar/arguments.dart';
import 'package:pickcar/bloc/motorbooklist/motorbooklistbloc.dart';
import 'package:pickcar/models/motorcycle.dart';

class MotorBookListPage extends StatefulWidget {
  @override
  _MotorBookListPageState createState() => _MotorBookListPageState();
}

class _MotorBookListPageState extends State<MotorBookListPage> {
  @override
  void initState() {
    // TODO: implement initState
    print("initstate");
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {

    print("in build");

    final MotorBookListArguments argument = ModalRoute.of(context).settings.arguments;
    MotorBookListBloc motorBookListBloc = MotorBookListBloc(motorcycle: argument.motorcycle);

    return Scaffold(
      body: Center(
        child: Text("MotorBookListPage eiei"),
      ),
    );
  }
}
