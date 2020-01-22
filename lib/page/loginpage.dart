import 'package:flutter/material.dart';
import 'package:pickcar/bloc/login/loginevent.dart';
import 'package:pickcar/datamanager.dart';
import 'package:pickcar/widget/login/signupbnt.dart';
import 'package:pickcar/widget/pickcar_login_widget.dart';
import '../bloc/login/loginbloc.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var username = '';
  var password = '';

  //todo initusername and pass
  
  

  final _scaffoldkey = GlobalKey<ScaffoldState>();
  var _showloginstatus = false;

  void _summitSingInEmail() {
    final form = loginbloc.formkey.currentState;
    if (form.validate()) {
      form.save();
      loginbloc.add(SignInwithEmailEvent(loginbloc.emailcontroller.text,
          loginbloc.passcontroller.text, _checkerrorsignin));
    }
  }

  void _checkerrorsignin() {
    setState(() {
      _showloginstatus = loginbloc.showloginstatus();
    });
  }

  void _signup(){
    print('press sign up ja');
    Navigator.of(context).pushNamed(Datamanager.signuppage);
  }


  @override
  Widget build(BuildContext context) {
    loginbloc.context = context;
    //todo test user
    loginbloc.emailcontroller.text = "f@f.com";
    loginbloc.passcontroller.text = "1111111";


    List<Widget> _titlewidget() {
      return [
        Text(
          'Welcome to',
          style: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            fontFamily: 'Pridi-Bold',
            color: PickCarColor.colormain,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'PickCar',
          style: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            fontFamily: 'Pridi-Bold',
            color: PickCarColor.colormain,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'The best way to make money. and make life\neasier from car.Let\'s get started! ',
          style: TextStyle(
              color: Colors.black, fontFamily: 'Pridi-Regular', fontSize: 18),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * (1 / 10.0),
        )
      ];
    }

    Widget _horizontalLine() {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.3,
          height: 1.0,
          color: Colors.black26.withOpacity(.2),
        ),
      );
    }

    return Scaffold(
      key: _scaffoldkey,
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20),
              ..._titlewidget(),
              _showloginstatus
                  ? loginbloc.signinsuccess
                      ? Container(
                          child: Text('Success'),
                        )
                      : Container(
                          child: Text('Fail to login'),
                        )
                  : SizedBox(height: 0,width: 0),
              PickCarLogin(loginbloc.emailcontroller, loginbloc.passcontroller,
                  _summitSingInEmail, loginbloc.formkey),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _horizontalLine(),
                  Text("CMU Login",
                      style: TextStyle(
                          fontSize: 16.0, fontFamily: "Poppins-Medium")),
                  _horizontalLine()
                ],
              ),
              SizedBox(
                height: 20,
              ),
              //CMULogin(),
              SignUpBtn(context , _signup)
            ],
          ),
        ),
      ),
    );
  }
}
