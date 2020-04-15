import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:pickcar/models/forrent.dart';
import 'package:pickcar/models/motorcycle.dart';
import 'package:pickcar/models/motorcycletimeslot.dart';
import 'package:pickcar/models/singleforrent.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../datamanager.dart';

class MotorWaitingListItem extends StatefulWidget {
  Motorcycle motorcycle;
  //MotorcycleTimeSlot motorWaitingListItem;
  Forrent forrent;
  BoxConstraints constraints;
  Function deleteslot;
  Function editslot;
  Function showbottomsheet;
  MotorWaitingListItem(
      {Key key,
      //@required this.motorWaitingListItem,
      @required this.forrent,
      @required this.constraints,
      @required this.motorcycle,
      @required this.deleteslot,
      @required this.editslot,
      @required this.showbottomsheet
      })
      : super(key: key);

  @override
  _MotorWaitingListItemState createState() => _MotorWaitingListItemState();
}

class _MotorWaitingListItemState extends State<MotorWaitingListItem> {
  Motorcycle _motorcycle;
  //MotorcycleTimeSlot _motortimeslot;
  BoxConstraints _constraints;
  Forrent _forrent;
  
  @override
  void initState() {
    // TODO: implement initState
    //_motortimeslot = widget.motorWaitingListItem;
    _forrent = widget.forrent;
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
            child: Column(
              children: <Widget>[
                Row(
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
                                image: this._motorcycle.motorprofilelink,
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
                                //_motortimeslot.prize.toString()
                                _forrent.price.toString()
                                ),
                            Text(UseString.time +
                                " : " +
                                //_motortimeslot.timeslot
                                _forrent.time
                                
                                ),
                            Text(UseString.date +
                                " : " +
                                Jiffy([
                                  //_motortimeslot.year,
                                  //_motortimeslot.month,
                                 // _motortimeslot.day
                                 _forrent.year,
                                 _forrent.month,
                                 _forrent.day
                                ]).format("MMM do yy")),
                          ],
                        )),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(child: SizedBox(),),
                    RaisedButton(
                      color: Colors.blue,
                      child: Text(
                        UseString.edit,
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        //todo openbuttomsheet
                        widget.showbottomsheet(
                          widget.forrent,
                          widget.editslot
                        );
                      },
                    ),
                    SizedBox(width: 20,),
                    RaisedButton(
                      color : Colors.red,
                      child: Text(
                        UseString.delete,
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        widget.deleteslot(_forrent.type , _forrent.docid);
                        // todo deleteslot await widget.deleteslot(_motortimeslot);
                      },
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
