import 'package:flutter/cupertino.dart';

class MotorRegisterEvent{

}

class ChangeMotorProfile extends MotorRegisterEvent{
  Function changeimg;
  ChangeMotorProfile({@required this.changeimg});
}

class ChangeOwnerLiscense extends MotorRegisterEvent{
  Function changeimg;
  ChangeOwnerLiscense({@required this.changeimg});
}
