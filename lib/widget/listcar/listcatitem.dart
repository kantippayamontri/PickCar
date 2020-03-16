
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pickcar/main.dart';
import 'package:pickcar/models/listcarslot.dart';
import 'package:pickcar/models/motorcycle.dart';
import 'package:pickcar/page/motordetailpage.dart';
import 'package:pickcar/ui/uisize.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../datamanager.dart';

class ListCarItem extends StatefulWidget {
  BoxConstraints constrant;
  Color statuscolor;
  Motorcycle motor;
  bool showwaiting = false;
  bool showbooking = false;
  bool showworking = false;
  double isbooking =0;
  double iswaiting =0;
  double isworking =0;
  ListCarItem({Key key, @required this.constrant, @required this.motor})
      : super(key: key) {
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
    if(widget.motor.iswaiting){
      widget.showwaiting = true;
    }
    if(widget.motor.isbook){
      widget.showbooking = true;
    }
    if(widget.motor.isworking){
      widget.showworking = true;
    }
    // if(!widget.motor.iswaiting && !widget.motor.isworking){
    //   widget.isbooking = SizeConfig.blockSizeHorizontal*26;
    // }
    if(!widget.motor.iswaiting){
      widget.isbooking = SizeConfig.blockSizeHorizontal*28;
    }
    if(!widget.motor.isbook){
      widget.iswaiting = SizeConfig.blockSizeHorizontal*28;
    }
    if(!widget.motor.iswaiting && !widget.motor.isworking){
      widget.isbooking = SizeConfig.blockSizeHorizontal*28;
    }
    if(!widget.motor.iswaiting && !widget.motor.isbook){
      widget.isworking = SizeConfig.blockSizeHorizontal*2;
    }
    SizeConfig().init(context);
    var datasize = MediaQuery.of(context);
    showwarningWait(BuildContext context){
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(UseString.pleasewaittitlecar),
            content: Text(UseString.pleasewaitbody),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
    showwarningreject(BuildContext context){
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(UseString.rejectalertcar,
                style: TextStyle(color: Colors.red), 
            ),
            content: Text(UseString.rejectalertbodycar,
                style: TextStyle(color: Colors.red), 
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Send license'),
                onPressed: () {
                  // Navigator.of(context).pop();
                  Navigator.of(context).pushNamed(Datamanager.sendregistation);
                },
              ),
              FlatButton(
                child: Text(UseString.cancel),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
    return InkWell(
      onTap: () {
        Datamanager.motorcycle = widget.motor;
        Firestore.instance.collection('Motorcycle').document(widget.motor.firestoredocid)
                                            .get().then((data){
                                              MotorcycleShow motorshow = MotorcycleShow.fromSnapshot(data);
                                              if(motorshow.isapprove == 'wait'){
                                                showwarningWait(context);
                                              }else if(motorshow.isapprove == 'Approve'){
                                                 Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => MotorDetailPage(
                                                            motordocid: widget.motor.firestoredocid,
                                                          )),
                                                );
                                              }else{
                                                showwarningreject(context);
                                              }
                                            });
      },
      child: Stack(
        children: <Widget>[
          Container(
            width: datasize.size.width,
            height: SizeConfig.blockSizeVertical*22,
            child: Image.asset('assets/images/imagesearch/card.png',fit: BoxFit.fill,),
          ),
          Container(
            width: SizeConfig.blockSizeHorizontal*90,
            height: SizeConfig.blockSizeVertical*17,
            // color: Colors.blue,
            margin: EdgeInsets.only(left:SizeConfig.blockSizeHorizontal*6,top:SizeConfig.blockSizeVertical*2, ),
            child: Stack(
            children: <Widget>[
              Row(
                children: <Widget>[
                   Container(
                    width: SizeConfig.blockSizeHorizontal*33,
                    height: SizeConfig.blockSizeVertical*17,
                    child: Stack(
                      children: <Widget>[
                        Center(
                          child: CircularProgressIndicator()
                        ),
                        Center(
                          child: FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: widget.motor.motorprofilelink,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        // alignment: Alignment.topLeft,
                        width: SizeConfig.blockSizeHorizontal*54,
                        // color: Colors.blue,
                        margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical),
                        child: Text(widget.motor.brand +" "+widget.motor.generation,
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: datasize.textScaleFactor*24,color: PickCarColor.colorFont1), 
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Visibility(
                            visible: widget.showwaiting,
                            child: Container(
                              margin: EdgeInsets.only(left:SizeConfig.blockSizeHorizontal,right: widget.iswaiting),
                              width: SizeConfig.blockSizeHorizontal*27,
                              height: SizeConfig.blockSizeVertical*4,
                              decoration: BoxDecoration(
                                // color: Colors.green,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20.0),
                                ),
                                border: Border.all(
                                  color: Colors.grey[400],
                                  width: 2,
                                ),
                              ),
                              child: 
                              Container(
                                width: double.infinity,
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(left:SizeConfig.blockSizeHorizontal,),
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.local_offer,
                                      color: Colors.grey[400],
                                      size: SizeConfig.blockSizeHorizontal *5,
                                    ),
                                    Text(UseString.waitting ,
                                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: datasize.textScaleFactor*18,color: Colors.grey[400]), 
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: widget.showbooking,
                            child: Container(
                               margin: EdgeInsets.only(left:SizeConfig.blockSizeHorizontal,right: widget.isbooking),
                              width: SizeConfig.blockSizeHorizontal*27,
                              height: SizeConfig.blockSizeVertical*4,
                              decoration: BoxDecoration(
                                // color: Colors.green,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20.0),
                                ),
                                border: Border.all(
                                  color: PickCarColor.colormain,
                                  width: 2,
                                ),
                              ),
                              child: 
                              Container(
                                width: double.infinity,
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(left:SizeConfig.blockSizeHorizontal,),
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.local_offer,
                                      color: PickCarColor.colormain,
                                      size: SizeConfig.blockSizeHorizontal *5,
                                    ),
                                    Text(UseString.bookking ,
                                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: datasize.textScaleFactor*18,color: PickCarColor.colormain), 
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                     Visibility(
                        visible: widget.showworking,
                        child: Container(
                          margin: EdgeInsets.only(top:SizeConfig.blockSizeVertical,right: SizeConfig.blockSizeHorizontal*27,left:widget.isworking),
                          // alignment: Alignment.centerLeft,
                          width: SizeConfig.blockSizeHorizontal*27,
                          height: SizeConfig.blockSizeVertical*4,
                          decoration: BoxDecoration(
                            // color: Colors.green,
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                            border: Border.all(
                              color: Colors.blueAccent,
                              width: 2,
                            ),
                          ),
                          child: 
                          Container(
                            width: double.infinity,
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(left:SizeConfig.blockSizeHorizontal,),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.local_offer,
                                  color: Colors.blueAccent,
                                  size: SizeConfig.blockSizeHorizontal *5,
                                ),
                                Text(UseString.workking ,
                                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: datasize.textScaleFactor*18,color: Colors.blueAccent,), 
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          ),
        ],
      ),
    );
  }
}

