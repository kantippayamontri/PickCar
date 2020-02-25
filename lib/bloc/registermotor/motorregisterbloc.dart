import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime_type/mime_type.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pickcar/bloc/registermotor/motorregisterevent.dart';
import 'package:pickcar/bloc/registermotor/motorregisterstate.dart';
import 'package:pickcar/datamanager.dart';
import 'package:pickcar/models/motorcycle.dart';
import 'package:pickcar/page/register/motorregisterpage.dart';
import 'package:pickcar/widget/signup/cameragall.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:pickcar/icon/correcticon_icons.dart';

class MotorRegisterBloc extends Bloc<MotorRegisterEvent, MotorRegisterState> {
  BuildContext context;
  var formkey = GlobalKey<FormState>();
  var brandcontroller = TextEditingController();
  var generationcontroller = TextEditingController();
  var cccontroller = TextEditingController();
  var colorcontroller = TextEditingController();
  var carregistercontroller = TextEditingController();
  File motorprofile;
  File motorfront;
  File motorback;
  File motorleftside;
  File motorrightside;
  File ownerliscense;
  String motorprofiletype;
  String ownerliscensetype;
  String motorfronttype;
  String motorbacktype;
  String motorlefttype;
  String motorrighttype;
  String gear;
  String docstorageid;
  String gas;
  var permission_status_camera;
  var permission_status_gallery;
  ProgressDialog prwaitingforsubmitdata;
  String motorprofilelink;
  String motorownerliscenselink;
  String motorfrontlink;
  String motorbacklink;
  String motorleftlink;
  String motorrightlink;

  MotorRegisterBloc(this.context) {
    prwaitingforsubmitdata = ProgressDialog(this.context,
        type: ProgressDialogType.Normal, isDismissible: false);
    prwaitingforsubmitdata.style(
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
      //prwaitingforsubmitdata.show();
      await submitform();
    }
  }

