import 'package:flutter/material.dart';
import 'package:pickcar/datamanager.dart';
import 'package:pickcar/page/listcarpage.dart';
import 'package:pickcar/page/loginpage.dart';
import 'package:pickcar/page/map/mappage.dart';
import 'package:pickcar/page/map/mapaddmark.dart';
import 'package:pickcar/page/map/registermap.dart';
import 'package:pickcar/page/motorbooklistpage.dart';
import 'package:pickcar/page/profile/editprofile/NewPassword.dart';
import 'package:pickcar/page/profile/editprofile/changepassword.dart';
import 'package:pickcar/page/profile/editprofile/editdetail.dart';
import 'package:pickcar/page/profile/editprofile/editprofile.dart';
import 'package:pickcar/page/profile/editprofile/emailsend.dart';
import 'package:pickcar/page/register/carregisterpage.dart';
import 'package:pickcar/page/register/motorregisterpage.dart';
import 'package:pickcar/page/register/registerpage.dart';
import 'package:pickcar/page/rental/rentalpage.dart';
import 'package:pickcar/page/searchpage/confirmpage.dart';
import 'package:pickcar/page/searchpage/detailsearch.dart';
import 'package:pickcar/page/searchpage/listcar.dart';
import 'package:pickcar/page/searchpage/slottimeselect.dart';
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
        Datamanager.loginpage: (ctx) => LoginPage(),
        Datamanager.signuppage : (ctx) => SignUpPage(),
        Datamanager.tabpage : (ctx) => TabScreenPage(),
        Datamanager.registerpage : (ctx) => RegisterPage(),
        Datamanager.motorregisterpage : (ctx) => MotorRegisterPage(),
        Datamanager.carregisterpage : (ctx) => CarRegisterPage(),
        Datamanager.rentalpage : (ctx) => RentalPage(),
        Datamanager.editprofile : (ctx) => EditProfile(),
        Datamanager.editdetail : (ctx) => EditDetail(),
        Datamanager.changepassword : (ctx) => ChangePassword(),
        Datamanager.newpassword : (ctx) => NewPassword(),
        Datamanager.emailsend : (ctx) => EmailSend(),
        Datamanager.listcarpage : (ctx) => ListCarPage(),
        Datamanager.listcar : (ctx) => Listcar(),
        Datamanager.detailsearch : (ctx) => Detailsearch(),
        Datamanager.slottiempage : (ctx) => SlotTimePage(),
        Datamanager.confirmpage : (ctx) => ConfirmPage(),
        Datamanager.mappage : (ctx) => MapPage(),
        Datamanager.mapaddmark : (ctx) => Mapaddmark(),
        Datamanager.motorbooklistpage : (ctx) => MotorBookListPage(),
        Datamanager.registerMap : (ctx) => RegisterMap(),
        //'loginpickcarpage': (ctx) => LoginPickCarPage()
      },
      onGenerateRoute: (setting) {},
      onUnknownRoute: (setting) {},
    );
  }
}
