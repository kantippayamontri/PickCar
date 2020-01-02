import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pickcar/bloc/registermotor/motorregisterevent.dart';
import 'package:pickcar/bloc/registermotor/motorregisterstate.dart';
import 'package:pickcar/page/register/motorregisterpage.dart';
import 'package:pickcar/widget/signup/cameragall.dart';

class MotorRegisterBloc extends Bloc<MotorRegisterEvent, MotorRegisterState> {
  BuildContext context;
  var formkey = GlobalKey<FormState>();
  var brandcontroller = TextEditingController();
  var generationcontroller = TextEditingController();
  var cccontroller = TextEditingController();
  var colorcontroller = TextEditingController();
  File motorprofile;
  File motorfront;
  File motorback;
  File motorleftside;
  File motorrightside;
  String gear;
  var permission_status_camera;
  var permission_status_gallery;

  MotorRegisterBloc(this.context);

  @override
  // TODO: implement initialState
  MotorRegisterState get initialState => StartState();

  @override
  Stream<MotorRegisterState> mapEventToState(MotorRegisterEvent event) {
    // TODO: implement mapEventToState
    if (event is ChangeMotorProfile) {
      print("Change motor profile event");
      openbottomsheetmotorprofile(event.changeimg);
    }
  }

  void openbottomsheetmotorprofile(Function changeimg) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return CameraGall(MediaQuery.of(context), () {
            choosecamera(0, permission_status_camera, changeimg);
          }, () {
            choosegall(0, permission_status_gallery, changeimg);
          });
        });
  }

  void choosecamera(
      int option, PermissionStatus status, Function changeimg) async {
    PermissionHandler()
        .checkPermissionStatus(PermissionGroup.camera)
        .then((val) {
      status = val;
      print("status is $val");
    });

    if (status == PermissionStatus.granted) {
      print("123456789");

      if (option == 0)
        //profileimage = await ImagePicker.pickImage(source: ImageSource.camera);
        motorprofile = await ImagePicker.pickImage(source: ImageSource.camera);
      if (option == 1)
      //idcardimage = await ImagePicker.pickImage(source: ImageSource.camera);
      if (option == 2)
      //universityimage =
      //await ImagePicker.pickImage(source: ImageSource.camera);
      if (option == 3)
      //driverliscensemotorcycleimage =
      // await ImagePicker.pickImage(source: ImageSource.camera);
      if (option == 4)
        //driverliscensecarimage =
        // await ImagePicker.pickImage(source: ImageSource.camera);
        changeimg();
    } else {
      PermissionHandler()
          .requestPermissions([PermissionGroup.camera]).then((status) {
        print("request permission  is ${status[PermissionGroup.camera]}");
      });
      if (option == 0) {
        motorprofile = await ImagePicker.pickImage(source: ImageSource.camera);
      }
      //profileimage = await ImagePicker.pickImage(source: ImageSource.camera);

      if (option == 1) {}
      //idcardimage = await ImagePicker.pickImage(source: ImageSource.camera);
      if (option == 2) {}
      //universityimage =
      // await ImagePicker.pickImage(source: ImageSource.camera);
      if (option == 3) {}
      //driverliscensemotorcycleimage =
      // await ImagePicker.pickImage(source: ImageSource.camera);
      if (option == 4) {}
      // driverliscensecarimage =
      // await ImagePicker.pickImage(source: ImageSource.camera);
      changeimg();
    }
  }

  void choosegall(
      int option, PermissionStatus status, Function changeimg) async {
    if (option == 0) {
      motorprofile = await ImagePicker.pickImage(source: ImageSource.gallery);
    }
    //profileimage = await ImagePicker.pickImage(source: ImageSource.gallery);

    if (option == 1) {}
    //idcardimage = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (option == 2) {}
    //universityimage =
    // await ImagePicker.pickImage(source: ImageSource.gallery);
    if (option == 3) {}
    //driverliscensemotorcycleimage =
    //await ImagePicker.pickImage(source: ImageSource.gallery);
    if (option == 4) {}
    //driverliscensecarimage =
    // await ImagePicker.pickImage(source: ImageSource.gallery);
    changeimg();
  }
}
