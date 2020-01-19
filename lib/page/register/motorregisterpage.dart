import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:pickcar/bloc/registermotor/motorregisterbloc.dart';
import 'package:pickcar/bloc/registermotor/motorregisterevent.dart';
import 'package:pickcar/bloc/registermotor/motorregisterstate.dart';

import '../../datamanager.dart';

class MotorRegisterPage extends StatefulWidget {
  @override
  _MotorRegisterPageState createState() => _MotorRegisterPageState();
}

class _MotorRegisterPageState extends State<MotorRegisterPage> {
  MotorRegisterBloc _motorregisterbloc;
  var motorprofile;
  var ownerliscense;
  var motorfront;
  var motorleft;
  var motorright;
  var motorback;


  void _motorbackpicchange() {
    setState(() {
      motorback = _motorregisterbloc.motorback;
    });
  }

  void _motorrightpicchange() {
    setState(() {
      motorright = _motorregisterbloc.motorrightside;
    });
  }

  void _motorleftpicchange() {
    setState(() {
      motorleft = _motorregisterbloc.motorleftside;
    });
  }

  void _motorfrontpicchange() {
    setState(() {
      motorfront = _motorregisterbloc.motorfront;
    });
  }

  void _motorprofilechange() {
    setState(() {
      motorprofile = _motorregisterbloc.motorprofile;
    });
  }

