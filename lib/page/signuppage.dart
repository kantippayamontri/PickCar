import 'dart:io';

import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:pickcar/bloc/signup/signupbloc.dart';
import 'package:pickcar/bloc/signup/signupevent.dart';
import 'package:pickcar/datamanager.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var _signupbloc;
  var profileimage;
  var idcardimage;
  var universitycardimage;
  var driverliscensemotorcycleimage;
  var driverliscensecarimage;

  @override
  void initState() {
    _signupbloc = SignUpBloc(context);
  }

  void _changeimgprofile() {
    setState(() {
      profileimage = _signupbloc.profileimage;
    });
  }

  void _changeimgdrimotor() {
    setState(() {
      driverliscensemotorcycleimage = _signupbloc.driverliscensemotorcycleimage;
    });
  }

  void _changeimgdricar() {
    setState(() {
      driverliscensecarimage = _signupbloc.driverliscensecarimage;
    });
  }

  void _changeimgidcard() {
    setState(() {
      idcardimage = _signupbloc.idcardimage;
    });
  }

  void _changeimguniversitycard() {
    setState(() {
      universitycardimage = _signupbloc.universityimage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
          child: Form(
        key: _signupbloc.formkey,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(
                  12, 25 + MediaQuery.of(context).padding.top, 12, 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _container(MediaQuery.of(context).size.height * 0.15,
                      MediaQuery.of(context).size.width * 0.9, [
                    Text(
                      UseString.email,
                      style: _textstyle(),
                    ),
                    TextFormField(
                      controller: _signupbloc.emailcontroller,
                      decoration: InputDecoration(
                        hintText: UseString.email,
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return UseString.emailtypeval;
                        }
                      },
                    )
                  ]),
                  SizedBox(
                    height: 20,
                  ),
                  _container(MediaQuery.of(context).size.height * 0.275,
                      MediaQuery.of(context).size.width * 0.9, [
                    Text(
                      UseString.password,
                      style: _textstyle(),
                    ),
                    TextFormField(
                      obscureText: true,
                      controller: _signupbloc.passwordcontroller,
                      decoration: InputDecoration(
                        hintText: UseString.password,
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return UseString.passwordtypeval;
                        }

                        if (value.length < 6) {
                          return UseString.passwordlenght;
                        }

                        if (!value.isEmpty &&
                            (_signupbloc.passwordcontroller.text !=
                                _signupbloc.confirmpasswordcontroller.text)) {
                          return UseString.passworddontsame;
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      UseString.confirmpassword,
                      style: _textstyle(),
                    ),
                    TextFormField(
                      obscureText: true,
                      controller: _signupbloc.confirmpasswordcontroller,
                      decoration: InputDecoration(
                        hintText: UseString.confirmpassword,
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return UseString.passwordtypeval;
                        }

                        if (value.length < 6) {
                          return UseString.passwordlenght;
                        }

                        if (!value.isEmpty &&
                            (_signupbloc.passwordcontroller.text !=
                                _signupbloc.confirmpasswordcontroller.text)) {
                          return UseString.passworddontsame;
                        }
                      },
                    )
                  ]),
                  SizedBox(
                    height: 20,
                  ),
                  _container(MediaQuery.of(context).size.height * 0.5,
                      MediaQuery.of(context).size.width * 0.9, [
                    Text(
                      UseString.profile,
                      style: _textstyle(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        profileimage == null
                            ? Image.asset(
                                "assets/images/user.png",
                                fit: BoxFit.contain,
                                height:
                                    MediaQuery.of(context).size.height * 0.35,
                                width: MediaQuery.of(context).size.width * 0.8,
                              )
                            : Image.file(
                                _signupbloc.profileimage,
                                height:
                                    MediaQuery.of(context).size.height * 0.35,
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
                            _signupbloc
                                .add(ChangeProfileImage(_changeimgprofile));
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
                  _namewidget(MediaQuery.of(context).size.height * 0.15,
                      MediaQuery.of(context).size.width * 0.9),
                  SizedBox(
                    height: 20,
                  ),
                  _container(MediaQuery.of(context).size.height * 0.15,
                      MediaQuery.of(context).size.width * 0.9, [
                    Text(
                      UseString.university,
                      style: _textstyle(),
                    ),
                    DropDownFormField(
                      titleText: null,
                      hintText: UseString.chooseuniversity,
                      value: _signupbloc.university,
                      onSaved: (val) {
                        setState(() {
                          _signupbloc.university = val;
                          print("onsave uni");
                        });
                      },
                      onChanged: (val) {
                        setState(() {
                          print("onchange uni val : $val");
                          _signupbloc.university = val;
                        });
                      },
                      dataSource: Datamanager.univeresity,
                      textField: "university",
                      valueField: "university",
                      validator: (val) {
                        if (val == null) {
                          return UseString.chooseuniversity;
                        }
                      },
                    ),
                  ]),
                  SizedBox(
                    height: 20,
                  ),
                  _container(MediaQuery.of(context).size.height * 0.15,
                      MediaQuery.of(context).size.width * 0.9, [
                    Text(
                      UseString.faculty,
                      style: _textstyle(),
                    ),
                    DropDownFormField(
                      titleText: null,
                      hintText: UseString.choosefaculty,
                      value: _signupbloc.faculty,
                      onSaved: (val) {
                        setState(() {
                          _signupbloc.faculty = val;
                        });
                      },
                      onChanged: (val) {
                        setState(() {
                          _signupbloc.faculty = val;
                        });
                      },
                      dataSource: Datamanager.faculty,
                      validator: (val) {
                        if (val == null) {
                          return UseString.choosefaculty;
                        }
                      },
                      textField: "faculty",
                      valueField: "faculty",
                    )
                  ]),
                  SizedBox(
                    height: 20,
                  ),
                  _container(MediaQuery.of(context).size.height * 0.15,
                      MediaQuery.of(context).size.width * 0.9, [
                    Text(
                      UseString.telnumber,
                      style: _textstyle(),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _signupbloc.telcontroller,
                      decoration: InputDecoration(
                        hintText: UseString.telnumber,
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return UseString.telnumberval;
                        }
                      },
                    )
                  ]),
                  SizedBox(
                    height: 20,
                  ),
                  _container(MediaQuery.of(context).size.height * 0.15,
                      MediaQuery.of(context).size.width * 0.9, [
                    Text(
                      UseString.address,
                      style: _textstyle(),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: _signupbloc.addresscontroller,
                      decoration: InputDecoration(
                        hintText: UseString.address,
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return UseString.addressval;
                        }
                      },
                    )
                  ]),
                  SizedBox(
                    height: 20,
                  ),
                  _container(MediaQuery.of(context).size.height * 0.5,
                      MediaQuery.of(context).size.width * 0.9, [
                    Text(
                      UseString.idcard,
                      style: _textstyle(),
                    ),
                    idcardimage == null
                        ? Image.asset(
                            "assets/images/user.png",
                            fit: BoxFit.contain,
                            height: MediaQuery.of(context).size.height * 0.35,
                            width: MediaQuery.of(context).size.width * 0.8,
                          )
                        : Image.file(
                            _signupbloc.idcardimage,
                            height: MediaQuery.of(context).size.height * 0.35,
                            width: MediaQuery.of(context).size.width * 0.8,
                          ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              side: BorderSide(color: PickCarColor.colormain)),
                          onPressed: () {
                            _signupbloc
                                .add(ChangeIDCardImage(_changeimgidcard));
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
                  //******************University********************** */
                  _container(MediaQuery.of(context).size.height * 0.5,
                      MediaQuery.of(context).size.width * 0.9, [
                    Text(
                      UseString.universitycard,
                      style: _textstyle(),
                    ),
                    universitycardimage == null
                        ? Image.asset(
                            "assets/images/user.png",
                            fit: BoxFit.contain,
                            height: MediaQuery.of(context).size.height * 0.35,
                            width: MediaQuery.of(context).size.width * 0.8,
                          )
                        : Image.file(
                            _signupbloc.universityimage,
                            height: MediaQuery.of(context).size.height * 0.35,
                            width: MediaQuery.of(context).size.width * 0.8,
                          ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              side: BorderSide(color: PickCarColor.colormain)),
                          onPressed: () {
                            _signupbloc.add(ChangeUniversityCardImage(
                                _changeimguniversitycard));
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
                  /********************Driver liscense Motorcycle************************* */
                  _container(MediaQuery.of(context).size.height * 0.5,
                      MediaQuery.of(context).size.width * 0.9, [
                    Text(
                      UseString.driverliscensemotorcycle,
                      style: _textstyle(),
                    ),
                    driverliscensemotorcycleimage == null
                        ? Image.asset(
                            "assets/images/user.png",
                            fit: BoxFit.contain,
                            height: MediaQuery.of(context).size.height * 0.35,
                            width: MediaQuery.of(context).size.width * 0.8,
                          )
                        : Image.file(
                            _signupbloc.driverliscensemotorcycleimage,
                            height: MediaQuery.of(context).size.height * 0.35,
                            width: MediaQuery.of(context).size.width * 0.8,
                          ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              side: BorderSide(color: PickCarColor.colormain)),
                          onPressed: () {
                            _signupbloc.add(ChangeDriMotor(_changeimgdrimotor));
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
                  /******************Driver liscense Car********************* */
                  _container(MediaQuery.of(context).size.height * 0.5,
                      MediaQuery.of(context).size.width * 0.9, [
                    Text(
                      UseString.driverliscensecarcycle,
                      style: _textstyle(),
                    ),
                    driverliscensecarimage == null
                        ? Image.asset(
                            "assets/images/user.png",
                            fit: BoxFit.contain,
                            height: MediaQuery.of(context).size.height * 0.35,
                            width: MediaQuery.of(context).size.width * 0.8,
                          )
                        : Image.file(
                            _signupbloc.driverliscensecarimage,
                            height: MediaQuery.of(context).size.height * 0.35,
                            width: MediaQuery.of(context).size.width * 0.8,
                          ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              side: BorderSide(color: PickCarColor.colormain)),
                          onPressed: () {
                            _signupbloc.add(ChangeDriCar(_changeimgdricar));
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
                  _signupbutton(context, _signupbloc.signupform),
                ],
              ),
            ),
          ],
        ),
      )),
    ));
  }

  Widget _signupbutton(BuildContext context, Function onclick) {
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

  Widget _namewidget(double height, double width) {
    return _container(height, width, [
      Text(
        UseString.name,
        style: _textstyle(),
      ),
      TextFormField(
        controller: _signupbloc.namecontroller,
        decoration: InputDecoration(
          hintText: UseString.name,
          hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
        ),
        validator: (value) {
          if (value.isEmpty) {
            return UseString.nameemptyval;
          }
        },
      )
    ]);
  }
}
