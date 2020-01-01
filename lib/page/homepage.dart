import 'package:flutter/material.dart';
import 'package:pickcar/datamanager.dart';
import 'package:pickcar/widget/home/cardrental.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AppBar appbar;

  @override
  void initState() {
    // TODO: implement initState
    appbar = AppBar();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void _gotorental() {
      Navigator.of(context).pushNamed(Datamanager.rentalpage);
    }

    void _gotoregister(){
      Navigator.of(context).pushNamed(Datamanager.registerpage);
    }
    return Scaffold(
        appBar: appbar,
        body: Container(
          // margin: EdgeInsets.fromLTRB(0, appbar.preferredSize.height + MediaQuery.of(context).padding.top, 0, 0),
          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CardRental(
                      height: constraints.maxHeight,
                      width: constraints.maxWidth,
                      title: UseString.rentaltitle,
                      buttontext: UseString.rentalbutton,
                      tap: _gotorental,
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.1,
                    ),
                    CardRental(
                      height: constraints.maxHeight,
                      width: constraints.maxWidth,
                      title: UseString.registertitle,
                      buttontext: UseString.registerbutton,
                      tap: _gotoregister,
                    ),
                  ],
                ),
              );
            },
          ),
        ));
  }
}
