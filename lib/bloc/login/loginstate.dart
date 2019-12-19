import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';

abstract class LoginState {
  
}

class StartState extends LoginState{}

class LoadingSnackBarState extends LoginState{
  var xxx = "dfasdfasdfasdfasdfasd";
}