  void _ownerliscensechange() {
    setState(() {
      ownerliscense = _motorregisterbloc.ownerliscense;
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    _motorregisterbloc = MotorRegisterBloc(context);
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: BlocBuilder(
            bloc: _motorregisterbloc,
            builder: (ctx, state) {
              if (state is WaitingSubmitForm) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is StartState) {
                return Form(
                  key: _motorregisterbloc.formkey,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(
                        0, MediaQuery.of(context).padding.top, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        /********************************Motor Profile********************************************* */
                        _container(MediaQuery.of(context).size.height * 0.5,
                            MediaQuery.of(context).size.width * 0.9, [
                          Text(UseString.motorprofile),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              motorprofile == null
                                  ? Image.asset(
                                      "assets/images/user.png",
                                      fit: BoxFit.contain,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.35,
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                    )
                                  : Image.file(
                                      _motorregisterbloc.motorprofile,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.35,
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                    ),
                            ],
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    side: BorderSide(
                                        color: PickCarColor.colormain)),
                                onPressed: () {
                                  print("กดแล้ว");
                                  _motorregisterbloc.add(
                                      ChangeMotorProfile(_motorprofilechange));
                                  print("กดเสร็จแล้วแล้ว");
                                },
                                color: PickCarColor.colormain,
                                textColor: Colors.white,
                                child: Text("Change"),
                              ),
                            ),
                          )
                        ]),
                        SizedBox(
                          height: 20,
                        ),
                        /********************************Brand**************************************** */
                        _container(MediaQuery.of(context).size.height * 0.2,
                            MediaQuery.of(context).size.width * 0.9, [
                          Text(
                            UseString.brand,
                            style: _textstyle(),
                          ),
                          TextFormField(
                            controller: _motorregisterbloc.brandcontroller,
                            decoration: InputDecoration(
                                hintText: UseString.brand,
                                hintStyle: TextStyle(
                                    color: Colors.grey, fontSize: 12)),
                            validator: (val) {
                              if (val.isEmpty) {
                                return UseString.brandval;
                              }
                            },
                          )
                        ])
                        /*Container(
                            height: MediaQuery.of(context).size.height * 0.2,
                            width: MediaQuery.of(context).size.width * 0.9,
                            padding: EdgeInsets.fromLTRB(15,
                                MediaQuery.of(context).padding.top + 25, 15, 0),
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
                              children: <Widget>[
                                Text(
                                  UseString.brand,
                                  style: _textstyle(),
                                ),
                                TextFormField(
                                  controller:
                                      _motorregisterbloc.brandcontroller,
                                  decoration: InputDecoration(
                                      hintText: UseString.brand,
                                      hintStyle: TextStyle(
                                          color: Colors.grey, fontSize: 12)),
                                  validator: (val) {
                                    if (val.isEmpty) {
                                      return UseString.brandval;
                                    }
                                  },
                                )
                              ],
                            ))*/
                        ,
                        SizedBox(
                          height: 20,
                        ),
                        /**************************************generation************************************************ */
                        _container(MediaQuery.of(context).size.height * 0.2,
                            MediaQuery.of(context).size.width * 0.9, [
                          Text(
                            UseString.generation,
                            style: _textstyle(),
                          ),
                          TextFormField(
                            controller: _motorregisterbloc.generationcontroller,
                            decoration: InputDecoration(
                                hintText: UseString.generation,
                                hintStyle: TextStyle(
                                    color: Colors.grey, fontSize: 12)),
                            validator: (val) {
                              if (val.isEmpty) {
                                return UseString.generationval;
                              }
                            },
                          )
                        ]),
                        SizedBox(
                          height: 20,
                        ),
                        /**************************************CC******************************************* */
                        _container(MediaQuery.of(context).size.height * 0.2,
                            MediaQuery.of(context).size.width * 0.9, [
                          Text(
                            UseString.cc,
                            style: _textstyle(),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: _motorregisterbloc.cccontroller,
                            decoration: InputDecoration(
                                hintText: UseString.cc,
                                hintStyle: TextStyle(
                                    color: Colors.grey, fontSize: 12)),
                            validator: (val) {
                              if (val.isEmpty) {
                                return UseString.ccval;
                              }
                            },
                          )
                        ]),
                        SizedBox(
                          height: 20,
                        ),
                        /**************************************Gear************************************ */
                        _container(MediaQuery.of(context).size.height * 0.2,
                            MediaQuery.of(context).size.width * 0.9, [
                          Text(
                            UseString.gear,
                            style: _textstyle(),
                          ),
                          DropDownFormField(
                            titleText: null,
                            value: _motorregisterbloc.gear,
                            dataSource: GearMotor.gearmotormap,
                            textField: 'gear',
                            valueField: 'gear',
                            onSaved: (val) {
                              setState(() {
                                _motorregisterbloc.gear = val;
                              });
                            },
                            onChanged: (val) {
                              setState(() {
                                _motorregisterbloc.gear = val;
                              });
                            },
                            validator: (val) {
                              if (val == null) {
                                return UseString.gearval;
                              }
                            },
                          )
                        ]),
                        SizedBox(
                          height: 20,
                        ),
                        /***********************Color************************ */
                        _container(MediaQuery.of(context).size.height * 0.2,
                            MediaQuery.of(context).size.width * 0.9, [
                          Text(
                            UseString.color,
                            style: _textstyle(),
                          ),
                          TextFormField(
                            controller: _motorregisterbloc.colorcontroller,
                            decoration: InputDecoration(
                                hintText: UseString.colorval,
                                hintStyle: TextStyle(
                                    color: Colors.grey, fontSize: 12)),
                            validator: (val) {
                              if (val.isEmpty) {
                                return UseString.colorval;
                              }
                            },
                          )
                        ]),
                        SizedBox(
                          height: 20,
                        ),
                        /********************************LiscenPic********************************** */
                        _container(MediaQuery.of(context).size.height * 0.5,
                            MediaQuery.of(context).size.width * 0.9, [
                          Text(UseString.ownerliscense),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              ownerliscense == null
                                  ? Image.asset(
                                      "assets/images/user.png",
                                      fit: BoxFit.contain,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.35,
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                    )
                                  : Image.file(
                                      _motorregisterbloc.ownerliscense,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.35,
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                    ),
                            ],
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    side: BorderSide(
                                        color: PickCarColor.colormain)),
                                onPressed: () {
                                  _motorregisterbloc.add(ChangeOwnerLiscense(
                                      changeimg: _ownerliscensechange));
                                },
                                color: PickCarColor.colormain,
                                textColor: Colors.white,
                                child: Text("Change"),
                              ),
                            ),
                          )
                        ]),
                        SizedBox(height: 20,),
                        /***************************************front pic*************************************************** */
                        _container(MediaQuery.of(context).size.height * 0.5,
                            MediaQuery.of(context).size.width * 0.9, [
                          Text(UseString.motorfront),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              motorfront == null
                                  ? Image.asset(
                                      "assets/images/user.png",
                                      fit: BoxFit.contain,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.35,
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                    )
                                  : Image.file(
                                      _motorregisterbloc.motorfront,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.35,
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                    ),
                            ],
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    side: BorderSide(
                                        color: PickCarColor.colormain)),
                                onPressed: () {
                                  _motorregisterbloc.add(ChangeMotorFrontPic(
                                      changeimg: _motorfrontpicchange));
                                },
                                color: PickCarColor.colormain,
                                textColor: Colors.white,
                                child: Text("Change"),
                              ),
                            ),
                          )
                        ]),
                        SizedBox(
                          height: 20,
                        ),

                        /**************************leftpci************************************* */
                        //TODO left pic motor
                        _container(MediaQuery.of(context).size.height * 0.5,
                            MediaQuery.of(context).size.width * 0.9, [
                          Text(UseString.motorleft),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              motorleft == null
                                  ? Image.asset(
                                      "assets/images/user.png",
                                      fit: BoxFit.contain,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.35,
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                    )
                                  : Image.file(
                                      _motorregisterbloc.motorleftside,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.35,
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                    ),
                            ],
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    side: BorderSide(
                                        color: PickCarColor.colormain)),
                                onPressed: () {
                                  _motorregisterbloc.add(ChangeMotorLeftPic(
                                      changeimg: _motorleftpicchange));
                                },
                                color: PickCarColor.colormain,
                                textColor: Colors.white,
                                child: Text("Change"),
                              ),
                            ),
                          )
                        ]),
                        SizedBox(height: 20,),

                        //TODO Right Pic
                        _container(MediaQuery.of(context).size.height * 0.5,
                            MediaQuery.of(context).size.width * 0.9, [
                          Text(UseString.motorright),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              motorright == null
                                  ? Image.asset(
                                      "assets/images/user.png",
                                      fit: BoxFit.contain,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.35,
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                    )
                                  : Image.file(
                                      _motorregisterbloc.motorrightside,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.35,
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                    ),
                            ],
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    side: BorderSide(
                                        color: PickCarColor.colormain)),
                                onPressed: () {
                                  _motorregisterbloc.add(ChangeMotorRightPic(
                                      changeimg: _motorrightpicchange));
                                },
                                color: PickCarColor.colormain,
                                textColor: Colors.white,
                                child: Text("Change"),
                              ),
                            ),
                          )
                        ]),
                        SizedBox(
                          height: 20,
                        ),
                        //TODO Back pic
                        _container(MediaQuery.of(context).size.height * 0.5,
                            MediaQuery.of(context).size.width * 0.9, [
                          Text(UseString.motorback),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              motorback == null
                                  ? Image.asset(
                                      "assets/images/user.png",
                                      fit: BoxFit.contain,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.35,
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                    )
                                  : Image.file(
                                      _motorregisterbloc.motorback,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.35,
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                    ),
                            ],
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    side: BorderSide(
                                        color: PickCarColor.colormain)),
                                onPressed: () {
                                  _motorregisterbloc.add(ChangeMotorBackPic(
                                      changeimg: _motorbackpicchange));
                                },
                                color: PickCarColor.colormain,
                                textColor: Colors.white,
                                child: Text("Change"),
                              ),
                            ),
                          )
                        ]),
                        SizedBox(
                          height: 20,
                        ),
                        _registermotorbutton(context, () {
                          _motorregisterbloc.add(MotorSubmitForm());
                        }),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                );
              }
            },
          ),
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

  Widget _container(double height, double width, List<Widget> wg) {
    return Container(
        height: height,
        width: width,
        padding: EdgeInsets.all(15),
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
          children: <Widget>[...wg],
        ));
  }

  Widget _registermotorbutton(BuildContext context, Function onclick) {
    return ButtonTheme(
      height: 75,
      minWidth: MediaQuery.of(context).size.width * 0.9,
      child: GradientButton(
        elevation: 5,
        callback: () {
          onclick();
        },
        gradient: LinearGradient(colors: [
          PickCarColor.colormain,
          PickCarColor.colormain.withOpacity(0.7),
          Colors.yellow
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        child: Center(
          child: Text(
            UseString.signup,
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
