import 'dart:ffi';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pickcar/bloc/login/loginevent.dart';
import 'package:pickcar/bloc/login/loginstate.dart';
import 'package:pickcar/datamanager.dart';
import 'package:pickcar/models/user.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  var emailcontroller = TextEditingController();
  var passcontroller = TextEditingController();
  var formkey = GlobalKey<FormState>();
  var signinsuccess = false;
  var start = false;
  var signinerrorm = "";
  BuildContext context;
  @override
  LoginState get initialState => StartState();

  bool showloginstatus() => start;

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is SignInwithEmailEvent) {
      print('pass maptoevent LoadingSnackBarState');
      try {
        await Datamanager.firebaseauth.signInWithEmailAndPassword(
            email: event.email, password: event.password);
        /*.then((user){
              print('login success : ${user.user.email}');
              signinsuccess = true;
            });*/
        await Datamanager.firebaseauth.currentUser().then((user) {
          Datamanager.firebaseuser = user;
          Firestore.instance
              .collection("User")
              .where("uid", isEqualTo: user.uid)
              .snapshots()
              .listen((data) => data.documents.forEach((doc) async {
                    print(doc);
                    var starageref = Datamanager.firebasestorage.ref();
                    String imgurl;
                    //print("uri of profilepic : ${doc['profilepicpath']}.${doc['profilepictype']}");
                    //print(await starageref.child("User").child("/" + user.uid).child("/${doc['profilepicpath']}.${doc['profilepictype']}").getDownloadURL() as String);
                    imgurl = starageref
                        .child("User")
                        .child(user.uid)
                        .child(
                            "${doc['profilepicpath']}.${doc['profilepictype']}")
                        .getDownloadURL()
                        .toString();
                    File profileimg = await File.fromUri(Uri.parse(imgurl));
                    imgurl = starageref
                        .child("User")
                        .child(user.uid)
                        .child("${doc['idcardpath']}.${doc['idcardpictype']}")
                        .getDownloadURL()
                        .toString();
                    File idcardimg = await File.fromUri(Uri.parse(imgurl));
                    imgurl = starageref
                        .child("User")
                        .child(user.uid)
                        .child(
                            "${doc['universitycadrpath']}.${doc['universitycardtype']}")
                        .getDownloadURL()
                        .toString();
                    File universityimg = await File.fromUri(Uri.parse(imgurl));

                    File drimotorimg;
                    if (doc['driveliscensemotorpictype'] != null) {
                      imgurl = starageref
                          .child("User")
                          .child(user.uid)
                          .child(
                              "${doc['driveliscensemotorpath']}.${doc['driveliscensemotorpictype']}")
                          .getDownloadURL()
                          .toString();
                      drimotorimg = await File.fromUri(Uri.parse(imgurl));
                    } else {
                      drimotorimg = null;
                    }

                    File dricarimg;
                    if (doc['driveliscensecarpictype'] != null) {
                      imgurl = starageref
                          .child("User")
                          .child(user.uid)
                          .child(
                              "${doc['driveliscensecarpath']}.${doc['driveliscensecarpictype']}")
                          .getDownloadURL()
                          .toString();
                      dricarimg = await File.fromUri(Uri.parse(imgurl));
                    }else{
                      dricarimg = null;
                    }
                    Datamanager.user = User(
                      uid: doc['uid'],
                      email: doc['email'],
                      password: doc['password'],
                      name: doc['name'],
                      address: doc['address'],
                      university: doc['university'],
                      faculty: doc['faculty'],
                      tel: doc['telepphonenumnber'],
                      profileimg: profileimg,
                      profileimgtype: doc['profilepictype'],
                      idcardimg: idcardimg,
                      idcardimgtype: doc['idcardpictype'],
                      universityimg: universityimg,
                      universityimgtype: doc['universitycardtype'],
                      drivemotorimg: drimotorimg,
                      drivemotorimgtype: doc['driveliscensemotorpictype'],
                      drivecarimg: dricarimg,
                      drivecarimgtype: doc['driveliscensecarpictype'],
                      money:  double.parse(doc['money'].toString()),
                    );
                    print("run");
                    var maxSize = 7*1024*1024;
                    final StorageReference ref = FirebaseStorage.instance.ref()
                    .child("User")
                    .child(Datamanager.user.uid);
                    await ref.child("profile." + Datamanager.user.profileimgtype).getData(maxSize).then((data){
                      ImageProfiles.profileUrl = data;
                    }).catchError((error){
                      print("------");
                      debugPrint(error.toString());
                    });
                    print(Datamanager.user);
                  }));
        });
        signinsuccess = true;
        start = true;
      } on PlatformException catch (e) {
        start = true;
        signinsuccess = false;
        signinerrorm = "Fail to Login";
        print(e.message);
      }
      event.checkerrorsignin();
      if(signinsuccess){
        Navigator.of(context).pushNamedAndRemoveUntil(Datamanager.tabpage, ModalRoute.withName('/'));
      }
    }
  }
}

var loginbloc = LoginBloc();
