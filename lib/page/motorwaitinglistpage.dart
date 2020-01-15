import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickcar/bloc/motorwaitinglist/motorwaitinglistbloc.dart';
import 'package:pickcar/bloc/motorwaitinglist/motorwaitinglistevent.dart';
import 'package:pickcar/bloc/motorwaitinglist/motorwaitingliststate.dart';
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
                      child: Container(
                        height: constraint.maxHeight * 0.3,
                        width: constraint.maxWidth * 0.9,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 20,
                          child: Container(
                            height: constraint.maxHeight * 0.3,
                            width: constraint.maxWidth * 0.9,
                            padding: EdgeInsets.all(5),
                            child: Row(
                              children: <Widget>[
                                Flexible(
                                  flex: 1,
                                  child: Stack(
                                    children: <Widget>[
                                      Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                      Center(
                                        child: Padding(
                                          
                                          padding: const EdgeInsets.all(8.0),
                                          child: FadeInImage.memoryNetwork(
                                            placeholder: kTransparentImage,
                                            image: _motorWaitingListBloc
                                                .motorcycle.motorprofilelink,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Flexible(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      
                                    ],
                                    )
                                ),
                              ],
                            ),
                          ),
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
