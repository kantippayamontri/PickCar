import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Datamanager {
  static final FirebaseAuth firebaseauth = FirebaseAuth.instance;

}

enum authProblems{
    UserNotFound, PasswordNotValid, NetworkError
}

class PickCarColor {
  static var colormain = Color.fromARGB(255, 60, 179, 113);
  static var colorcmu = Color.fromARGB(255, 66, 26, 94);
}