  void showdialogpicval(String title, String msg) {
    showDialog(
        context: this.context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(msg),
            actions: <Widget>[
              FlatButton(
                child: Text(UseString.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  Future<bool> putdatastorage() async {
    docstorageid =
        Datamanager.user.uid + Key(DateTime.now().toString()).toString();
    File img;
    String ext;
    String contenttype;
    bool check = true;
    StorageUploadTask uploadtask;
    StorageReference downloadref;
    StorageReference ref = Datamanager.firebasestorage
        .ref()
        .child("Car")
        .child("Motorcycle")
        .child(docstorageid);

    //TODO motor profile
    
    img = motorprofile;
    contenttype = mime(img.path);
    ext = contenttype.split('/').last;
    downloadref = ref
        .child("motorprofile.${ext}");
    uploadtask = ref
        .child("motorprofile.${ext}")
        .putFile(img, StorageMetadata(contentType: contenttype));
    await uploadtask.onComplete;
    if (uploadtask.isComplete) {
      print("upload motor profile success");
      motorprofiletype = ext;
      await downloadref.getDownloadURL().then((val){
        motorprofilelink = val.toString();
      });
    } else {
      check = false;
    }

    //TODO owner liscense
    
    img = ownerliscense;
    contenttype = mime(img.path);
    ext = contenttype.split('/').last;
    downloadref = ref
        .child("ownerliscense.${ext}");
    uploadtask = ref
        .child("ownerliscense.${ext}")
        .putFile(img, StorageMetadata(contentType: contenttype));
    await uploadtask.onComplete;
    if (uploadtask.isComplete) {
      print("upload  ownerliscense motor success");
      ownerliscensetype = ext;
      await downloadref.getDownloadURL().then((val){
        motorownerliscenselink = val.toString();
      });
    } else {
      check = false;
    }

    //TODO motor front
    
    img = motorfront;
    contenttype = mime(img.path);
    ext = contenttype.split('/').last;
    downloadref = ref
        .child("motorfront.${ext}");
    uploadtask = ref
        .child("motorfront.${ext}")
        .putFile(img, StorageMetadata(contentType: contenttype));
    await uploadtask.onComplete;
    if (uploadtask.isComplete) {
      print("upload  motor front success");
      motorfronttype = ext;
      await downloadref.getDownloadURL().then((val){
        motorfrontlink = val.toString();
      });
    } else {
      check = false;
    }

    //TODO motor left
    
    img = motorleftside;
    contenttype = mime(img.path);
    ext = contenttype.split('/').last;
    downloadref = ref
        .child("motorleft.${ext}");
    uploadtask = ref
        .child("motorleft.${ext}")
        .putFile(img, StorageMetadata(contentType: contenttype));
    await uploadtask.onComplete;
    if (uploadtask.isComplete) {
      print("upload  motor left success");
      motorlefttype = ext;
      await downloadref.getDownloadURL().then((val){
        motorleftlink = val.toString();
      });
    } else {
      check = false;
    }

    //TODO motor right
    
    img = motorrightside;
    contenttype = mime(img.path);
    ext = contenttype.split('/').last;
    downloadref = ref
        .child("motorright.${ext}");
    uploadtask = ref
        .child("motorright.${ext}")
        .putFile(img, StorageMetadata(contentType: contenttype));
    await uploadtask.onComplete;
    if (uploadtask.isComplete) {
      print("upload  motor right success");
      motorrighttype = ext;
      await downloadref.getDownloadURL().then((val){
        motorrightlink = val.toString();
      });
    } else {
      check = false;
    }

    //todo motor back
    
    img = motorback;
    contenttype = mime(img.path);
    ext = contenttype.split('/').last;
    downloadref = ref
        .child("motorback.${ext}");
    uploadtask = ref
        .child("motorback.${ext}")
        .putFile(img, StorageMetadata(contentType: contenttype));
    await uploadtask.onComplete;
    if (uploadtask.isComplete) {
      print("upload  motor back success");
      motorbacktype = ext;
      await downloadref.getDownloadURL().then((val){
        motorbacklink = val.toString();
      });
    } else {
      check = false;
    }

    return check;
  }

  Future<Null> createmotor() async {
    print("in createmotor");
    if (await putdatastorage()) {
      print("ready for createmotor");
      Motorcycle motorcycle = Motorcycle(
        profilepath: "motorprofile",
        profiletype: motorprofiletype,
        ownerliscensepath: "ownerliscense",
        ownerliscensetype: ownerliscensetype,
        motorfrontpath: "motorfront",
        motorfronttype: motorfronttype,
        motorbackpath: "motorback",
        motorbacktype: motorbacktype,
        motorleftpath: "motorleft",
        motorlefttype: motorlefttype,
        motorrightpath: "motorright",
        motorrighttype: motorrighttype,
        brand: brandcontroller.text,
        cc: int.parse(cccontroller.text),
        color: colorcontroller.text,
        gear: gear,
        generation: generationcontroller.text,
        owneruid: Datamanager.user.uid,
        storagedocid: docstorageid,
        motorprofilelink: motorprofilelink,
        motorownerliscenselink: motorownerliscenselink,
        motorfrontlink: motorfrontlink,
        motorbacklink: motorbacklink,
        motorleftlink: motorleftlink,
        motorrightlink: motorrightlink,
        carstatus: CarStatus.nothing,
        currentlatitude: null,
        currentlongitude: null,
        isworking: false,
        iswaiting: false,
        isbook: false,
        motorgas: this.gas,
        motorreg: this.carregistercontroller.text,
        isapprove: 'wait',
      );

      final docref = await Datamanager.firestore
          .collection("Motorcycle")
          .add(motorcycle.toJson());
      String docid = docref.documentID;
      await Datamanager.firestore
          .collection("Motorcycle")
          .document(docid)
          .updateData({'firestoredocid': docid});
      prwaitingforsubmitdata.update(
          message: "Register Success",
          progressWidget: Center(
            child: Center(
              child: Stack(
                children: <Widget>[
                  Icon(
                    Correcticon.done,
                    color: PickCarColor.colormain,
                  ),
                  Icon(
                    Correcticon.ok_circle,
                    color: PickCarColor.colormain,
                  )
                ],
              ),
            ),
          ));
      await Future.delayed(const Duration(milliseconds: 2000), () {
        Navigator.of(context).pop();
      });
      Navigator.popAndPushNamed(this.context, Datamanager.listcarpage);
    } else {
      showdialogpicval(
          UseString.registermotorfail, UseString.registermotorfail);
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

  Future<Null> submitform() async {
    print("in submitform in motorbloc");
    final form = formkey.currentState;

    if (form.validate()) {
      print("form validate naja");
      if (checkpictureval()) {
        print("form  motor success");
        prwaitingforsubmitdata.show();
        await createmotor();
      } else {
        print("gas : " + this.gas);
        print("car reg : " + this.carregistercontroller.text);
        //prwaitingforsubmitdata.update(message: "sdfasdfasdfasdf");
        if (prwaitingforsubmitdata.isShowing()) {
          prwaitingforsubmitdata.hide();
          Navigator.pop(context);
        }
        print("pic mai kob");
        showdialogpicval(UseString.picuploadval, UseString.picuploadval);
        return;
      }
    }else{
      print("form not validate");
      return;
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
