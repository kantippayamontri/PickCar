import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pickcar/bloc/registermotor/motorregisterevent.dart';
import 'package:pickcar/bloc/registermotor/motorregisterstate.dart';
import 'package:pickcar/datamanager.dart';
import 'package:pickcar/page/register/motorregisterpage.dart';
import 'package:pickcar/widget/signup/cameragall.dart';
import 'package:progress_dialog/progress_dialog.dart';

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
  File ownerliscense;
  String gear;
  var permission_status_camera;
  var permission_status_gallery;

  ProgressDialog _prwaitingforsubmitdata;

  MotorRegisterBloc(this.context) {
    _prwaitingforsubmitdata = ProgressDialog(this.context,
        type: ProgressDialogType.Normal, isDismissible: true);
    _prwaitingforsubmitdata.style(
        message: UseString.waiting,
        elevation: 10,
        backgroundColor: Colors.white,
        progressWidget: Center(child: CircularProgressIndicator()),
        insetAnimCurve: Curves.easeInOut);
  }

  @override
  // TODO: implement initialState
  MotorRegisterState get initialState => StartState();

  @override
  Stream<MotorRegisterState> mapEventToState(MotorRegisterEvent event) async* {
    // TODO: implement mapEventToState

    if (event is ChangeMotorProfile) {
      print("Change motor profile event");
      openbottomsheetmotorprofile(event.changeimg);
    }
    if (event is ChangeOwnerLiscense) {
      print("Change owner liscense");
      openbottomsheetownerliscense(event.changeimg);
    }
    if (event is ChangeMotorFrontPic) {
      print("Change motor front pic");
      openbottomsheetfrontpic(event.changeimg);
    }

    if (event is ChangeMotorLeftPic) {
      print("Change motor left pic");
      openbuttom(event.changeimg, 3);
    }

    if (event is ChangeMotorRightPic) {
      print("Change motor right pic");
      openbuttom(event.changeimg, 4);
    }

    if (event is ChangeMotorBackPic) {
      print("Change motor right pic");
      openbuttom(event.changeimg, 5);
    }

    if (event is MotorSubmitForm) {
      //yield WaitingSubmitForm();
      _prwaitingforsubmitdata.show();
      await submitform();
      
    }
  }

  bool checkpictureval() {
    return (motorprofile != null) &&
        (ownerliscense != null) &&
        (motorleftside != null) &&
        (motorrightside != null) &&
        (motorfront != null) &&
        (motorback != null);
  }

  void submitform() async {
    print("in submitform in motorbloc");
    final form = formkey.currentState;

    

    if (form.validate()) {
      if(checkpictureval()){
        print("form  motor success");
        _prwaitingforsubmitdata.hide();
      }else{
        print("pic mai kob");
        _prwaitingforsubmitdata.hide();
      }
    }
  }

  void openbuttom(Function changeimg, int option) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return CameraGall(MediaQuery.of(context), () {
            choosecamera(option, permission_status_camera, changeimg);
          }, () {
            choosegall(option, permission_status_gallery, changeimg);
          });
        });
  }

  void openbottomsheetfrontpic(Function changeimg) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return CameraGall(MediaQuery.of(context), () {
            choosecamera(2, permission_status_camera, changeimg);
          }, () {
            choosegall(2, permission_status_gallery, changeimg);
          });
        });
  }

  void openbottomsheetownerliscense(Function changeimg) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return CameraGall(MediaQuery.of(context), () {
            choosecamera(1, permission_status_camera, changeimg);
          }, () {
            choosegall(1, permission_status_gallery, changeimg);
          });
        });
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
        motorprofile = await ImagePicker.pickImage(source: ImageSource.camera);
      if (option == 1)
        ownerliscense = await ImagePicker.pickImage(source: ImageSource.camera);
      if (option == 2)
        motorfront = await ImagePicker.pickImage(source: ImageSource.camera);
      if (option == 3)
        motorleftside = await ImagePicker.pickImage(source: ImageSource.camera);
      if (option == 4)
        motorrightside =
            await ImagePicker.pickImage(source: ImageSource.camera);
      if (option == 5)
        motorback = await ImagePicker.pickImage(source: ImageSource.camera);
      changeimg();
    } else {
      PermissionHandler()
          .requestPermissions([PermissionGroup.camera]).then((status) {
        print("request permission  is ${status[PermissionGroup.camera]}");
      });
      if (option == 0) {
        motorprofile = await ImagePicker.pickImage(source: ImageSource.camera);
      }

      if (option == 1) {
        ownerliscense = await ImagePicker.pickImage(source: ImageSource.camera);
      }

      if (option == 2) {
        motorfront = await ImagePicker.pickImage(source: ImageSource.camera);
      }

      if (option == 3) {
        motorleftside = await ImagePicker.pickImage(source: ImageSource.camera);
      }
      if (option == 4) {
        motorrightside =
            await ImagePicker.pickImage(source: ImageSource.camera);
      }
      if (option == 5) {
        motorback = await ImagePicker.pickImage(source: ImageSource.camera);
      }
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
    if (option == 1) {
      ownerliscense = await ImagePicker.pickImage(source: ImageSource.gallery);
    }
    if (option == 2) {
      motorfront = await ImagePicker.pickImage(source: ImageSource.gallery);
    }

    if (option == 3) {
      motorleftside = await ImagePicker.pickImage(source: ImageSource.gallery);
    }
    if (option == 4) {
      motorrightside = await ImagePicker.pickImage(source: ImageSource.gallery);
    }
    if (option == 5) {
      motorback = await ImagePicker.pickImage(source: ImageSource.gallery);
    }
    //driverliscensecarimage =
    // await ImagePicker.pickImage(source: ImageSource.gallery);
    changeimg();
  }
}
