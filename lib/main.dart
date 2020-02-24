import 'package:flutter/material.dart';
import 'package:pickcar/datamanager.dart';
import 'package:pickcar/page/admin/adminlicense.dart';
import 'package:pickcar/page/admin/adminmenu.dart';
import 'package:pickcar/page/chatpage.dart';
import 'package:pickcar/page/example.dart';
import 'package:pickcar/page/fullimage.dart';
import 'package:pickcar/page/history.dart';
import 'package:pickcar/page/listcarpage.dart';
import 'package:pickcar/page/loginpage.dart';
import 'package:pickcar/page/mainloginpage.dart';
import 'package:pickcar/page/map/addlocation.dart';
import 'package:pickcar/page/map/bookedmap.dart';
import 'package:pickcar/page/map/boxselectadmin.dart';
import 'package:pickcar/page/map/mapboxselect.dart';
import 'package:pickcar/page/map/mapaddmark.dart';
import 'package:pickcar/page/map/mapplaceselect.dart';
import 'package:pickcar/page/map/placeselectadmin.dart';
import 'package:pickcar/page/map/receivekeymap.dart';
import 'package:pickcar/page/map/registermap.dart';
import 'package:pickcar/page/map/selectUniversity.dart';
import 'package:pickcar/page/massagepage.dart';
import 'package:pickcar/page/motorbooklistpage.dart';
import 'package:pickcar/page/openkey.dart';
import 'package:pickcar/page/profile/editprofile/NewPassword.dart';
import 'package:pickcar/page/profile/editprofile/changepassword.dart';
import 'package:pickcar/page/profile/editprofile/editdetail.dart';
import 'package:pickcar/page/profile/editprofile/editprofile.dart';
import 'package:pickcar/page/profile/editprofile/emailsend.dart';
import 'package:pickcar/page/receivecar.dart';
import 'package:pickcar/page/register/carregisterpage.dart';
import 'package:pickcar/page/register/motorregisterpage.dart';
import 'package:pickcar/page/register/registerpage.dart';
import 'package:pickcar/page/rental/rentalpage.dart';
import 'package:pickcar/page/searchpage/confirmpage.dart';
import 'package:pickcar/page/searchpage/detailsearch.dart';
import 'package:pickcar/page/searchpage/listcar.dart';
import 'package:pickcar/page/searchpage/search.dart';
import 'package:pickcar/page/searchpage/slottimeselect.dart';
import 'package:pickcar/page/sendlicensepage.dart';
import 'package:pickcar/page/signuppage.dart';
import 'package:pickcar/page/tabscreen.dart';
import 'package:pickcar/page/map/maplocation.dart';

import 'datamanager.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
        Datamanager.mainloginpage: (ctx) => Mainloginpage(),
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
        Datamanager.boxselectadmin : (ctx) => Boxselectadmin(),
        Datamanager.mapaddmark : (ctx) => Mapaddmark(),
        Datamanager.motorbooklistpage : (ctx) => MotorBookListPage(),
        Datamanager.registerMap : (ctx) => RegisterMap(),
        Datamanager.mapboxselect : (ctx) => Mapboxselect(),
        Datamanager.placeselectadmin : (ctx) => Placeselectadmin(),
        Datamanager.mapplaceselect : (ctx) => Mapplaceselect(),
        Datamanager.selectUniversity : (ctx) => SelectUniversity(),
        Datamanager.receivecar : (ctx) => Receivecar(),
        Datamanager.bookedmap : (ctx) => Bookedmap(),
        Datamanager.openkey : (ctx) => Openkey(),
        Datamanager.animatedContainerApp : (ctx) => AnimatedContainerApp(),
        Datamanager.search : (ctx) => SearchPage(),
        Datamanager.maplocation : (ctx) => Maplocation(),
        Datamanager.receivekeymap : (ctx) => Receivekeymap(),
        Datamanager.addlocation : (ctx) => Addlocation(),
        Datamanager.historypage : (ctx) => HistoryPage(),
        Datamanager.chatpage : (ctx) => Chatpage(),
        Datamanager.messagepage : (ctx) => Messagepage(),
        Datamanager.fullimage : (ctx) => Fullimage(),
        Datamanager.adminmenu : (ctx) => Adminmenu(),
        Datamanager.adminlicense : (ctx) => Adminlicense(),
        Datamanager.sendlicensepage : (ctx) => Sendlicensepage(),
        //'loginpickcarpage': (ctx) => LoginPickCarPage()
      },
      onGenerateRoute: (setting) {},
      onUnknownRoute: (setting) {},
    );
  }
}
