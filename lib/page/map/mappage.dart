import 'package:flutter/material.dart';
import 'package:pickcar/datamanager.dart';

class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Text("mappage"),
            RaisedButton(
              onPressed: (){
                Navigator.of(context).pushNamed(Datamanager.listcar);
                // Navigator.of(context).pushNamed(Datamanager.detailsearch);
              },
              child: Text("search"),
            ),
          ],
        ),
      ),
    );
  }
}