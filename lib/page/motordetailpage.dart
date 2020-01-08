import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickcar/bloc/motordetail/motordetailbloc.dart';
import 'package:pickcar/bloc/motordetail/motordetailevent.dart';
import 'package:pickcar/bloc/motordetail/motordetailstate.dart';
import 'package:pickcar/main.dart';
import 'package:pickcar/page/rental/motorrentaldefindpage.dart';

class MotorDetailPage extends StatefulWidget {
  String motordocid;
  MotorDetailPage({@required this.motordocid}) {
    print("MotorDetailPage motordocid : ${motordocid}");
  }
  @override
  _MotorDetailPageState createState() => _MotorDetailPageState();
}

class _MotorDetailPageState extends State<MotorDetailPage> {
  MotorDetailBloc _motorDetailBloc;

  @override
  void initState() {
    // TODO: implement initState
    print("motor firestore docid ; ${widget.motordocid}");
    _motorDetailBloc =
        MotorDetailBloc(context: context, firestoredocid: widget.motordocid);
    _motorDetailBloc.add(MotorDetailLoadData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height -
          MediaQuery.of(context).padding.top,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: BlocBuilder(
        bloc: _motorDetailBloc,
        builder: (BuildContext context, state) {
          if (state is MotorDetailStartState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is MotorDetailShowdata) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("${state.motorcycle.carstatus}"),
                  RaisedButton(
                    child: Text("${state.motorcycle.firestoredocid}"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MotorRentalDefindPage(
                                motorcycle: _motorDetailBloc.motorcycle)),
                      );
                    },
                  ),
                ],
              ),
            );
          }
        },
      ),
    ));
  }
}
