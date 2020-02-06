import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pickcar/datamanager.dart';
import 'package:pickcar/models/motorcycletimeslot.dart';
import 'package:pickcar/models/singleforrent.dart';

class MotorWaitingEdit extends StatefulWidget {

  Function editslot;
  SingleForrent singleforrent;
MotorWaitingEdit({@required this.editslot , @required this.singleforrent});

  @override
  _MotorWaitingEditState createState() => _MotorWaitingEditState();
}

class _MotorWaitingEditState extends State<MotorWaitingEdit> {
  TextEditingController pricecontroller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState

    //pricecontroller.text = widget.motorslot.prize.toString();
    pricecontroller.text = widget.singleforrent.price.toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            children: <Widget>[
              Text(UseString.price),
              TextField(
                decoration: InputDecoration(labelText: UseString.price),
                controller: pricecontroller,
                keyboardType: TextInputType.number,
                onSubmitted: (_) {},
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  RaisedButton(
                    color: PickCarColor.colormain,
                    child: Text(
                      UseString.edit,
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      //widget.editslot(widget.motorslot.docid , pricecontroller.text);
                      widget.editslot(widget.singleforrent.docid , pricecontroller.text);
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
