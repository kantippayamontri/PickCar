import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:pickcar/bloc/motordetail/motordetailevent.dart';
import 'package:pickcar/bloc/motordetail/motordetailstate.dart';
import 'package:pickcar/datamanager.dart';
import 'package:pickcar/models/motorcycle.dart';

class MotorDetailBloc extends Bloc<MotorDetailEvent, MotorDetailState> {
  BuildContext context;
  String firestoredocid;
  Motorcycle motorcycle;

  MotorDetailBloc({@required this.context, @required this.firestoredocid});

  @override
  MotorDetailState get initialState => MotorDetailStartState();

  @override
  Stream<MotorDetailState> mapEventToState(MotorDetailEvent event) async* {
    if (event is MotorDetailLoadData) {
      yield MotorDetailStartState();
      print("start");
      await loadmotordata();
      yield MotorDetailShowdata(motorcycle: this.motorcycle);
    }
  }

  Future<void> loadmotordata() async {
    await Datamanager.firestore
        .collection("Motorcycle")
        .document(this.firestoredocid)
        .get()
        .then((doc) {
      this.motorcycle = motorsetdatatoobj(doc);
    });
  }

  Motorcycle motorsetdatatoobj(DocumentSnapshot doc) {
    Motorcycle motorcycle = Motorcycle(
      color: doc['color'],
      brand: doc['brand'],
      carstatus: doc['carstatus'],
      cc: doc['cc'],
      gear: doc['gear'],
      generation: doc['generation'],
      motorbacklink: doc['motorbacklink'],
      motorbackpath: doc['motorbackpath'],
      motorbacktype: doc['motorbacktype'],
      motorrightlink: doc['motorrightlink'],
      motorfrontlink: doc['motorfrontlink'],
      motorfrontpath: doc['motorfrontpath'],
      motorfronttype: doc['motorfronttype'],
      motorleftlink: doc['motorleftlink'],
      motorleftpath: doc['motorleftpath'],
      motorlefttype: doc['motorlefttype'],
      motorownerliscenselink: doc['motorownerliscenselink'],
      motorprofilelink: doc['motorprofilelink'],
      motorrightpath: doc['motorrightpath'],
      motorrighttype: doc['motorrighttype'],
      ownerliscensepath: doc['ownerliscensepath'],
      ownerliscensetype: doc['ownerliscensetype'],
      owneruid: doc['owneruid'],
      profilepath: doc['profilepath'],
      profiletype: doc['profiletype'],
      storagedocid: doc['storagedocid'],
    );

    motorcycle.firestoredocid = this.firestoredocid;

    return motorcycle;
  }
}
