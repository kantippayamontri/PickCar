import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pickcar/bloc/login/loginevent.dart';
import 'package:pickcar/bloc/login/loginstate.dart';
import 'package:pickcar/datamanager.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  var emailcontroller = TextEditingController();
  var passcontroller = TextEditingController();
  var formkey = GlobalKey<FormState>();
  var signinsuccess = false;
  var start = false;
  var signinerrorm = "";
  @override
  LoginState get initialState => StartState();

  bool showloginstatus() => start;

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    

    if (event is SignInwithEmailEvent) {
      yield LoadingSnackBarState();
      print('pass maptoevent LoadingSnackBarState');
      try {
        await Datamanager.firebaseauth.signInWithEmailAndPassword(
            email: event.email, password: event.password);/*.then((user){
              print('login success : ${user.user.email}');
              signinsuccess = true;
            });*/
            signinsuccess = true;
            start = true;
      } on PlatformException catch (e) {
        start = true;
        signinsuccess = false;
        signinerrorm = "Fail to Login";
        print(e.message);
      }
      event.checkerrorsignin();
    }
  }
}

var loginbloc = LoginBloc();
