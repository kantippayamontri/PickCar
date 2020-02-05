import 'package:flutter/material.dart';

import '../datamanager.dart';

class Mainloginpage extends StatefulWidget {
  @override
  _MainloginpageState createState() => _MainloginpageState();
}

class _MainloginpageState extends State<Mainloginpage> {
  @override
  Widget build(BuildContext context) {
    var data = MediaQuery.of(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/imagelogin/main.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            margin: EdgeInsets.only(top:data.size.height/1.5),
            child: GestureDetector(
              child: Stack(
                children: <Widget>[
                  Container(
                    // color: Colors.blue,
                    child: Stack(
                      children: <Widget>[
                        Center(
                          child: Image.asset("assets/images/imagelogin/bg.png")
                        ),
                        Center(
                          child: Text(UseString.pickcar,
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*30,color: Colors.white), 
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              onTap: (){
                Navigator.of(context).pushNamed(Datamanager.loginpage);
              },
            ),
          ),
        ],
      )
    );
  }
}