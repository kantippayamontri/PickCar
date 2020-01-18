import 'package:flutter/material.dart';
import 'package:pickcar/arguments.dart';

class MotorBookListPage extends StatefulWidget {
  @override
  _MotorBookListPageState createState() => _MotorBookListPageState();
}

class _MotorBookListPageState extends State<MotorBookListPage> {

  

  @override
  Widget build(BuildContext context) {

    final MotorBookListArguments argument = ModalRoute.of(context).settings.arguments;


    return Scaffold(
      body: Center(
        child: Text("MotorBookListPage"),
      ),
    );
  }
}
