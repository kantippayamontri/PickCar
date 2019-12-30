import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'models/user.dart';

class Datamanager {
  static String signuppage = "signuppage";
  static final FirebaseAuth firebaseauth = FirebaseAuth.instance;
  static  FirebaseUser firebaseuser = null;
  static Firestore firestore = Firestore.instance;
  static User user = null;
  static final firebasestorage = FirebaseStorage.instance;

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
  static String driverliscensemotorcycle = "Driver Liscense Card(for motorcycle)";
  static String driverliscensecarcycle = "Driver Liscense Card(for car)";

}

enum authProblems { UserNotFound, PasswordNotValid, NetworkError }
enum chooseimgenum {CAMERA , GALLERY}

class PickCarColor {
  static var colormain = Color.fromARGB(255, 60, 179, 113);
  static var colorcmu = Color.fromARGB(255, 66, 26, 94);
}
