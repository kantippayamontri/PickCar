// import 'dart:html';
import 'dart:io';
import 'package:flutter/material.dart';


class EditProfileEvent{

}
class ChangeProfileImage extends EditProfileEvent{
  File changeimg;
  BuildContext context;
  ChangeProfileImage(this.context,this.changeimg);
}

class ChangeIDCardImage extends EditProfileEvent{
  File changeimg;
  BuildContext context;
  ChangeIDCardImage(this.context,this.changeimg);
}

class ChangeUniversityCardImage extends EditProfileEvent{
  File changeimg;
  BuildContext context;
  ChangeUniversityCardImage(this.context,this.changeimg);
}

class ChangeDriMotor extends EditProfileEvent{
  File changeimg;
  BuildContext context;
  ChangeDriMotor(this.context,this.changeimg);
}

class ChangeDriCar extends EditProfileEvent{
  File changeimg;
  BuildContext context;
  ChangeDriCar(this.context,this.changeimg);
}
