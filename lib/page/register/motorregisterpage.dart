import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:pickcar/bloc/registermotor/motorregisterbloc.dart';
import 'package:pickcar/bloc/registermotor/motorregisterevent.dart';

import '../../datamanager.dart';

class MotorRegisterPage extends StatefulWidget {
  @override
  _MotorRegisterPageState createState() => _MotorRegisterPageState();
}

class _MotorRegisterPageState extends State<MotorRegisterPage> {
  MotorRegisterBloc _motorregisterbloc;
  var motorprofile;
  var ownerliscense;

  void _motorprofilechange() {
    setState(() {
      motorprofile = _motorregisterbloc.motorprofile;
    });
  }

  void _ownerliscensechange(){
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
          child: Form(
            key: _motorregisterbloc.formkey,
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
                              height: MediaQuery.of(context).size.height * 0.35,
                              width: MediaQuery.of(context).size.width * 0.8,
                            )
                          : Image.file(
                              _motorregisterbloc.motorprofile,
                              height: MediaQuery.of(context).size.height * 0.35,
                              width: MediaQuery.of(context).size.width * 0.8,
                            ),
                    ],
                  ),
                  Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              side: BorderSide(color: PickCarColor.colormain)),
                          onPressed: () {
<<<<<<< HEAD
                            // _motorregisterbloc.add(ChangeMotorProfile(_motorprofilechange));
=======
                            _motorregisterbloc.add(ChangeMotorProfile(changeimg : _motorprofilechange));
>>>>>>> a03b381f1602e39144dc6ae15fe25c411376313f
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
                Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width * 0.9,
                    padding: EdgeInsets.fromLTRB(
                        0, MediaQuery.of(context).padding.top + 25, 0, 0),
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
                          controller: _motorregisterbloc.brandcontroller,
                          decoration: InputDecoration(
                              hintText: UseString.brand,
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 12)),
                          validator: (val) {
                            if (val.isEmpty) {
                              return UseString.brandval;
                            }
                          },
                        )
                      ],
                    )),
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
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 12)),
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
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 12)),
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
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 12)),
                    validator: (val) {
                      if (val.isEmpty) {
                        return UseString.colorval;
                      }
                    },
                  )
                ]),
                SizedBox(
                  height: 200,
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
                              height: MediaQuery.of(context).size.height * 0.35,
                              width: MediaQuery.of(context).size.width * 0.8,
                            )
                          : Image.file(
                              _motorregisterbloc.ownerliscense,
                              height: MediaQuery.of(context).size.height * 0.35,
                              width: MediaQuery.of(context).size.width * 0.8,
                            ),
                    ],
                  ),
                  Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              side: BorderSide(color: PickCarColor.colormain)),
                          onPressed: () {
                            _motorregisterbloc.add(ChangeOwnerLiscense(changeimg: _ownerliscensechange));
                          },
                          color: PickCarColor.colormain,
                          textColor: Colors.white,
                          child: Text("Change"),
                        ),
                      ),
                    )
                ]),
                RaisedButton(
                  onPressed: () {
                    final form = _motorregisterbloc.formkey.currentState;
                    if (form.validate()) {
                      print("register Motor Success");
                    }
                  },
                )
              ],
            ),
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
}
