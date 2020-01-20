import 'package:flutter/material.dart';
import 'package:pickcar/datamanager.dart';

class SearchPage extends StatelessWidget {
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
                // Navigator.of(context).pushNamed(Datamanager.detailsearch);
              },
              child: Text("search"),
            ),
            SizedBox(height: 20,),
            RaisedButton(
              onPressed: (){
                Navigator.of(context).pushNamed(Datamanager.mappage);
                // Navigator.of(context).pushNamed(Datamanager.detailsearch);
              },
              child: Text("goto map"),
            ),
            SizedBox(height: 20,),
            RaisedButton(
              onPressed: (){
                Navigator.of(context).pushNamed(Datamanager.mapaddmark);
                // Navigator.of(context).pushNamed(Datamanager.detailsearch);
              },
              child: Text("goto add mark"),
            ),
          ],
        ),
      ),
    );
  }
}