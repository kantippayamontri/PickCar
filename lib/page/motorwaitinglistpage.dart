import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:pickcar/bloc/motorwaitinglist/motorwaitinglistbloc.dart';
import 'package:pickcar/bloc/motorwaitinglist/motorwaitinglistevent.dart';
import 'package:pickcar/bloc/motorwaitinglist/motorwaitingliststate.dart';
import 'package:pickcar/datamanager.dart';
import 'package:pickcar/models/motorcycle.dart';
import 'package:transparent_image/transparent_image.dart';

class MotorWaitingListPage extends StatefulWidget {
  Motorcycle motorcycle;
  MotorWaitingListPage({@required this.motorcycle});

  @override
  _MotorWaitingListPageState createState() => _MotorWaitingListPageState();
}

class _MotorWaitingListPageState extends State<MotorWaitingListPage> {
  MotorWaitingListBloc _motorWaitingListBloc;
  @override
  void initState() {
    // TODO: implement initState
    this._motorWaitingListBloc = MotorWaitingListBloc(
        context: this.context, motorcycle: widget.motorcycle);
    _motorWaitingListBloc.add(MotorWaitingListLoadDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          // color: Colors.green,
          height: MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: BlocBuilder(
            bloc: _motorWaitingListBloc,
            builder: (BuildContext ctx, state) {
              if (state is MotorWaitingLoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is MotorWaitingShowDataState) {
                return LayoutBuilder(
                  builder: (ctx, constraint) {
                    return Center(
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        elevation: 20,
                        child: Stack(
                          children: [
                            Container(
                              height: constraint.maxHeight * 0.275,
                              width: constraint.maxWidth * 0.9,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  color: Colors.yellow),
                            ),
                            Container(
                              height: constraint.maxHeight * 0.25,
                              width: constraint.maxWidth * 0.85,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white),
                              padding: EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Flexible(
                                    flex: 1,
                                    child: Stack(
                                      children: <Widget>[
                                        Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: FadeInImage.memoryNetwork(
                                            placeholder: kTransparentImage,
                                            image: _motorWaitingListBloc
                                                .motorcycle.motorprofilelink,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Flexible(
                                      flex: 3,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          FittedBox(
                                            fit: BoxFit.contain,
                                            child: Text(_motorWaitingListBloc
                                                    .motorcycle.brand +
                                                " " +
                                                _motorWaitingListBloc
                                                    .motorcycle.generation),
                                          ),
                                          Text(UseString.price +
                                              " : " +
                                              _motorWaitingListBloc
                                                  .motorcycletimeslotlist[0]
                                                  .prize
                                                  .toString()),
                                          Text(UseString.time +
                                              " : " +
                                              _motorWaitingListBloc
                                                  .motorcycletimeslotlist[0]
                                                  .timeslot),
                                          Text(UseString.date +
                                              " : " +
                                              Jiffy([
                                                _motorWaitingListBloc
                                                    .motorcycletimeslotlist[0]
                                                    .year,
                                                _motorWaitingListBloc
                                                    .motorcycletimeslotlist[0]
                                                    .month,
                                                _motorWaitingListBloc
                                                    .motorcycletimeslotlist[0]
                                                    .day
                                              ]).format("MMM do yy")),
                                        ],
                                      )),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              }

              return SizedBox();
            },
          )),
    );
  }
}
