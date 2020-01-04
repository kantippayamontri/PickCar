import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:pickcar/page/chatpage.dart';
import 'package:pickcar/page/homepage.dart';
import 'package:pickcar/page/listcarpage.dart';
import 'package:pickcar/page/profilepage.dart';
import 'package:pickcar/page/settingpage.dart';

import 'models/user.dart';

class Datamanager {
  static String signuppage = "/signuppage";
  static String tabpage = "/tabpage";
  static String registerpage = "/registerpage";
  static String motorregisterpage = "/motorregisterpage";
  static String carregisterpage = "/carregisterpage";
  static String rentalpage = "/rentalpage";
  static String listcarpage = "/listcarpage";

  static final FirebaseAuth firebaseauth = FirebaseAuth.instance;
  static FirebaseUser firebaseuser = null;
  static Firestore firestore = Firestore.instance;
  static User user = null;
  static FirebaseStorage firebasestorage = FirebaseStorage.instance;

  static List<Map<String, Object>> pages  = [
      {'page': HomePage(), 'title': 'Home'},
      {'page': ChatPage(), 'title': 'Chat'},
      {'page': ListCarPage(), 'title': 'ListCar'},
      {'page': ProfilePage(), 'title': 'Profile'},
      {'page': SettingPage(), 'title': 'setting'},
    ];

  static var univeresity = [
    {
      "university": "Chaing Mai University",
      "faculty": ["Engineering", "Science", "Humantility"]
    },
    {
      "university": "sdfasdfasd",
      "faculty": ["sdfasdfas", "sdfasdfs", "sdfasdfasd"]
    },
    {
      "university": "dfasdfsdfasdf",
      "faculty": ["sdfasdfsd", "sdfasd", "sdfasdfsdfas"]
    }
  ];

  static var faculty = [
    {"faculty": "Engineering"},
    {"faculty": "Science"},
    {"faculty": "Humantility"}
  ];

  static var year = [
    {"year": "1"},
    {"year": "2"},
    {"year": "3"},
    {"year": "4"},
    {"year": "5"},
    {"year": "6"},
  ];
}

class UseString {
  static String name = "Name";
  static String nameemptyval = "Please Enter Name.";
  static String signup = "Sign Up";
  static String university = "University";
  static String chooseuniversity = "Please choose your University";
  static String faculty = "Faculty";
  static String choosefaculty = "Please choose your Faculty";
  static String profile = "Profile";
  static String email = "Email";
  static String emailtypeval = "Please Enter Email";
  static String password = "Password";
  static String passwordtypeval = "Please Enter Password";
  static String passworddontsame = "Your password doesn\'t match";
  static String confirmpassword = "Confirm Password";
  static String passwordlenght = "your password must be at least 6 characters";
  static String telnumber = "Telephone Number";
  static String telnumberval = "Please Enter Telephone Number";
  static String address = "Address";
  static String addressval = "Please Enter Address";
  static String idcard = "ID Card";
  static String universitycard = "University Card";
  static String driverliscensemotorcycle =
      "Driver Liscense Card(for motorcycle)";
  static String driverliscensecarcycle = "Driver Liscense Card(for car)";
  static String rentaltitle =
      "Pickcar has created for make the great experience when you rental car from another one and make your life is excited.";
  static String rentalbutton = "Rental Car";
  static String registertitle =
      "The best way to make money from your car via Pickcar. We will give your new experience to earn more income. Let you make money with your car.";
  static String registerbutton = "Register Car";
  static String motorcycle = "Motorcycle";
  static String car = "Car";
  static String brand = "Brand";
  static String brandval = "Please Enter Brand";
  static String generation = "Generation";
  static String generationval = "Please Enter Generation";
  static String cc = "CC";
  static String ccval = "Please Enter CC";
  static String gear = "Gear";
  static String gearval = "Please Enter Gear";
  static String color = "Color";
  static String colorval = "Please Enter Color";
  static String motorprofile = "Motorcycle Profile";
  static String motorprofileval = "Please choose Motorcycle Profile";
  static String ownerliscense = "Owner liscense (If you not an owner)";
  static String motorfront = "Motorcycle front picture";
  static String motorleft = "Motorcycle left picture";
  static String motorright = "Motorcycle right picture";
  static String motorback = "Motorcycle back picture";
  static String waiting = "Wait a few seconds";
  static String picuploadval = "Please select all images.";
  static String close = "Close";
  static String registermotorfail = "Fail to register motorcycle.";

}

enum authProblems { UserNotFound, PasswordNotValid, NetworkError }
enum chooseimgenum { CAMERA, GALLERY }

class PickCarColor {
  static var colormain = Color.fromARGB(255, 60, 179, 113);
  static var colorcmu = Color.fromARGB(255, 66, 26, 94);
}

class GearMotor {
  static String auto = "AUTO";
  static String manual = "MANUAL";

  static var gearmotormap = [
    {'gear': GearMotor.auto},
    {'gear': GearMotor.manual}
  ];
}
