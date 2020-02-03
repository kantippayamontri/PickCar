import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pickcar/bloc/motordetail/motordetailevent.dart';
import 'package:pickcar/bloc/motordetail/motordetailstate.dart';
import 'package:pickcar/datamanager.dart';
import 'package:pickcar/models/boxslotrent.dart';
import 'package:pickcar/models/motorcycle.dart';
import 'package:pickcar/page/motordetailopenbox.dart';

class MotorDetailBloc extends Bloc<MotorDetailEvent, MotorDetailState> {
  BuildContext context;
  String firestoredocid;
  Motorcycle motorcycle;
  List<String> listcorousel;
  bool needdropkey = false;
  Function setstate;
  Boxslotrent openbox;
  Boxslotrent receivebox;

  MotorDetailBloc(
      {@required this.context,
      @required this.firestoredocid,
      @required this.setstate}) {
    listcorousel = List<String>();
  }

  @override
  // TODO: implement initialState
  MotorDetailState get initialState => MotorDetailStartState();

  @override
  Stream<MotorDetailState> mapEventToState(MotorDetailEvent event) async* {
    // TODO: implement mapEventToState
    if (event is MotorDetailLoadData) {
      print("MotorDetailLoadData");
      yield MotorDetailStartState();
      await loaddata();
      await checkdropkey();
      await checkreceive();
      yield MotorDetailShowdata(motorcycle: this.motorcycle);
    }
  }

  Future<Null> checkreceive() async {
    DateTime datenow = DateTime.now();
    var book =  await Datamanager.firestore
        .collection("Booking")
        .where('motorcycledocid', isEqualTo: this.motorcycle.firestoredocid)
        .getDocuments();

    List<DocumentSnapshot> booklist = book.documents;
    //booklist = booklist.where((doc) =>  );


  }

  Future<Null> checkdropkey() async {
    Boxslotrent currentopenbox;
    DateTime timenow = DateTime.now();
    QuerySnapshot boxslotrent = await Datamanager.firestore
        .collection("BoxslotRent")
        .orderBy('startdate')
        .getDocuments();

    List<DocumentSnapshot> boxslotrentlist = boxslotrent.documents;
    //boxslotrentlist = boxslotrentlist.where((doc) => ( (doc['day'] == timenow.day) && (doc['month'] == timenow.month) && (doc['year'] == timenow.year)));
    if (boxslotrentlist.isEmpty) {
      return;
    }
    print("boxslotrentlist : " + boxslotrentlist.length.toString());
    print("boxslotrentlist docid : " + boxslotrentlist[0]['docid']);
    for (var doc in boxslotrentlist) {
      if (!(doc['day'] == timenow.day) &&
          (doc['month'] == timenow.month) &&
          (doc['year'] == timenow.year)) {
        continue;
      }

      if (doc['ownerdropkey'] == false) {
        currentopenbox = Boxslotrent(
            boxdocid: doc['boxdocid'],
            boxplacedocid: doc['boxplacedocid'],
            boxslotdocid: doc['boxslotdocid'],
            day: doc['day'],
            iskey: doc['iskey'],
            isopen: doc['isopen'],
            month: doc['month'],
            ownerdocid: doc['ownerdocid'],
            ownerdropkey: doc['ownerdropkey'],
            renterdocid: doc['renterdocid'],
            startdate: (doc['startdate'] as Timestamp).toDate(),
            time: doc['time'],
            year: doc['year']);
        currentopenbox.docid = doc['docid'];
        break;
      }
      continue;
    }

    this.openbox = currentopenbox;
    if (openbox != null) {
      print("infunction : ${this.openbox.docid}");
    }
    this.setstate();
  }

  Future navigatetoopenbox() async {
    print("before navigator : ${this.openbox.docid}");
    int message = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MotorDetailOpenBox(
                  boxslotrent: this.openbox,
                  motorcycle: this.motorcycle,
                )));
    print("data back is : ${message}");
  }

  // void showopenbox() {
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (_) {
  //         return MotorDetailOpenBox();
  //       }).whenComplete(() {});
  // }

  Future<void> loaddata() async {
    print("firestoredocid : ${this.firestoredocid}");

    await Datamanager.firestore
        .collection("Motorcycle")
        .document(this.firestoredocid)
        .get()
        .then((doc) {
      this.motorcycle = assigndata(doc);
    });
  }

  Motorcycle assigndata(DocumentSnapshot ds) {
    print("startdfasdfadsfasdfas");
    Motorcycle motor = Motorcycle(
      brand: ds["brand"],
      carstatus: ds['carstatus'],
      cc: ds['cc'],
      color: ds['color'],
      gear: ds['gear'],
      generation: ds['generation'],
      motorbacklink: ds['motorbacklink'],
      motorbackpath: ds['motorbackpath'],
      motorbacktype: ds['motorbacktype'],
      motorfrontlink: ds['motorfrontlink'],
      motorfrontpath: ds['motorfrontpath'],
      motorfronttype: ds['motorfronttype'],
      motorleftlink: ds['motorleftlink'],
      motorleftpath: ds['motorleftpath'],
      motorlefttype: ds['motorlefttype'],
      motorownerliscenselink: ds['motorownerliscenselink'],
      motorprofilelink: ds['motorprofilelink'],
      motorrightlink: ds['motorrightlink'],
      motorrightpath: ds['motorrightpath'],
      motorrighttype: ds['motorrighttype'],
      ownerliscensepath: ds['ownerliscensepath'],
      ownerliscensetype: ds['ownerliscensetype'],
      owneruid: ds['owneruid'],
      profilepath: ds['profilepath'],
      profiletype: ds['profiletype'],
      storagedocid: ds['storagedocid'],
      currentlatitude: ds['currentlatitude'],
      currentlongitude: ds['currentlongitude'],
    );

    motor.firestoredocid = ds['firestoredocid'];
    motor.isbook = ds['isbook'];
    motor.iswaiting = ds['iswaiting'];
    motor.isworking = ds['isworking'];

    listcorousel.add(ds['motorfrontlink']);
    listcorousel.add(ds['motorleftlink']);
    listcorousel.add(ds['motorrightlink']);
    listcorousel.add(ds['motorbacklink']);

    return motor;
  }
}
