import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickcar/bloc/listcar/listcarbloc.dart';
import 'package:pickcar/bloc/listcar/listcarevent.dart';
import 'package:pickcar/bloc/listcar/listcarstate.dart';
import 'package:pickcar/widget/listcar/listcatitem.dart';

class Registercarlist extends StatefulWidget {
  @override
  _RegistercarlistState createState() => _RegistercarlistState();
}

class _RegistercarlistState extends State<Registercarlist> {
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
    //print("in Registercarlist eieieieieieiei");
    _listCarBloc.looptime();
    return Scaffold(
        body: Container(
      height: 500,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
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
                child: Text("You don't register car"),
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
