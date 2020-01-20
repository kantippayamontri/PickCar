import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:pickcar/bloc/motorbooklist/motorbooklistevent.dart';
import 'package:pickcar/bloc/motorbooklist/motorbookliststate.dart';
import 'package:pickcar/datamanager.dart';
import 'package:pickcar/models/motorcycle.dart';
import 'package:pickcar/models/motorcyclebook.dart';

class MotorBookListBloc extends Bloc<MotorBookListEvent , MotorBookListState>{

  Motorcycle motorcycle;
  List<MotorcycleBook> motorcyclebooklist;
  MotorBookListBloc({@required this.motorcycle}){
    motorcyclebooklist = List<MotorcycleBook>();
  }

  @override
  // TODO: implement initialState
  MotorBookListState get initialState => MotorBookListStartState();

  @override
  Stream<MotorBookListState> mapEventToState(MotorBookListEvent event) async* {
    // TODO: implement mapEventToState

    if(event is MotorBookListLoadDataEvent){
      yield MotorBookListStartState();
      print("in MotorBookListLoadDataEvent");
      await loaddata();
    }
    
  }

  Future<Null> loaddata() async {
    QuerySnapshot queysnapshot = await Datamanager.firestore.collection("Booking").getDocuments();
    var list = queysnapshot.documents;
    list = list.where((doc) => (doc['motorcycledocid'] == this.motorcycle.firestoredocid)).toList();

    for(var doc in list){
      print(doc['motorcycledocid'] + " " + doc['time']);
  
    }


  }

}