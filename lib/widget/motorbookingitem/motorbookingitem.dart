import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:pickcar/icon/motoricon_icons.dart';
import 'package:pickcar/models/motorcycle.dart';
import 'package:pickcar/models/motorcyclebook.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../datamanager.dart';

class MotorBookItem extends StatefulWidget {
  Motorcycle motorcycle;
  MotorcycleBook motorbook;
  MediaQueryData mediaQueryData;
  Function canclebook;

  MotorBookItem(
      {Key key,
      @required this.motorcycle,
      @required this.motorbook,
      @required this.mediaQueryData,
      @required this.canclebook})
      : super(key: key) {}

  @override
  _MotorBookItemState createState() => _MotorBookItemState();
}

class _MotorBookItemState extends State<MotorBookItem> {
  Motorcycle _motorcycle;
  MotorcycleBook _motorcycleBook;
  MediaQueryData _mediaQueryData;
  Function _canclebook;

  @override
  void initState() {
    // TODO: implement initState

    _motorcycle = widget.motorcycle;
    _motorcycleBook = widget.motorbook;
    _mediaQueryData = widget.mediaQueryData;
    _canclebook = widget.canclebook;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("***motor book type : ${_motorcycleBook.status}");
    return Card(
      elevation: 20,
      child: Container(
        height: _mediaQueryData.size.height * 0.4,
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
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                  width:
                                      (_mediaQueryData.size.width * 0.9) * 0.1,
                                  child: Icon(Motoricon.motorcycle)),
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                width: (_mediaQueryData.size.width * 0.9) * 0.3,
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Text(
                                    this._motorcycle.brand +
                                        " " +
                                        this._motorcycle.generation,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                  width:
                                      (_mediaQueryData.size.width * 0.9) * 0.1,
                                  child: Icon(Icons.money_off)),
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                width: (_mediaQueryData.size.width * 0.9) * 0.3,
                                child: Text(
                                  _motorcycleBook.price.toString(),
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                  width:
                                      (_mediaQueryData.size.width * 0.9) * 0.1,
                                  child: Icon(Icons.timer)),
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                  width:
                                      (_mediaQueryData.size.width * 0.9) * 0.3,
                                  child: Text(
                                    _motorcycleBook.time,
                                    style: TextStyle(fontSize: 18),
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                  width:
                                      (_mediaQueryData.size.width * 0.9) * 0.1,
                                  child: Icon(Icons.table_chart)),
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                width: (_mediaQueryData.size.width * 0.9) * 0.3,
                                child: Text(
                                  Jiffy([
                                    _motorcycleBook.year,
                                    _motorcycleBook.month,
                                    _motorcycleBook.day,
                                  ]).format("MMM do yy"),
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                  width:
                                      (_mediaQueryData.size.width * 0.9) * 0.1,
                                  child: Icon(Motoricon.motorcycle)),
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                width: (_mediaQueryData.size.width * 0.9) * 0.3,
                                child: RaisedButton(
                                  onPressed: () {},
                                  color: _motorcycleBook.status == "booking"
                                      ? Colors.blueAccent
                                      : _motorcycleBook.status == "working"
                                          ? PickCarColor.colormain
                                          : Colors.grey,
                                  child: Text(
                                    _motorcycleBook.status,
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(18.0),
                                      side: BorderSide(color: Colors.grey)),
                                ),
                              ),
                            ],
                          ),
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
                                image: NetworkImage(
                                    _motorcycleBook.renterprofilelink))),
                      ),
                      // Center(
                      //   child: Image.network(_motorBookListBloc
                      //         .motorcyclebooklist[0]
                      //         .renterprofilelink,),
                      // ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        _motorcycleBook.rentername,
                        style:
                            TextStyle(fontSize: 22, color: Colors.blueAccent),
                      )
                    ],
                  ),
                  _motorcycleBook.status == "booking"
                      ? RaisedButton(
                          child: Text(
                            UseString.cancel,
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.red,
                          onPressed: () {
                            //todo cancle
                            _canclebook(_motorcycleBook.bookingdocid);
                          },
                        )
                      : SizedBox(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
