import 'package:flutter/material.dart';
import 'package:pickcar/main.dart';

class MotorDetailPage extends StatefulWidget {
  String motordocid;
  MotorDetailPage({@required this.motordocid}){
    print("MotorDetailPage motordocid : ${motordocid}");
  }
  @override
  _MotorDetailPageState createState() => _MotorDetailPageState();
}

class _MotorDetailPageState extends State<MotorDetailPage> {
  @override
  void initState() {
    // TODO: implement initState
    print("motor firestore docid ; ${widget.motordocid}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Center(
      child: Text(
        widget.motordocid
      ),
    ));
  }
}
