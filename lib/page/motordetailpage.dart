import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickcar/bloc/motordetail/motordetailbloc.dart';
import 'package:pickcar/bloc/motordetail/motordetailevent.dart';
import 'package:pickcar/bloc/motordetail/motordetailstate.dart';
import 'package:pickcar/main.dart';
import 'package:pickcar/page/motorrentalformpage.dart';
import 'package:transparent_image/transparent_image.dart';

import '../arguments.dart';
import '../datamanager.dart';
import 'motorwaitinglistpage.dart';

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

  void setstate() {
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    print("motor firestore docid ; ${widget.motordocid}");
    _motorDetailBloc = MotorDetailBloc(
        context: context,
        firestoredocid: widget.motordocid,
        setstate: setstate);
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
                                image: _motorDetailBloc
                                    .motorcycle.motorprofilelink,
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
                    _container(MediaQuery.of(context).size.height * 0.35,
                        MediaQuery.of(context).size.width * 0.8, [
                      Text(
                        UseString.aroundmotorcycle,
                        style: _textstyle(),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          CarouselSlider(
                            height: MediaQuery.of(context).size.height * 0.275,
                            items: _motorDetailBloc.listcorousel.map((imgUrl) {
                              return Builder(
                                builder: (BuildContext ctx) {
                                  return Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10.0),
                                    child: Image.network(
                                      imgUrl,
                                      fit: BoxFit.fill,
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                          )
                        ],
                      ),
                    ]),

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
                        ? ButtonTheme(
                            height: MediaQuery.of(context).size.height * 0.1,
                            minWidth: MediaQuery.of(context).size.width * 0.5,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.white)),
                              color: Colors.yellow,
                              child: Text("waitinglist",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 24)),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MotorWaitingListPage(
                                              motorcycle: this
                                                  ._motorDetailBloc
                                                  .motorcycle,
                                            )));
                              },
                            ),
                          )
                        : SizedBox(
                            width: 0,
                          ),
                          SizedBox(height: 20,),
                    _motorDetailBloc.motorcycle.isbook ||
                            _motorDetailBloc.motorcycle.isworking
                        ? ButtonTheme(
                            height: MediaQuery.of(context).size.height * 0.1,
                            minWidth: MediaQuery.of(context).size.width * 0.5,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.white)),
                              child: Text("isbooklist",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 24)),
                              onPressed: () async {
                                await Navigator.pushNamed(
                                    context, Datamanager.motorbooklistpage,
                                    arguments: MotorBookListArguments(
                                        motorcycle:
                                            _motorDetailBloc.motorcycle));
                              },
                            ),
                          )
                        : SizedBox(
                            width: 0,
                          ),
                          SizedBox(height: 20,),
                    // _motorDetailBloc.motorcycle.isworking
                    //     ? RaisedButton(
                    //         child: Text("isworkinglist"),
                    //         onPressed: () {},
                    //       )
                    //     : SizedBox(
                    //         width: 0,
                    //       ),

                    // Text("${state.motorcycle.carstatus}"),
                    //Text("${state.motorcycle.firestoredocid}"),
                    ButtonTheme(
                      height: MediaQuery.of(context).size.height * 0.1,
                      minWidth: MediaQuery.of(context).size.width * 0.5,
                      child: RaisedButton(
                        color: PickCarColor.colormain,
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.white)),
                        child: Text(
                          "Rental Car",
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MotorRentalFormPage(
                                      motorcycle: _motorDetailBloc.motorcycle,
                                    )),
                          ).then((_) {
                            print("in then in detailpage");
                            _motorDetailBloc.add(MotorDetailLoadData());
                          });
                        },
                      ),
                    ),

                    /*RaisedButton(
                      child: Text("realtime database"),
                      onPressed: () async {
                        await Datamanager.realtimedatabase
                            .reference()
                            .child('firsttest')
                            .update({'status': false});
                        await Datamanager.realtimedatabase
                            .reference()
                            .child('firsttest')
                            .once()
                            .then((DataSnapshot doc) {
                             Map<dynamic , dynamic> result = doc.value;
                             print("data is ${result['status']}");
                            });
                      },
                    ),*/
                  ],
                ),
              );
            }
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            _motorDetailBloc.openbox != null
                ? FloatingActionButton(
                    heroTag: "dropkey",
                    onPressed: () async {
                      print('press key box ja');
                      await _motorDetailBloc.navigatetoopenbox();
                      _motorDetailBloc.add(MotorDetailLoadData());
                    },
                    child: Icon(Icons.vpn_key),
                    backgroundColor: PickCarColor.colormain,
                  )
                : SizedBox(),
            SizedBox(
              height: 20,
            ),
            _motorDetailBloc.receivebox != null
                ? FloatingActionButton(
                    heroTag: "recievekey",
                    onPressed: () {
                      print('press recieve key ja');
                      //_motorDetailBloc.navigatetoopenbox();
                      _motorDetailBloc.navigatetoreceivebox();
                    },
                    child: Icon(Icons.vpn_key),
                    backgroundColor: Colors.yellow,
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
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
