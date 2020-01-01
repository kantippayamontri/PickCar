import 'package:flutter/material.dart';
import 'package:pickcar/datamanager.dart';
import 'package:pickcar/page/loginpage.dart';
import 'package:pickcar/page/register/carregisterpage.dart';
import 'package:pickcar/page/register/motorregisterpage.dart';
import 'package:pickcar/page/register/registerpage.dart';
import 'package:pickcar/page/rental/rentalpage.dart';
import 'package:pickcar/page/signuppage.dart';
import 'package:pickcar/page/tabscreen.dart';

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
        Datamanager.signuppage : (ctx) => SignUpPage(),
        Datamanager.tabpage : (ctx) => TabScreenPage(),
        Datamanager.registerpage : (ctx) => RegisterPage(),
        Datamanager.motorregisterpage : (ctx) => MotorRegisterPage(),
        Datamanager.carregisterpage : (ctx) => CarRegisterPage(),
        Datamanager.rentalpage : (ctx) => RentalPage(),
        //'loginpickcarpage': (ctx) => LoginPickCarPage()
      },
      onGenerateRoute: (setting) {},
      onUnknownRoute: (setting) {},
    );
  }
}
