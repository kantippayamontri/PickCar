import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime_type/mime_type.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pickcar/bloc/signup/signupevent.dart';
import 'package:pickcar/bloc/signup/signupstate.dart';
import 'package:pickcar/models/user.dart';
import 'package:pickcar/widget/signup/cameragall.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../datamanager.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  BuildContext context;
  var formkey = GlobalKey<FormState>();
  var namecontroller = TextEditingController();
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var confirmpasswordcontroller = TextEditingController();
  var telcontroller = TextEditingController();
  var addresscontroller = TextEditingController();
  String university;
  String faculty;
  File profileimage;
  File idcardimage;
  File universityimage;
  File driverliscensemotorcycleimage;
  File driverliscensecarimage;
  String profileimgtype;
  String idcardimgtype;
  String universityimgtype;
  String drivemotorimgtype;
  String drivecarimgtype;
  var permission_status_camera;
  var permission_status_gallery;

  SignUpBloc(this.context);

  @override
  SignUpState get initialState => StartState();

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    if (event is ChangeProfileImage) {
      print("change profile images event naja");
      openbottomsheetimg(event.chanegeimg);
    }

    if (event is ChangeIDCardImage) {
      print("change id card images event naja");
      openbottomsheetimgidcard(event.chanegeimg);
    }

    if (event is ChangeUniversityCardImage) {
      print("change id card images event naja");
      openbottomsheetimguniversitycard(event.changeimg);
    }

    if (event is ChangeDriMotor) {
      print("change driver motorcycle card images event naja");
      openbottomsheetimgdrivemotor(event.changeimg);
    }

    if (event is ChangeDriCar) {
      print("change driver car card images event naja");
      openbottomsheetimgdrivecar(event.changeimg);
    }
  }

  /*void choosecamera(
      File image, PermissionStatus status, Function changeimg) async {
    PermissionHandler()
        .checkPermissionStatus(PermissionGroup.camera)
        .then((val) {
      status = val;
      print("status is $val");
    });

    if (status == PermissionStatus.granted) {
      print("123456789");
      profileimage = await ImagePicker.pickImage(source: ImageSource.camera);
      changeimg();
    } else {
      PermissionHandler()
          .requestPermissions([PermissionGroup.camera]).then((status) {
        print("request permission  is ${status[PermissionGroup.camera]}");
      });
      profileimage = await ImagePicker.pickImage(source: ImageSource.camera);
      changeimg();
    }
  }*/

  /*void choosegall(
      File image, PermissionStatus status, Function changeimg) async {
    profileimage = await ImagePicker.pickImage(source: ImageSource.gallery);
    changeimg();
    /*PermissionHandler()
        .checkPermissionStatus(PermissionGroup.)
        .then((val) {
      status = val;
      print("status is $val");
    });*/

    /*if (status == PermissionStatus.granted) {
       print("123456789");
      image = await ImagePicker.pickImage(source: ImageSource.camera);
      changeimg();
    }else {
      PermissionHandler()
          .requestPermissions([PermissionGroup.camera]).then((status) {
        print("request permission  is ${status[PermissionGroup.camera]}");
      });
      profileimage = await ImagePicker.pickImage(source: ImageSource.camera);
      changeimg();
    }*/
  }*/

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
        profileimage = await ImagePicker.pickImage(source: ImageSource.camera);
      if (option == 1)
        idcardimage = await ImagePicker.pickImage(source: ImageSource.camera);
      if (option == 2)
        universityimage =
            await ImagePicker.pickImage(source: ImageSource.camera);
      if (option == 3)
        driverliscensemotorcycleimage =
            await ImagePicker.pickImage(source: ImageSource.camera);
      if (option == 4)
        driverliscensecarimage =
            await ImagePicker.pickImage(source: ImageSource.camera);
      changeimg();
    } else {
      PermissionHandler()
          .requestPermissions([PermissionGroup.camera]).then((status) {
        print("request permission  is ${status[PermissionGroup.camera]}");
      });
      if (option == 0)
        profileimage = await ImagePicker.pickImage(source: ImageSource.camera);
      if (option == 1)
        idcardimage = await ImagePicker.pickImage(source: ImageSource.camera);
      if (option == 2)
        universityimage =
            await ImagePicker.pickImage(source: ImageSource.camera);
      if (option == 3)
        driverliscensemotorcycleimage =
            await ImagePicker.pickImage(source: ImageSource.camera);
      if (option == 4)
        driverliscensecarimage =
            await ImagePicker.pickImage(source: ImageSource.camera);
      changeimg();
    }
  }

  void choosegall(
      int option, PermissionStatus status, Function changeimg) async {
    if (option == 0)
      profileimage = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (option == 1)
      idcardimage = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (option == 2)
      universityimage =
          await ImagePicker.pickImage(source: ImageSource.gallery);
    if (option == 3)
      driverliscensemotorcycleimage =
          await ImagePicker.pickImage(source: ImageSource.gallery);
    if (option == 4)
      driverliscensecarimage =
          await ImagePicker.pickImage(source: ImageSource.gallery);
    changeimg();
  }

  void openbottomsheetimg(Function changeimg) {
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

  void openbottomsheetimgdrivecar(Function changeimg) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return CameraGall(MediaQuery.of(context), () {
            choosecamera(4, permission_status_camera, changeimg);
          }, () {
            choosegall(4, permission_status_gallery, changeimg);
          });
        });
  }

  void openbottomsheetimgdrivemotor(Function changeimg) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return CameraGall(MediaQuery.of(context), () {
            choosecamera(3, permission_status_camera, changeimg);
          }, () {
            choosegall(3, permission_status_gallery, changeimg);
          });
        });
  }

  void openbottomsheetimguniversitycard(Function changeimg) {
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

  void openbottomsheetimgidcard(Function changeimg) {
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

  void showalertidcard() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("ID Card Image"),
            content: Text("Please Upload Your ID Card image"),
            actions: <Widget>[
              FlatButton(
                child: Text("close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void signupform() async {
    //putdatatostorage("8qceK19vvBPloVN5hVDNW27b0gs1");
    //Firestore.instance.collection("test").document().setData({'name' : 'eiei' , 'surname' : 'eieimore'});
    /*if(profileimage != null){
      print("profile : ${profileimage.toString()}");
      print("profile : ${profileimage.uri}");
      print("profile : ${profileimage.path}");
      print("profile : ${mime(profileimage.path).split('/').last}");
    }*/
    final form = formkey.currentState;
    print("int fun signup form naja");
    /*print(Datamanager.univeresity
        .where((uni) => uni["university"] == "Chaing Mai University")
        .map((uni) => uni["faculty"]));*/
    if (idcardimage == null) {
      showalertidcard();
      return;
    }
    if (form.validate()) {
      form.save();
      await createuser();
      Navigator.of(context).pushNamedAndRemoveUntil(Datamanager.tabpage, ModalRoute.withName('/'));
    }
  }

  void createuser() async {
    print("in function createuser");

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: emailcontroller.text, password: passwordcontroller.text)
        .then((user) async {
      print("user uid : ${user.user.uid}");
      Datamanager.firebaseuser = user.user;

      if (await putdatatostorage(Datamanager.firebaseuser.uid)) {
        Datamanager.user = User(
          uid: Datamanager.firebaseuser.uid,
          email: emailcontroller.text,
          password: passwordcontroller.text,
          name: namecontroller.text,
          address: addresscontroller.text,
          university: university,
          faculty: faculty,
          tel: telcontroller.text,
          profileimg: profileimage,
          profileimgtype: profileimgtype,
          idcardimg: idcardimage,
          idcardimgtype: idcardimgtype,
          universityimg: universityimage,
          universityimgtype: universityimgtype,
          drivemotorimg: driverliscensemotorcycleimage,
          drivemotorimgtype: drivemotorimgtype,
          drivecarimg: driverliscensecarimage,
          drivecarimgtype: drivecarimgtype,
          money: 500.00
        );
        await Datamanager.firestore
            .collection('User')
            .document()
            .setData(Datamanager.user.toJson());
        print("Sign Up User Successful");
      }

      //Navigator.of(context).pushAndRemoveUntil(context , );
    }).catchError((onError) {
      print(onError);
    });
  }

  Future<bool> putdatatostorage(String uid) async {
    File img;
    String contenttype;
    String ext;
    StorageReference ref =
        Datamanager.firebasestorage.ref().child("User").child(uid);
    StorageUploadTask uploadtask;
    bool check = true;

    if (profileimage != null) {
      img = profileimage;
    } else {
      img = File("assets/images/user.png");
    }
    contenttype = mime(img.path);
    ext = contenttype.split('/').last;
    uploadtask = ref
        .child("profile.${ext}")
        .putFile(img, StorageMetadata(contentType: contenttype));
    await uploadtask.onComplete;
    if (uploadtask.isComplete) {
      print("upload profile success");
      profileimgtype = ext;
    } else {
      check = false;
    }

    img = idcardimage;
    contenttype = mime(img.path);
    ext = contenttype.split('/').last;
    uploadtask = ref
        .child("idcard.${ext}")
        .putFile(img, StorageMetadata(contentType: contenttype));
    await uploadtask.onComplete;
    if (uploadtask.isComplete) {
      print("upload profile success");
      idcardimgtype = ext;
    } else {
      check = false;
    }

    img = universityimage;
    contenttype = mime(img.path);
    ext = contenttype.split('/').last;
    uploadtask = ref
        .child("universitycard.${ext}")
        .putFile(img, StorageMetadata(contentType: contenttype));
    await uploadtask.onComplete;
    if (uploadtask.isComplete) {
      print("upload profile success");
      universityimgtype = ext;
    } else {
      check = false;
    }

    if (driverliscensemotorcycleimage != null) {
      img = driverliscensemotorcycleimage;
      contenttype = mime(img.path);
      ext = contenttype.split('/').last;
      uploadtask = ref
          .child("drimotorcard.${ext}")
          .putFile(img, StorageMetadata(contentType: contenttype));
      await uploadtask.onComplete;
      if (uploadtask.isComplete) {
        print("upload profile success");
        drivemotorimgtype = ext;
      } else {
        check = false;
      }
    }

    if (driverliscensecarimage != null) {
      img = driverliscensecarimage;
      contenttype = mime(img.path);
      ext = contenttype.split('/').last;
      uploadtask = ref
          .child("dricarcard.${ext}")
          .putFile(img, StorageMetadata(contentType: contenttype));
      await uploadtask.onComplete;
      if (uploadtask.isComplete) {
        print("upload profile success");
        drivecarimgtype = ext;
      } else {
        check = false;
      }
    }

    return check;
  }
}
