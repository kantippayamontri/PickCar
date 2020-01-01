import 'package:flutter/material.dart';

class RentalPage extends StatefulWidget {
  @override
  _RentalPageState createState() => _RentalPageState();
}

class _RentalPageState extends State<RentalPage> {

  AppBar appbar;
  @override
  void initState() {
  // TODO: implement initState
  this.appbar = AppBar();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Rental Page"),
      ),
    );
  }
}
