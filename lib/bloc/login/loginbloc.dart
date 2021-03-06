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
import 'package:pickcar/models/universityplace.dart';
import 'package:pickcar/models/user.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  var emailcontroller = TextEditingController();
  var passcontroller = TextEditingController();
  var formkey = GlobalKey<FormState>();
  var signinsuccess = false;
  var start = false;
  var signinerrorm = "";
  BuildContext context;
  bool isadmin = false;
  @override
  LoginState get initialState => StartState();

  bool showloginstatus() => start;

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is SignInwithEmailEvent) {
      print('pass maptoevent LoadingSnackBarState');
      try {
        print("in try");
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
                    print('doc isadmin : ${doc['isadmin']}');
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
                    } else {
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
                        documentchat: doc['documentchat'],
                        money: double.parse(doc['money'].toString()),
                        isapprove: doc['isapprove'],
                        isadmin: doc['isadmin']);
                    print("run");
                    var maxSize = 7 * 1024 * 1024;
                    final StorageReference ref = FirebaseStorage.instance
                        .ref()
                        .child("User")
                        .child(Datamanager.user.uid);
                    await ref
                        .child("profile." + Datamanager.user.profileimgtype)
                        .getData(maxSize)
                        .then((data) {
                      ImageProfiles.profileUrl = data;
                    }).catchError((error) {
                      print("------");
                      debugPrint(error.toString());
                    });

                    await ref
                        .child("drimotorcard." +
                            Datamanager.user.drivemotorimgtype)
                        .getData(maxSize)
                        .then((data) {
                      ImageProfiles.drimotorcard = data;
                    }).catchError((error) {
                      print("------");
                      debugPrint(error.toString());
                    });
                    await ref
                        .child("universitycard." +
                            Datamanager.user.universityimgtype)
                        .getData(maxSize)
                        .then((data) {
                      ImageProfiles.universitycard = data;
                    }).catchError((error) {
                      print("------");
                      debugPrint(error.toString());
                    });
                    await ref
                        .child("idcard." + Datamanager.user.idcardimgtype)
                        .getData(maxSize)
                        .then((data) {
                      ImageProfiles.idcard = data;
                    }).catchError((error) {
                      print("------");
                      debugPrint(error.toString());
                    });
                    Datamanager.user.documentid = doc['documentid'];
                    // await Firestore.instance.collection('universityplace')
                    //                       .where('Universityname' , isEqualTo: SetUniversity.university)
                    //                       .getDocuments()
                    //                       .then((data){
                    //                         data.documents.map((data){
                    //                           Datamanager.universityshow = Universityplaceshow.fromSnapshot(data);
                    //                         }).toList();
                    //                       });
                    Datamanager.listUniversity = [];
                    Firestore.instance
                        .collection("universityplace")
                        .snapshots()
                        .listen((data) => data.documents.forEach((doc) async {
                              // print(doc);
                              if (doc != null) {
                                var universityshow =
                                    Universityplaceshow.fromSnapshot(doc);
                                print(universityshow.universityname);
                                print(universityshow);
                                Datamanager.listUniversity
                                    .add(universityshow.universityname);
                                Datamanager.universityshow.add(universityshow);
                              } else {
                                print('aaa');
                              }
                            }));
                    // print(datashow);
                    // print("-------------------");
                    // for (var data in datashow){
                    //   for (var docdata in data.documents){
                    // var universityshow = Universityplaceshow.fromSnapshot(docdata);
                    // print(universityshow.universityname);
                    //     if(universityshow != null){
                    //       Datamanager.listUniversity.add(universityshow.universityname);
                    //     }
                    //   }
                    // }
                    // ((data){
                    //   data.documents.map((data){
                    //     var universityshow = Universityplaceshow.fromSnapshot(data);
                    //     print(universityshow);
                    //     // Datamanager.listUniversity.add(universityshow.universityname);
                    //   }).toList();
                    // });
                    print(Datamanager.user);
                  }));
        });
        signinsuccess = true;
        start = true;
        print("end try");
      } on PlatformException catch (e) {
        start = true;
        signinsuccess = false;
        signinerrorm = "Fail to Login";
        print(e.message);
      }
      event.checkerrorsignin();
      if (signinsuccess) {
        print('start signinsuccess');
        Firestore.instance
            .collection("User")
            .where("uid", isEqualTo: Datamanager.firebaseuser.uid)
            .snapshots()
            .listen((data) => data.documents.forEach((doc) async {
                  if (doc['isadmin']) {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        Datamanager.adminmenu,
                        // Datamanager.chooseadminserverpage,
                        ModalRoute.withName('/'));
                  } else {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        Datamanager.tabpage, ModalRoute.withName('/'));
                  }
                }));
      }
    }
  }
}

var loginbloc = LoginBloc();
