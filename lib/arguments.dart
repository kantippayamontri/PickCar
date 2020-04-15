import 'package:flutter/cupertino.dart';
import 'package:pickcar/models/motorcycle.dart';

class MotorBookListArguments{
  Motorcycle motorcycle;
  Function setstate;
  MotorBookListArguments({@required this.motorcycle , @required this.setstate});
}

