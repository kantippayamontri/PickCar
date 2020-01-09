import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickcar/bloc/listcar/listcarbloc.dart';
import 'package:pickcar/bloc/listcar/listcarevent.dart';
import 'package:pickcar/bloc/listcar/listcarstate.dart';
import 'package:pickcar/models/motorcycle.dart';

class ListCarPage extends StatefulWidget {
  @override
  _ListCarPageState createState() => _ListCarPageState();
}

class _ListCarPageState extends State<ListCarPage> {
  ListCarBloc _listCarBloc;

  @override
  void initState() {
    // TODO: implement initState
    _listCarBloc = ListCarBloc(context: this.context);
    _listCarBloc.add(ListCarLoadingDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height -
          MediaQuery.of(context).padding.top,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.fromLTRB(0, MediaQuery.of(context).padding.top, 0, 0),
      child: BlocBuilder(
        bloc: _listCarBloc,
        builder: (ctx, state) {
          if (state is ListCarStartState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is ListCarShowData) {
            if (_listCarBloc.motorcyclelist.isEmpty) {
              return Center(
                child: Text("Dont have data"),
              );
            } else {
              return LayoutBuilder(
                builder: (layoutcintext, constrant) {
                  return ListView(
                      children: _listCarBloc.motorcyclelist
                          .map((motor) => Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  ListCarItem(
                                    key: ValueKey(motor.firestoredocid),
                                    constrant: constrant,
                                    motor: motor,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  )
                                ],
                              ))
                          .toList());
                },
              );
            }
          }
        },
      ),
    ));
  }
}
