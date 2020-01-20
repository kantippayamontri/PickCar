import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickcar/arguments.dart';
import 'package:pickcar/bloc/motorbooklist/motorbooklistbloc.dart';
import 'package:pickcar/bloc/motorbooklist/motorbooklistevent.dart';
import 'package:pickcar/bloc/motorbooklist/motorbookliststate.dart';
import 'package:pickcar/models/motorcycle.dart';

class MotorBookListPage extends StatefulWidget {
  @override
  _MotorBookListPageState createState() => _MotorBookListPageState();
}

class _MotorBookListPageState extends State<MotorBookListPage> {
  @override
  void initState() {
    // TODO: implement initState
    print("initstate");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("in build");

    final MotorBookListArguments argument =
        ModalRoute.of(context).settings.arguments;
    MotorBookListBloc _motorBookListBloc =
        MotorBookListBloc(motorcycle: argument.motorcycle);
    _motorBookListBloc.add(MotorBookListLoadDataEvent());

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height -
            MediaQuery.of(context).padding.top -
            MediaQuery.of(context).viewInsets.bottom,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: BlocBuilder(
          bloc: _motorBookListBloc,
          builder: (ctx, state) {
            if (state is MotorBookListStartState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is MotorBookLisShowDatatState) {
              return Center(
                child: Text("Load Data"),
              );
            }
          },
        ),
      ),
    );
  }
}
