import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:pickcar/bloc/signup/signupevent.dart';
import 'package:pickcar/bloc/signup/signupstate.dart';

import '../../datamanager.dart';

class SignUpBloc extends Bloc<SignUpEvent , SignUpState>{

  var formkey = GlobalKey<FormState>();
  var namecontroller = TextEditingController();
  String university;
  String faculty;
  List<String> facultylist;

  @override
  SignUpState get initialState => StartState();

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) {

    return null;
  }

  void setfaculty(String nameuni){
    facultylist = Datamanager.univeresity.where((uni) => uni["university"] == uni).map((uni) => uni["faculty"]);
    print("faculty : $facultylist");
  }

  void signupform(){
    final form = formkey.currentState;
    print("int fun signup form naja");
    print(Datamanager.univeresity.where((uni) => uni["university"] == "Chaing Mai University").map((uni) => uni["faculty"]));
    if(form.validate()){
      form.save();
    }
    
  }
  
}