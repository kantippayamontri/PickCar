import 'package:flutter/material.dart';
import 'package:pickcar/datamanager.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Text("ChatPage"),
            RaisedButton(
              onPressed: (){
                Navigator.of(context).pushNamed(Datamanager.listcar);
              },
              child: Text("search"),
            ),
          ],
        ),
      ),
    );
  }
}