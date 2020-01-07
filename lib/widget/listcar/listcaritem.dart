import 'package:flutter/material.dart';
import 'package:pickcar/main.dart';
import 'package:pickcar/models/motorcycle.dart';
import 'package:pickcar/page/motordetailpage.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../datamanager.dart';

class ListCarItem extends StatefulWidget {
  BoxConstraints constrant;
  Color statuscolor;
  Motorcycle motor;
  ListCarItem({Key key, @required this.constrant, @required this.motor})
      : super(key: key) {
    switch (motor.carstatus) {
      case CarStatus.nothing:
        {
          statuscolor = Colors.grey;
        }
        break;
      case CarStatus.waiting:
        {
          statuscolor = Colors.yellow;
        }
        break;
      case CarStatus.booked:
        {
          statuscolor = Colors.blue;
        }
        break;
      case CarStatus.working:
        {
          statuscolor = PickCarColor.colormain;
        }
        break;
    }
  }

  @override
  _ListCarItemState createState() => _ListCarItemState();
}

class _ListCarItemState extends State<ListCarItem> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //print("Inkwell firstore docid : ${widget.motor.motorprofilelink}");
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MotorDetailPage(
                    motordocid: widget.motor.firestoredocid,
                  )),
        );
      },
      child: Stack(
        children: <Widget>[
          Container(
            height: widget.constrant.maxHeight * 0.2,
            width: widget.constrant.maxWidth * 0.9,
            decoration: BoxDecoration(
                color: widget.statuscolor,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0, 15.0),
                      blurRadius: 15.0),
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0, -10.0),
                      blurRadius: 10.0),
                ],
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                RotatedBox(
                  quarterTurns: -1,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      widget.motor.carstatus,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: widget.constrant.maxHeight * 0.18,
            width: widget.constrant.maxWidth * 0.8,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            padding: EdgeInsets.all(5),
            child: Row(
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Stack(
                      children: <Widget>[
                        Center(child: CircularProgressIndicator()),
                        Center(
                          child: FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: widget.motor.motorprofilelink,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              widget.motor.brand +
                                  " " +
                                  widget.motor.generation,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                              ),
                            )),
                        SizedBox(
                          height: 2,
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            UseString.waitingforrent,
                            style: TextStyle(fontSize: 20, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
