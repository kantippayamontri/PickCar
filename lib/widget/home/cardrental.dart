import 'package:flutter/material.dart';

import '../../datamanager.dart';

class CardRental extends StatelessWidget {
  double height;
  double width;
  String title;
  String buttontext;
  Function tap;

  CardRental(
      {@required this.height,
      @required this.width,
      @required this.title,
      @required this.buttontext,
      @required this.tap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tap,
      child: Container(
        padding: EdgeInsets.all(15),
        height: height * 0.3,
        width: width * 0.9,
        decoration: BoxDecoration(
            color: Colors.yellow,
            borderRadius: BorderRadius.all(Radius.circular(25))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            Container(
              height: height * 0.1,
              width: width * 0.6,
              decoration: BoxDecoration(
                  color: PickCarColor.colormain,
                  borderRadius: BorderRadius.circular(45),
                  gradient: LinearGradient(colors: [
                    PickCarColor.colormain.withOpacity(0.5),
                    PickCarColor.colormain
                  ], begin: Alignment.centerLeft, end: Alignment.centerRight)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    buttontext,
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
