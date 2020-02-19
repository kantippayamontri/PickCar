import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pickcar/bloc/motordetail/motordetailevent.dart';
import 'package:pickcar/bloc/motordetail/motordetailstate.dart';
import 'package:pickcar/datamanager.dart';
import 'package:pickcar/models/boxlocation.dart';
import 'package:pickcar/models/boxslotrent.dart';
import 'package:pickcar/models/motorcycle.dart';
import 'package:pickcar/models/placelocation.dart';
import 'package:pickcar/page/motordetailopenbox.dart';
import 'package:pickcar/page/motordetailreceivebox.dart';

class MotorDetailBloc extends Bloc<MotorDetailEvent, MotorDetailState> {
  BuildContext context;
  String firestoredocid;
  Motorcycle motorcycle;
  List<String> listcorousel;
  bool needdropkey = false;
  Function setstate;
  Boxslotrent openbox;
  Boxslotrent receivebox;
  String receivebookdocid;

  Placelocation openboxmotorplace;
  Boxlocation openboxboxplace;

  Placelocation receivemotorplace;
  Boxlocation receiveboxplace;

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
    var book = await Datamanager.firestore
        .collection("Booking")
        //.where('motorcycledocid', isEqualTo: this.motorcycle.firestoredocid)
        //.where('status' , isEqualTo: 'end')
        .orderBy('startdate')
        .getDocuments();
    List<DocumentSnapshot> booklist = book.documents;
    booklist = booklist
        .where((doc) =>
            ((doc['motorcycledocid'] == this.motorcycle.firestoredocid) &&
                (doc['status'] == 'end')))
        .toList();
    // print("booklist length : ${booklist.length}");
    // print("motor docid : ${this.motorcycle.firestoredocid}");
    // print("status in book : ${ book.documents[0]['status']}");
    if (booklist.isEmpty) {
      setstate();
      return;
    } else {
      DocumentSnapshot book = booklist.first;
      DocumentSnapshot boxslotrent = await Datamanager.firestore
          .collection("BoxslotRent")
          .document(book['boxslotrentdocid'])
          .get();

      this.receivebox = Boxslotrent(
          boxdocid: boxslotrent['boxdocid'],
          boxplacedocid: boxslotrent['boxplacedocid'],
          boxslotdocid: boxslotrent['boxslotdocid'],
          day: boxslotrent['day'],
          iskey: boxslotrent['iskey'],
          isopen: boxslotrent['isopen'],
          month: boxslotrent['month'],
          ownerdocid: boxslotrent['ownerdocid'],
          ownerdropkey: boxslotrent['ownerdropkey'],
          renterdocid: boxslotrent['renterdocid'],
          startdate: (boxslotrent['startdate'] as Timestamp).toDate(),
          time: boxslotrent['time'],
          year: boxslotrent['year'],
          motorplaceloc: boxslotrent['motorplaceloc']);
      this.receivebox.docid = boxslotrent['docid'];

      this.receivebookdocid = book['bookingdocid'];

      DocumentSnapshot motorplacedoc = await Datamanager.firestore
          .collection("placelocation")
          .document(this.receivebox.motorplaceloc)
          .get();
      this.receivemotorplace = Placelocation(
        latitude: motorplacedoc['latitude'],
        longitude: motorplacedoc['longitude'],
        name: motorplacedoc['name'],
        universityname: motorplacedoc['universityname'],
      );

      DocumentSnapshot boxplacedoc = await Datamanager.firestore
          .collection("boxlocation")
          .document(this.receivebox.boxplacedocid)
          .get();
      this.receiveboxplace = Boxlocation(
        latitude: boxplacedoc['latitude'],
        longitude:  boxplacedoc['longitude'],
        name:  boxplacedoc['name'],
        universityname:  boxplacedoc['universityname'],
      );

      setstate();
      /*DocumentSnapshot  doc = booklist.first;
      print("bookingdocid : " + doc['bookingdocid']);
      print("motorcycledocid : " + doc['motorcycledocid']);
      print("boxslotrentdocid : " + doc['boxslotrentdocid']);
      print("isopen : " + doc['isopen'].toString());
      this.receivebox = Boxslotrent(
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
        year: doc['year'],
      );

      //print("receivebox.docid : ${doc['docid']}");
      //print("receivebox.isopen : ${doc['isopen']}");
      this.receivebox.docid = doc['boxslotrentdocid'];

      this.receivebookdocid = doc['docid'];
      setstate();*/
    }
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
      print("dropkey is empty");
      return;
    } else {
      print("dropkey is not empty");
    }
    print("boxslotrentlist : " + boxslotrentlist.length.toString());
    print("boxslotrentlist docid : " + boxslotrentlist[0]['docid']);
    for (var doc in boxslotrentlist) {
      if (!(doc['day'] == timenow.day) &&
          (doc['month'] == timenow.month) &&
          (doc['year'] == timenow.year)) {
        print("doc continuce : ${doc['docid']}");
        continue;
      }

      if (doc['ownerdropkey'] == false   /*&&((doc['startdate'] as Timestamp).toDate().isAfter(timenow))*/) {
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
            year: doc['year'],
            motorplaceloc: doc['motorplaceloc']);
        currentopenbox.docid = doc['docid'];
        break;
      }
      continue;
    }

    this.openbox = currentopenbox;
    if (openbox != null) {
      print("infunction : ${this.openbox.docid}");
      print("motor place : ${this.openbox.docid}");
      DocumentSnapshot motorplacedoc = await Datamanager.firestore
          .collection("placelocation")
          .document(this.openbox.motorplaceloc)
          .get();
      this.openboxmotorplace = Placelocation(
          latitude: motorplacedoc['latitude'],
          longitude: motorplacedoc['longitude'],
          name: motorplacedoc['name'],
          universityname: motorplacedoc['universityname']);

      DocumentSnapshot boxlocationdoc = await Datamanager.firestore
          .collection("boxlocation")
          .document(this.openbox.boxplacedocid)
          .get();
      this.openboxboxplace = Boxlocation(
        latitude: boxlocationdoc['latitude'],
        longitude: boxlocationdoc['longitude'],
        name: boxlocationdoc['name'],
        universityname: boxlocationdoc['universityname'],
      );
    } else {
      print("this.openbox is : null");
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
                  boxlocation: this.openboxboxplace,
                  placelocation: this.openboxmotorplace,
                )));

    print("data back is : ${message}");
  }

  Future navigatetoreceivebox() async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MotorDetailReceiveBox(
                  bookingdocid: this.receivebookdocid,
                  boxslotrent: this.receivebox,
                  motorcycle: this.motorcycle,
                  motorboxplace: this.receiveboxplace,
                  motorplaceloc: this.receivemotorplace,
                )));
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
      isbook: ds['isbook'],
      iswaiting: ds['iswaiting'],
      isworking: ds['isworking']
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
