import 'package:flutter/material.dart';
import 'package:pickcar/datamanager.dart';
import 'package:pickcar/page/loginpage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PickCar',
      theme: ThemeData(
          primaryColor: PickCarColor.colormain,
          canvasColor: Color.fromRGBO(255, 255, 255, 1),
          textTheme: ThemeData.light().textTheme.copyWith(
              body1: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: PickCarColor.colormain))),
      routes: {
        '/': (ctx) => LoginPage(),
        //'loginpickcarpage': (ctx) => LoginPickCarPage()
      },
      onGenerateRoute: (setting) {},
      onUnknownRoute: (setting) {},
    );
  }
}
