import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

import '../datamanager.dart';

class PickCarLogin extends StatefulWidget {
  Function summitdata;
  TextEditingController emailctrl;
  TextEditingController passctrl;
  GlobalKey<FormState> formkey;
  PickCarLogin(this.emailctrl, this.passctrl, this.summitdata, this.formkey);
  @override
  _PickCarLoginState createState() => _PickCarLoginState();
}

class _PickCarLoginState extends State<PickCarLogin> {
  //var email;
  //var password;

  TextStyle _textstyle() {
    return TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      fontFamily: 'Pridi-Bold',
      color: PickCarColor.colormain,
    );
  }

  @override
  Widget build(BuildContext context) {
    // return Row(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: <Widget>[
    //     Container(
    //       width: MediaQuery.of(context).size.width * 0.9,
    //       height: MediaQuery.of(context).size.height * 0.45,
    //       decoration: BoxDecoration(
    //           color: Colors.white,
    //           borderRadius: BorderRadius.circular(8.0),
    //           boxShadow: [
    //             BoxShadow(
    //                 color: Colors.black12,
    //                 offset: Offset(0.0, 15.0),
    //                 blurRadius: 15.0),
    //             BoxShadow(
    //                 color: Colors.black12,
    //                 offset: Offset(0.0, -10.0),
    //                 blurRadius: 10.0),
    //           ]),
    //       child: Padding(
    //         padding: const EdgeInsets.all(16.0),
    //         child: Form(
    //           key: widget.formkey,
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: <Widget>[
    //               Text(
    //                 'Username',
    //                 style: _textstyle(),
    //               ),
    //               TextFormField(
    //                 controller: widget.emailctrl,
    //                 //onSaved: (val) => email = val,
    //                 decoration: InputDecoration(
    //                     hintText: 'Email',
    //                     hintStyle: TextStyle(color: Colors.grey, fontSize: 12)),
    //                 validator: (value) {
    //                   //print('email validate : $value');

    //                   if (value.isEmpty) {
    //                     return "Please Enter an email";
    //                   }

    //                   if (!EmailValidator.validate(value, true)) {
    //                     return "Email incorrect";
    //                   } else {
    //                     //print("email validator success");
    //                     return null;
    //                   }
    //                 },
    //               ),
    //               SizedBox(
    //                 height: 15,
    //               ),
    //               Text(
    //                 'Password',
    //                 style: _textstyle(),
    //               ),
    //               TextFormField(
    //                 controller: widget.passctrl,
    //                 obscureText: true,
    //                 keyboardType: TextInputType.visiblePassword,
    //                 //onSaved: (val) => password = val,
    //                 decoration: InputDecoration(
    //                     hintText: 'Password',
    //                     hintStyle: TextStyle(color: Colors.grey, fontSize: 12)),
    //                 validator: (value) {
    //                   // print("pass validate : $value");
    //                   if (value.isEmpty) {
    //                     return 'Please enter Passwaord';
    //                   } else {
    //                     return null;
    //                   }
    //                 },
    //               ),
    //               SizedBox(
    //                 height: 15,
    //               ),
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children: <Widget>[
    //                   Row(
    //                     children: <Widget>[
    //                       Checkbox(
    //                         value: true,
    //                         onChanged: (value) {},
    //                         checkColor: Colors.white,
    //                         activeColor: PickCarColor.colormain,
    //                       ),
    //                       Text(
    //                         'Remember me',
    //                         style: TextStyle(fontSize: 12, color: Colors.black),
    //                       )
    //                     ],
    //                   ),
    //                   ButtonTheme(
    //                     height: 75,
    //                     minWidth: 150,
    //                     child: GradientButton(
    //                       callback: () {
    //                         //print('email : ${widget.emailctrl.text}');
    //                         // print("pass : ${widget.passctrl.text}");
    //                         //widget.summitdata();
    //                         widget.summitdata();
    //                       },
    //                       gradient: LinearGradient(
    //                           colors: [
    //                             PickCarColor.colormain,
    //                             PickCarColor.colormain.withOpacity(0.7),
    //                             Colors.yellow
    //                           ],
    //                           begin: Alignment.topLeft,
    //                           end: Alignment.bottomRight),
    //                       shape: RoundedRectangleBorder(
    //                           borderRadius: BorderRadius.circular(16.0)),
    //                       child: Center(
    //                         child: Text(
    //                           'Sign In',
    //                           style: TextStyle(fontSize: 24),
    //                         ),
    //                       ),
    //                     ),
    //                   )
    //                 ],
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ),
    //   ],
    // );
    var data = MediaQuery.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          child: Form(
            key: widget.formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Text(
                    UseString.username,
                    style: _textstyle(),
                  ),
                ),
                Stack(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 5,right: 5),
                      width: data.size.width-10,
                      child: Image.asset('assets/images/imagelogin/textinput.png'),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 30,right: 30,top: 15),
                      width: data.size.width-60,
                      child: TextFormField(
                        controller: widget.emailctrl,
                        //onSaved: (val) => email = val,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText: UseString.emailhint,
                            hintStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*16,color: Colors.grey[400]),
                              ),
                        validator: (value) {
                          //print('email validate : $value');

                          if (value.isEmpty) {
                            return "Please Enter an email";
                          }

                          if (!EmailValidator.validate(value, true)) {
                            return "Email incorrect";
                          } else {
                            //print("email validator success");
                            return null;
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Text(
                    UseString.password,
                    style: _textstyle(),
                  ),
                ),
                Stack(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 5,right: 5),
                      width: data.size.width-10,
                      child: Image.asset('assets/images/imagelogin/textinput.png'),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 30,right: 30,top: 15),
                      width: data.size.width-60,
                      child: TextFormField(
                        controller: widget.passctrl,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        //onSaved: (val) => password = val,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText: UseString.passwordhint,
                            hintStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*16,color: Colors.grey[400]),
                              ),
                        validator: (value) {
                          // print("pass validate : $value");
                          if (value.isEmpty) {
                            return 'Please enter Passwaord';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                  ],
                ),
                // Text(
                //   'Password',
                //   style: _textstyle(),
                // ),
                // TextFormField(
                //   controller: widget.passctrl,
                //   obscureText: true,
                //   keyboardType: TextInputType.visiblePassword,
                //   //onSaved: (val) => password = val,
                //   decoration: InputDecoration(
                //       hintText: 'Password',
                //       hintStyle: TextStyle(color: Colors.grey, fontSize: 12)),
                  // validator: (value) {
                  //   // print("pass validate : $value");
                  //   if (value.isEmpty) {
                  //     return 'Please enter Passwaord';
                  //   } else {
                  //     return null;
                  //   }
                  // },
                // ),
                // SizedBox(
                //   height: 15,
                // ),
                Container(
                  margin: EdgeInsets.only(left: 20,right: 20),
                  child: Row(
                    children: <Widget>[
                      Checkbox(
                        value: true,
                        onChanged: (value) {},
                        checkColor: Colors.white,
                        activeColor: PickCarColor.colormain,
                      ),
                      Text(
                        UseString.remember,
                        style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*22,color: PickCarColor.colorFont1), 
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20,right: 20),
                  height: 60,
                  width: data.size.width - 40,
                  child: RaisedButton(
                    onPressed: (){
                      widget.summitdata();
                    },
                    // callback: () {
                    //   //print('email : ${widget.emailctrl.text}');
                    //   // print("pass : ${widget.passctrl.text}");
                    //   //widget.summitdata();
                    //   widget.summitdata();
                    // },
                    color: PickCarColor.colorbuttom,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0)),
                    child: Center(
                      child: Text(UseString.signin,
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*22,color: Colors.white), 
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
