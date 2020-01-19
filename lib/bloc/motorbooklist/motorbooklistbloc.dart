import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:pickcar/bloc/motorbooklist/motorbooklistevent.dart';
import 'package:pickcar/bloc/motorbooklist/motorbookliststate.dart';
import 'package:pickcar/models/motorcycle.dart';

class MotorBookListBloc extends Bloc<MotorBookListEvent , MotorBookListState>{

  Motorcycle motorcycle;

  MotorBookListBloc({@required this.motorcycle});

  @override
  // TODO: implement initialState
  MotorBookListState get initialState => MotorBookListStartState();

  @override
  Stream<MotorBookListState> mapEventToState(MotorBookListEvent event) async* {
    // TODO: implement mapEventToState
    
  }

}