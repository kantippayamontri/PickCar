import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ChooseCarType extends StatelessWidget {

  double height;
  double width;
  Function tap;
  String title;

  ChooseCarType({@required this.height , @required this.width , @required this.title , @required this.tap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
                onTap: tap,
                child: Container(
                  height: height * 0.3,
                  width: width * 0.9,
                  decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(title)
                      ],
                    ),
                  ),
                ),
              );
  }
}