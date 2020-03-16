import 'package:flutter/material.dart';
import 'package:pickcar/datamanager.dart';

class ChooseAdminServer extends StatefulWidget {
  @override
  _ChooseAdminServerState createState() => _ChooseAdminServerState();
}

class _ChooseAdminServerState extends State<ChooseAdminServer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            child: Text("admin page"),
            onPressed: () {
              print("go to admin page");
            },
          ),
          RaisedButton(
            child: Text("Server page"),
            onPressed: () {
              print("go to server page");
              Navigator.of(context).pushNamed(Datamanager.serverpage);
            },
          )
        ],
      )),
    );
  }
}
