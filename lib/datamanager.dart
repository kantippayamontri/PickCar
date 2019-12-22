import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Datamanager {
  static String signuppage = "signuppage";
  static final FirebaseAuth firebaseauth = FirebaseAuth.instance;
  static var univeresity = [
    {
      "Chaing Mai University": ["Engineering" , "Science" , "Humantility"]
    }
  ];
  static var year = [1, 2, 3, 4, 5, 6];
}

class UseString {
  static String name = "Name";
  static String nameemptyval = "Please Enter Name.";
  static String signup = "Sign Up";
}

enum authProblems { UserNotFound, PasswordNotValid, NetworkError }

class PickCarColor {
  static var colormain = Color.fromARGB(255, 60, 179, 113);
  static var colorcmu = Color.fromARGB(255, 66, 26, 94);
}
