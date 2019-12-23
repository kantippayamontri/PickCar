import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Datamanager {
  static String signuppage = "signuppage";
  static final FirebaseAuth firebaseauth = FirebaseAuth.instance;

  static var univeresity = [
    {
       "university" : "Chaing Mai University",
       "faculty" : ["Engineering" , "Science" , "Humantility"]
    },{
       "university" : "sdfasdfasd",
       "faculty" : ["sdfasdfas" , "sdfasdfs" , "sdfasdfasd"]
    },{
       "university" : "dfasdfsdfasdf",
       "faculty" : ["sdfasdfsd" , "sdfasd" , "sdfasdfsdfas"]
    }
  ];
  static var year = [1, 2, 3, 4, 5, 6];
}

class UseString {
  static String name = "Name";
  static String nameemptyval = "Please Enter Name.";
  static String signup = "Sign Up";
  static String university = "University";
  static String chooseuniversity = "Please choose your University";
  static String faculty = "Faculty";
  static String choosefaculty = "Please choose your Faculty";
}

enum authProblems { UserNotFound, PasswordNotValid, NetworkError }

class PickCarColor {
  static var colormain = Color.fromARGB(255, 60, 179, 113);
  static var colorcmu = Color.fromARGB(255, 66, 26, 94);
}
