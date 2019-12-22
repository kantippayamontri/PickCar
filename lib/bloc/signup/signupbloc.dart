import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:pickcar/bloc/signup/signupevent.dart';
import 'package:pickcar/bloc/signup/signupstate.dart';

class SignUpBloc extends Bloc<SignUpEvent , SignUpState>{

  var formkey = GlobalKey<FormState>();
  var namecontroller = TextEditingController();

  @override
  SignUpState get initialState => StartState();

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) {

    return null;
  }

  void signupform(){
    final form = formkey.currentState;
    if(form.validate()){
      form.save();
    }
    print("int fun signup form naja");
  }
  
}