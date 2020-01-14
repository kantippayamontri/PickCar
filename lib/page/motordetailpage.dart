import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickcar/bloc/motordetail/motordetailbloc.dart';
import 'package:pickcar/bloc/motordetail/motordetailevent.dart';
import 'package:pickcar/bloc/motordetail/motordetailstate.dart';
import 'package:pickcar/main.dart';
import 'package:pickcar/page/motorrentalformpage.dart';
import 'package:transparent_image/transparent_image.dart';

import '../datamanager.dart';

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
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  //todo profile
                  _container(MediaQuery.of(context).size.height * 0.3,
                      MediaQuery.of(context).size.width * 0.8, [
                    Flexible(
                      flex: 1,
                      child: Text(
                        UseString.profile,
                        style: _textstyle(),
                      ),
                    ),
                    Flexible(
                      flex: 3,
                      child: Stack(
                        children: <Widget>[
                          Center(
                            child: CircularProgressIndicator(),
                          ),
                          Center(
                            child: FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage,
                              image:
                                  _motorDetailBloc.motorcycle.motorprofilelink,
                              fit: BoxFit.fill,
                            ),
                          )
                        ],
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: 20,
                  ),
                  //todo corousel
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CarouselSlider(
                        height: MediaQuery.of(context).size.height * 0.3,
                        items: _motorDetailBloc.listcorousel.map((imgUrl){
                          return Builder(builder: (BuildContext ctx){
                            return Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              margin: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Image.network(imgUrl,fit: BoxFit.fill,),
                              );
                          },);
                        }).toList(),
                      )
                    ],
                  ),

                  //todo information
                  _container(MediaQuery.of(context).size.height * 0.5,
                      MediaQuery.of(context).size.width * 0.9, [
                    Text(
                      UseString.information,
                      style: _textstyle(),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(UseString.brand + " : "),
                            Text(_motorDetailBloc.motorcycle.brand)
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(UseString.cc + " : "),
                            Text(_motorDetailBloc.motorcycle.cc.toString()),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(UseString.gear),
                            Text(_motorDetailBloc.motorcycle.gear),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(UseString.color),
                            Text(_motorDetailBloc.motorcycle.color),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(UseString.generation + " : "),
                            Text(_motorDetailBloc.motorcycle.generation),
                          ],
                        ),
                      ],
                    )
                  ]),
                  _motorDetailBloc.motorcycle.iswaiting
                      ? RaisedButton(
                          child: Text("waitinglist"),
                          onPressed: () {},
                        )
                      : SizedBox(),
                  _motorDetailBloc.motorcycle.isbook
                      ? RaisedButton(
                          child: Text("isbooklist"),
                          onPressed: () {},
                        )
                      : SizedBox(),
                  _motorDetailBloc.motorcycle.isworking
                      ? RaisedButton(
                          child: Text("isworkinglist"),
                          onPressed: () {},
                        )
                      : SizedBox(),

                  /*Text("${state.motorcycle.carstatus}"),
                  Text("${state.motorcycle.firestoredocid}"),
                  RaisedButton(
                    child: Text("${state.motorcycle.firestoredocid}"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MotorRentalFormPage(motorcycle: _motorDetailBloc.motorcycle,)),
                      ).then((_){
                        print("in then in detailpage");
                        _motorDetailBloc.add(MotorDetailLoadData());
                      });
                    },
                  ),*/
                ],
              ),
            );
          }
        },
      ),
    ));
  }

  TextStyle _textstyle() {
    return TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      fontFamily: 'Pridi-Bold',
      color: PickCarColor.colormain,
    );
  }

  Widget _container(double height, double width, List<Widget> data) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.only(left: 10, top: 10, right: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, 15.0),
                blurRadius: 15.0),
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, -10.0),
                blurRadius: 10.0),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[...data],
      ),
    );
  }
}
