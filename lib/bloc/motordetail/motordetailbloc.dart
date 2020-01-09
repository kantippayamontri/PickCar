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
  // TODO: implement initialState
  MotorDetailState get initialState => MotorDetailStartState();

  @override
  Stream<MotorDetailState> mapEventToState(MotorDetailEvent event) async* {
    // TODO: implement mapEventToState
    if (event is MotorDetailLoadData) {
      yield MotorDetailStartState();
      await loaddata();
      yield MotorDetailShowdata(motorcycle: this.motorcycle);
    }
  }

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
    Motorcycle motor =  Motorcycle(
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
    );

    motor.firestoredocid = ds['firestoredocid'];

    print("endtdfasdfadsfasdfas");

    return motor;
  }
}
