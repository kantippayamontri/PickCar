import 'package:flutter/cupertino.dart';

class MotorRegisterEvent{

}

class MotorSubmitForm extends MotorRegisterEvent{
  
  MotorSubmitForm();
  }

class ChangeMotorRightPic extends MotorRegisterEvent{
  Function changeimg;
  ChangeMotorRightPic({@required this.changeimg});
}

class ChangeMotorBackPic extends MotorRegisterEvent{
  Function changeimg;
  ChangeMotorBackPic({@required this.changeimg});
}

class ChangeMotorLeftPic extends MotorRegisterEvent{
  Function changeimg;
  ChangeMotorLeftPic({@required this.changeimg});
}

class ChangeMotorFrontPic extends MotorRegisterEvent{
  Function changeimg;
  ChangeMotorFrontPic({@required this.changeimg});
}

class ChangeMotorProfile extends MotorRegisterEvent{
  Function changeimg;
  ChangeMotorProfile(this.changeimg);
}

class ChangeOwnerLiscense extends MotorRegisterEvent{
  Function changeimg;
  ChangeOwnerLiscense({@required this.changeimg});
}
