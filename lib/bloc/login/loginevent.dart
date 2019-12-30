import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

abstract class LoginEvent  {
  
}

class SignInwithEmailEvent extends LoginEvent {
  final String email;
  final String password;
  final Function checkerrorsignin;
  SignInwithEmailEvent(this.email, this.password , this.checkerrorsignin);
  
}


