import 'package:flutter/material.dart';
import 'package:pickcar/datamanager.dart';
import 'package:pickcar/widget/register/choosecartype.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  AppBar appbar;

  @override
  void initState() {
    // TODO: implement initState
    appbar = AppBar();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void _gotomotorcycle() {
      Navigator.of(context).pushNamed(Datamanager.motorregisterpage);
    }

    void _gotocar() {
      Navigator.of(context).pushNamed(Datamanager.carregisterpage);
    }

    return Scaffold(
      appBar: appbar,
      body: Center(
        child: LayoutBuilder(builder: (context, constraints) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ChooseCarType(
                  height: constraints.maxHeight,
                  width: constraints.maxWidth,
                  title: UseString.motorcycle,
                  tap: _gotomotorcycle),
              SizedBox(
                height: constraints.maxHeight * 0.1,
              ),
              ChooseCarType(
                  height: constraints.maxHeight,
                  width: constraints.maxWidth,
                  title: UseString.car,
                  tap: _gotocar),
            ],
          );
        }),
      ),
    );
  }
}
