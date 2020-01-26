import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:pickcar/models/motorcycle.dart';
import 'package:pickcar/models/motorcyclebook.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../datamanager.dart';

class MotorBookItem extends StatefulWidget {
  Motorcycle motorcycle;
  MotorcycleBook motorbook;
  MediaQueryData mediaQueryData;
 
  MotorBookItem({Key  key,@required this.motorcycle, @required this.motorbook , @required this.mediaQueryData}) : super(key : key) {}

  @override
  _MotorBookItemState createState() => _MotorBookItemState();
}

class _MotorBookItemState extends State<MotorBookItem> {

  Motorcycle _motorcycle;
  MotorcycleBook _motorcycleBook;
  MediaQueryData _mediaQueryData;

  @override
  void initState() {
    // TODO: implement initState

    _motorcycle = widget.motorcycle;
    _motorcycleBook = widget.motorbook;
    _mediaQueryData = widget.mediaQueryData;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      child: Container(
        height:_mediaQueryData.size.height * 0.3,
        width: _mediaQueryData.size.width * 0.9,
        padding: EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            Flexible(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: Stack(
                      children: <Widget>[
                        //Align(alignment: AlignmentDirectional.center,child: CircularProgressIndicator()),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage,
                              image: _motorcycle.motorprofilelink,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          FittedBox(
                            fit: BoxFit.contain,
                            child: Text(this._motorcycle.brand +
                                " " +
                                this._motorcycle.generation),
                          ),
                          Text(UseString.price +
                              " : " +
                              _motorcycleBook.price
                                  .toString()),
                          Text(UseString.time +
                              " : " +
                             _motorcycleBook.time),
                          Text(UseString.date +
                              " : " +
                              Jiffy([
                               _motorcycleBook.year,
                                _motorcycleBook.month,
                                _motorcycleBook.day,
                                // _motortimeslot.year,
                                // _motortimeslot.month,
                                // _motortimeslot.day
                              ]).format("MMM do yy")),
                        ],
                      )),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(_motorcycleBook.renterprofilelink))),
                      ),
                      // Center(
                      //   child: Image.network(_motorBookListBloc
                      //         .motorcyclebooklist[0]
                      //         .renterprofilelink,),
                      // ),
                      Text(_motorcycleBook.rentername)
                    ],
                  ),
                  RaisedButton(
                    child: Text(
                      UseString.cancel,
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.red,
                    onPressed: () {},
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
