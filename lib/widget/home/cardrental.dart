import 'package:flutter/material.dart';

import '../../datamanager.dart';

class CardRental extends StatelessWidget {
  double height;
  double width;
  String title;
  String imageurl;
  String buttontext;
  Function tap;

  CardRental(
      {@required this.height,
      @required this.width,
      @required this.title,
      @required this.buttontext,
      @required this.imageurl,
      @required this.tap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tap,
      child: Container(
        padding: EdgeInsets.all(15),
        height: height * 0.4,
        width: width * 0.95,
        decoration: BoxDecoration(
            // color: Colors.yellow,
            // borderRadius: BorderRadius.all(Radius.circular(25))
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(imageurl),
            ), 
          ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(fontSize: 20, color: PickCarColor.colorFont1),
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
                    style: TextStyle(fontSize: 23, color: Colors.white),
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
