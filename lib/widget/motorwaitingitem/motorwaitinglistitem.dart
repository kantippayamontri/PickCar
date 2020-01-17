import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:pickcar/models/motorcycle.dart';
import 'package:pickcar/models/motorcycletimeslot.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../datamanager.dart';

class MotorWaitingListItem extends StatefulWidget {
  Motorcycle motorcycle;
  MotorcycleTimeSlot motorWaitingListItem;
  BoxConstraints constraints;
  MotorWaitingListItem(
      {
        Key key,@required this.motorWaitingListItem,
      @required this.constraints,
      @required this.motorcycle}) : super(key: key);

  @override
  _MotorWaitingListItemState createState() => _MotorWaitingListItemState();
}

class _MotorWaitingListItemState extends State<MotorWaitingListItem> {
  Motorcycle _motorcycle;
  MotorcycleTimeSlot _motortimeslot;
  BoxConstraints _constraints;
  @override
  void initState() {
    // TODO: implement initState
    _motortimeslot = widget.motorWaitingListItem;
    _constraints = widget.constraints;
    _motorcycle = widget.motorcycle;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 20,
      child: Stack(
        children: [
          Container(
            height: _constraints.maxHeight * 0.275,
            width: _constraints.maxWidth * 0.9,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.yellow),
          ),
          Container(
            height: _constraints.maxHeight * 0.25,
            width: _constraints.maxWidth * 0.85,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: Colors.white),
            padding: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: this._motorcycle.motorprofilelink,
                          fit: BoxFit.fill,
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
                            _motortimeslot.prize.toString()),
                        Text(UseString.time + " : " + _motortimeslot.timeslot),
                        Text(UseString.date +
                            " : " +
                            Jiffy([
                              _motortimeslot.year,
                              _motortimeslot.month,
                              _motortimeslot.day
                            ]).format("MMM do yy")),
                      ],
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
