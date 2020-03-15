import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:pickcar/bloc/listcar/listcarevent.dart';
import 'package:pickcar/bloc/listcar/listcarstate.dart';
import 'package:pickcar/models/motorcycle.dart';

import '../../datamanager.dart';

class ListCarBloc extends Bloc<ListCarEvent, ListCarState> {
  BuildContext context;
  List<Motorcycle> motorcyclelist;

  ListCarBloc({@required this.context}) {
    motorcyclelist = List<Motorcycle>();
  }

  @override
  ListCarState get initialState => ListCarStartState();

  @override
  Stream<ListCarState> mapEventToState(ListCarEvent event) async* {
    if (event is ListCarLoadingDataEvent) {
      yield ListCarStartState();
      print("Loading data list car naja");
      loadingmotordata();
      yield ListCarShowData(motorcyclelist: motorcyclelist);
    }
  }


  void loadingmotordata() {
    Datamanager.firestore
        .collection('Motorcycle')
        .where("owneruid", isEqualTo: Datamanager.user.uid)
        .snapshots()
        .listen((data) {
      data.documents.forEach((doc) {
        // print("Motor doc id : ${doc['firestoredocid']}");

        Motorcycle motor = Motorcycle(
          carstatus: doc['carstatus'],
          brand: doc['brand'],
          cc: int.parse(doc['cc'].toString()),
          color: doc['color'],
          gear: doc['gear'],
          generation: doc['generation'],
          owneruid: doc['owneruid'],
          storagedocid: doc['storagedocid'],
          profilepath: doc['profilepath'],
          profiletype: doc['profiletype'],
          motorprofilelink: doc['motorprofilelink'],
          ownerliscensepath: doc['ownerliscensepath'],
          ownerliscensetype: doc['ownerliscensetype'],
          motorownerliscenselink: doc['motorownerliscenselink'],
          motorfrontpath: doc['motorfrontpath'],
          motorfronttype: doc['motorfronttype'],
          motorfrontlink: doc['motorfrontlink'],
          motorbackpath: doc['motorbackpath'],
          motorbacktype: doc['motorbacktype'],
          motorbacklink: doc['motorbacklink'],
          motorleftpath: doc['motorleftpath'],
          motorlefttype: doc['motorlefttype'],
          motorleftlink: doc['motorleftlink'],
          motorrightpath: doc['motorrightpath'],
          motorrighttype: doc['motorrighttype'],
          motorrightlink: doc['motorrightlink'],
          currentlatitude: doc['currentlatitude'],
          currentlongitude: doc['currentlatitude'],
          isworking:doc['isworking'],
          iswaiting:doc['iswaiting'],
          isbook:doc['isbook'],
        );
        motor.firestoredocid = doc['firestoredocid'];
        motorcyclelist.add(motor);
      });
    });

    print("finish load datanaja");
  }
}
