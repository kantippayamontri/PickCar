class SignUpEvent{

}

class ChangeProfileImage extends SignUpEvent{
  Function chanegeimg;
  ChangeProfileImage(this.chanegeimg);
}

class ChangeIDCardImage extends SignUpEvent{
  Function chanegeimg;
  ChangeIDCardImage(this.chanegeimg);
}

class ChangeUniversityCardImage extends SignUpEvent{
  Function changeimg;
  ChangeUniversityCardImage(this.changeimg);
}

class ChangeDriMotor extends SignUpEvent{
  Function changeimg;
  ChangeDriMotor(this.changeimg);
}

class ChangeDriCar extends SignUpEvent{
  Function changeimg;
  ChangeDriCar(this.changeimg);
}