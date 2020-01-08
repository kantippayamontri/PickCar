import 'package:flutter/cupertino.dart';
import 'package:pickcar/models/motorcycle.dart';

class MotorDetailState {}

class MotorDetailStartState extends MotorDetailState {
  MotorDetailStartState();
}

class MotorDetailShowdata extends MotorDetailState{
  Motorcycle motorcycle;
  MotorDetailShowdata({@required this.motorcycle});
}
