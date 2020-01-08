import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:pickcar/bloc/motorrentaldefind/motorrentaldefindevent.dart';
import 'package:pickcar/bloc/motorrentaldefind/motorrentaldefindstate.dart';

class MotorRentalDefindBloc extends Bloc<MotorRentalDefindEvent , MotorRentalDefindState>{

  BuildContext context;
  MotorRentalDefindBloc({@required this.context});
  
  @override
  MotorRentalDefindState get initialState => MotorRentalDefindStartState();

  @override
  Stream<MotorRentalDefindState> mapEventToState(MotorRentalDefindEvent event) async* {
    
    if(event is MotorRentalDefindLoadDataEvent){

      yield MotorRentalDefindStartState();
      yield MotorRentalDefindShowDataState();

    }
  }
  
}