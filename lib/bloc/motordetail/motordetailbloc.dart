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
  List<String> listcorousel;
  MotorDetailBloc({@required this.context, @required this.firestoredocid}){
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
