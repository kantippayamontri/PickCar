import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:pickcar/datamanager.dart';
import 'package:pickcar/models/booking.dart';
import 'package:pickcar/models/history.dart';
import 'package:pickcar/models/listcarslot.dart';
import 'package:pickcar/models/motorcycle.dart';
import 'package:pickcar/ui/uisize.dart';
import 'package:flutter/services.dart';
class ConfirmPage extends StatefulWidget {
  var code = TextEditingController();
  bool isExpand = true;
  bool alertpolicy = false;
  bool coupon = true;
  var icon = Icons.arrow_drop_down;
  var pricefree;
  var pricetotal;
  double pricevat;
  var iconchange = Icon(Icons.arrow_drop_up,size: 32,color: PickCarColor.colormain,);
  @override
  _ConfirmPageState createState() => _ConfirmPageState();
}

class _ConfirmPageState extends State<ConfirmPage> {
  void initState(){
    Checkpolicy.checkpolicy = false;
    super.initState();
  }
  String monthy(int month){
    switch(month){
      case 1:return 'January';break;
      case 2:return 'February';break;
      case 3:return 'March';break;
      case 4:return 'April';break;
      case 5:return 'May';break;
      case 6:return 'June';break;
      case 7:return 'July';break;
      case 8:return 'August';break;
      case 9:return 'September';break;
      case 10:return 'October';break;
      case 11:return 'November';break;
      default:return 'December';break;
    }
  }
  Widget alertpolicy(BuildContext context){
    var data = MediaQuery.of(context);
    if(widget.alertpolicy == true){
      return Container(
        margin: EdgeInsets.only(top: 5),
        child: Text(UseString.notaccept,
            style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*19,color: Colors.red[600]), 
          ),
      );
    }else{
      return Container();
    }
  }
  calculateprice(){
    var price = Datamanager.listcarslot.price;
    widget.pricefree = price + 5;
    widget.pricevat = (widget.pricefree * 7)/100;
    var priceinclude = widget.pricefree+(widget.pricefree * 7)/100;
    String string = priceinclude.toString();
    var dot = string.split('.');
    print(dot);
    double numberdot = double.parse(dot[1]);
    double number = double.parse(dot[0]);
    if(numberdot>0 && numberdot<25){
      number += 0.25;
    }else if(numberdot>25 && numberdot<50){
      number += 0.50;
    }else if(numberdot>50 && numberdot<75){
      number += 0.75;
    }else{
      number += 1;
    }
    widget.pricetotal = number;
    print(widget.pricetotal);
  }
  booking(BuildContext context) async {
    Booking booking = Booking(
      university: Datamanager.listcarslot.university,
      times: Datamanager.listcarslot.time,
      day: Datamanager.listcarslot.day,
      month: Datamanager.listcarslot.month,
      price: Datamanager.listcarslot.price,
      year: Datamanager.listcarslot.year,
      motorcycledocid: Datamanager.listcarslot.motorcycledocid,
      ownerid: Datamanager.listcarslot.ownerdocid,
      myid: Datamanager.user.documentid,
      boxdocid: Datamanager.listcarslot.boxdocid,
      boxslotrentdocid:  Datamanager.listcarslot.boxslotrentdocid,
      boxplacedocid:  Datamanager.listcarslot.boxplacedocid,
      motorplacelocdocid: Datamanager.listcarslot.motorplacelocdocid,
      iscancle: Datamanager.listcarslot.iscancle,
      ownercanclealert: Datamanager.listcarslot.ownercanclealert,
      rentercanclealert: Datamanager.listcarslot.rentercanclealert,
      status: 'booking',
      bookingdocid:null,
      priceaddtax: widget.pricetotal,
      startdate: Datamanager.listcarslot.startdate,
      isinhistory: false,
    );
    await Firestore.instance.collection('Singleforrent')
                              .where('ownerdocid' ,isEqualTo: Datamanager.listcarslot.ownerdocid)
                              .getDocuments().then((data) {
                                var document ;
                                Future.delayed(const Duration(milliseconds: 1000), () async {
                                  if(data.documents.length == 1){
                                    // print(data.documents.length);
                                      var ref = await Datamanager.firestore.collection('Booking').add(booking.toJson());
                                      document = ref.documentID;
                                      Datamanager.firestore.collection("Booking").document(document).updateData(
                                          {'bookingdocid' : document}
                                      );
                                      Datamanager.firestore.collection("Motorcycle")
                                                            .document(Datamanager.listcarslot.motorcycledocid)
                                                            .updateData({"isbook": true,"iswaiting":false});
                                      Datamanager.firestore.collection('Singleforrent').document(Datamanager.listcarslot.docid).delete();
                                  }else{
                                    print(data.documents.length);
                                    print('=====');
                                    var ref = await Datamanager.firestore.collection('Booking').add(booking.toJson());
                                    document = ref.documentID;
                                    Datamanager.firestore.collection("Booking").document(document).updateData(
                                        {'bookingdocid' : document}
                                    );
                                    Datamanager.firestore.collection("Motorcycle")
                                                          .document(Datamanager.listcarslot.motorcycledocid)
                                                          .updateData({"isbook": true});
                                    Datamanager.firestore.collection('Singleforrent').document(Datamanager.listcarslot.docid).delete();
                                   
                                  }
                                  History history = History(
                                    times:Datamanager.listcarslot.time,
                                    price:Datamanager.listcarslot.price,
                                    motorcycledocid:Datamanager.listcarslot.motorcycledocid,
                                    // boxname:,
                                    // plancename:,
                                    iscancel: false,
                                    university:Datamanager.listcarslot.university,
                                    priceaddtax:widget.pricetotal,
                                    startdate:Datamanager.listcarslot.startdate,
                                    ownername:Datamanager.user.name,
                                    brand:Datamanager.motorcycleShow.brand,
                                    generation:Datamanager.motorcycleShow.generation,
                                    imagelink:Datamanager.motorcycleShow.motorfrontlink,
                                    ownermotorcycle:Datamanager.listcarslot.ownerdocid,
                                    renterdocid:Datamanager.user.documentid,
                                  );
                                  // Motorcyclehistory motorcycle = Motorcyclehistory(
                                  //     brand:Datamanager.motorcycleShow.brand,
                                  //     generation:Datamanager.motorcycleShow.generation,
                                  //     cc:Datamanager.motorcycleShow.cc,
                                  //     color:Datamanager.motorcycleShow.gear,
                                  //     gear:Datamanager.motorcycleShow,
                                  //     owneruid:Datamanager.motorcycleShow,
                                  //     storagedocid:Datamanager.motorcycleShow,
                                  //     motorprofilelink:Datamanager.motorcycleShow,
                                  //     motorfrontlink:Datamanager.motorcycleShow,
                                  //     motorbacklink:Datamanager.motorcycleShow,
                                  //     motorleftlink:Datamanager.motorcycleShow,
                                  //     motorrightlink:Datamanager.motorcycleShow,
                                  //     motorreg:Datamanager.motorcycleShow,
                                  //     motorgas:Datamanager.motorcycleShow,
                                  //     myid:Datamanager.motorcycleShow,
                                  // );
                                  await Firestore.instance.collection("history")
                                                          .document(Datamanager.user.documentid)
                                                          .collection("historylist")
                                                          .document(document)
                                                          .setData(history.toJson());
                                  await Firestore.instance.collection("history")
                                                          .document(Datamanager.listcarslot.ownerdocid)
                                                          .collection("historylist")
                                                          .document(document)
                                                          .setData(history.toJson());
                                });
                              });
  }
  Future<void> _ackAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0))
          ),
          title: Text(UseString.areyousure),
          content: Text(UseString.rentthis),
          actions: <Widget>[
            FlatButton(
              child: Text(UseString.confirm),
              onPressed: () {
                booking(context);
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text(UseString.cancel),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var data = MediaQuery.of(context);
    var time = Datamanager.listcarslot.time.split('-');
    calculateprice();
    return Scaffold(
      appBar: AppBar(
       backgroundColor: Colors.white,
       flexibleSpace: Image(
          image: AssetImage('assets/images/imagesprofile/appbar/background.png'),
          fit: BoxFit.cover,
        ),
       centerTitle: true,
       title: Text(UseString.confirmrent,
          style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*25,color: Colors.white), 
       ),
       leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left,
          color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child:Stack(
          children: <Widget>[
            Container(
              width: SizeConfig.screenWidth,
              height: SizeConfig.blockSizeVertical*5,
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical,left: SizeConfig.blockSizeHorizontal*4),
              child: Text(UseString.rentaldetail,
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*25,color: PickCarColor.colormain), 
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*7),
              child: Stack(
                children: <Widget>[
                  Container(
                    width: SizeConfig.screenWidth/2,
                    height: SizeConfig.blockSizeVertical*3,
                    // color: Colors.black,
                    child: Center(
                      child: Text(UseString.selectedcar,
                          style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*20,color: PickCarColor.colorFont2), 
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left:SizeConfig.screenWidth/2),
                    width: SizeConfig.screenWidth/2,
                    height: SizeConfig.blockSizeVertical*3,
                    child: Center(
                      child: Text(UseString.licenseplate,
                        style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*20,color: PickCarColor.colorFont2), 
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // color: Colors.black,
              margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*10,),
              child: Stack(
                children: <Widget>[
                  Container(
                    width: SizeConfig.screenWidth/2,
                    height: SizeConfig.blockSizeVertical*10,
                    // color: Colors.black,
                    // alignment: Alignment.centerLeft,
                    child: Column(
                      children: <Widget>[
                        Text(Datamanager.motorcycleShow.brand,
                            style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*22,color: PickCarColor.colorcmu), 
                        ),
                         Text(Datamanager.motorcycleShow.generation,
                            style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*22,color: PickCarColor.colorcmu), 
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: SizeConfig.screenWidth/2,),
                    width: SizeConfig.screenWidth/2,
                    height: SizeConfig.blockSizeVertical*6,
                    // alignment: Alignment.topCenter,
                    // color: Colors.black,
                    child: Center(
                      child: Text(Datamanager.motorcycleShow.motorreg,
                          style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*22,color: PickCarColor.colorcmu), 
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
            margin: EdgeInsets.only(top:SizeConfig.blockSizeVertical*18),
            width: SizeConfig.screenWidth,
            height: SizeConfig.blockSizeVertical*3,
            // color: Colors.black,
            child: Center(
              child: Text(UseString.day,
                  style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*20,color: PickCarColor.colorFont2), 
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top:SizeConfig.blockSizeVertical*21),
            width: SizeConfig.screenWidth,
            height: SizeConfig.blockSizeVertical*3,
            child: Center(
              child: Text(Datamanager.listcarslot.day.toString()+' '+monthy(Datamanager.listcarslot.month)+' '+Datamanager.listcarslot.year.toString(),
                  style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*22,color: PickCarColor.colorcmu), 
              ),
            ),
          ),
            Container(
              margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*25),
              child: Stack(
                children: <Widget>[
                  Container(
                    width: SizeConfig.screenWidth/2,
                    height: SizeConfig.blockSizeVertical*3,
                    child: Center(
                      child: Text(UseString.receivecar,
                          style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*20,color: PickCarColor.colorFont2), 
                      ),
                    ),
                  ),
                   Container(
                     margin: EdgeInsets.only(left:SizeConfig.screenWidth/2,),
                     width: SizeConfig.screenWidth/2,
                     height: SizeConfig.blockSizeVertical*3,
                     child: Center(
                       child: Text(UseString.returncar,
                          style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*20,color: PickCarColor.colorFont2), 
                  ),
                     ),
                   ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*28,),
              child: Stack(
                children: <Widget>[
                  Container(
                    width: SizeConfig.screenWidth/2,
                    height: SizeConfig.blockSizeVertical*4,
                    child: Center(
                      child: Text(time[0].trim(),
                          style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*22,color: PickCarColor.colorcmu), 
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: SizeConfig.screenWidth/2,),
                    width: SizeConfig.screenWidth/2,
                    height: SizeConfig.blockSizeVertical*4,
                    child: Center(
                      child: Text(time[1].trim(),
                          style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*22,color: PickCarColor.colorcmu), 
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*31),
              child: Stack(
                children: <Widget>[
                  Container(
                    width: SizeConfig.screenWidth/2,
                    height: SizeConfig.blockSizeVertical*3,
                    // color: Colors.black,
                    child: Center(
                      child: Text(UseString.getcar,
                          style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*20,color: PickCarColor.colorFont2), 
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left:SizeConfig.screenWidth/2),
                    width: SizeConfig.screenWidth/2,
                    height: SizeConfig.blockSizeVertical*3,
                    child: Center(
                      child: Text(UseString.getkey,
                        style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*20,color: PickCarColor.colorFont2), 
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // color: Colors.black,
              margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*34,),
              child: Stack(
                children: <Widget>[
                  Container(
                    width: SizeConfig.screenWidth/2,
                    height: SizeConfig.blockSizeVertical*3,
                    // color: Colors.black,
                    // alignment: Alignment.centerLeft,
                    child: Center(
                      child: Text(Datamanager.motorcycleShow.motorreg,
                          style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*22,color: PickCarColor.colorcmu), 
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: SizeConfig.screenWidth/2,),
                    width: SizeConfig.screenWidth/2,
                    height: SizeConfig.blockSizeVertical*3,
                    // color: Colors.black,
                    child: Center(
                      child: Text(Datamanager.boxlocationshow.name,
                          style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*22,color: PickCarColor.colorcmu), 
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*4,right: SizeConfig.blockSizeHorizontal*4,top:SizeConfig.blockSizeVertical*40),
                color: Colors.grey[200],
                child: ExpansionTile(
                  initiallyExpanded: widget.isExpand,
                  backgroundColor: Colors.white,
                  // key: PageStorageKey(this.widget.headerTitle),
                  trailing: widget.iconchange,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: Colors.grey[200],
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: double.infinity,
                      margin: EdgeInsets.only(left:SizeConfig.blockSizeHorizontal*3,top: SizeConfig.blockSizeVertical),
                      child: Stack(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.centerLeft,
                            width: double.infinity,
                            child: Text(UseString.pricebegin,
                              style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*20,color: PickCarColor.colorcmu), 
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal*3),
                            alignment: Alignment.centerRight,
                            width: double.infinity,
                            child: Text(Datamanager.listcarslot.price.toString(),
                              style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*20,color: PickCarColor.colorcmu), 
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: double.infinity,
                      margin: EdgeInsets.only(left:SizeConfig.blockSizeHorizontal*3,top: SizeConfig.blockSizeVertical/2,bottom: SizeConfig.blockSizeVertical/2),
                      child: Stack(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.centerLeft,
                            width: double.infinity,
                            child: Text(UseString.pricefee,
                              style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*20,color: PickCarColor.colorcmu), 
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal*3),
                            alignment: Alignment.centerRight,
                            width: double.infinity,
                            child: Text(widget.pricefree.toString(),
                              style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*20,color: PickCarColor.colorcmu), 
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: double.infinity,
                      margin: EdgeInsets.only(left:SizeConfig.blockSizeHorizontal*3,top: SizeConfig.blockSizeVertical/2,bottom: SizeConfig.blockSizeVertical/2),
                      child: Stack(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.centerLeft,
                            width: double.infinity,
                            child: Text(UseString.pricevat,
                              style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*20,color: PickCarColor.colorcmu), 
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal*3),
                            alignment: Alignment.centerRight,
                            width: double.infinity,
                            child: Text(widget.pricevat.toString(),
                              style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*20,color: PickCarColor.colorcmu), 
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  onExpansionChanged: (value){
                    setState(() {
                      if(value){
                        widget.iconchange = Icon(Icons.arrow_drop_up,size: 32,color: PickCarColor.colormain,);
                      }else{
                        widget.iconchange = Icon(Icons.arrow_drop_down,size: 32,color: PickCarColor.colormain,);
                      }
                      widget.isExpand = value;
                    });
                  },
                  title: Container(
                    // color: Colors.grey[200],
                    width: double.infinity,
                    child: Text(UseString.pricedetail,
                      style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*20,color: PickCarColor.colormain), 
                    ),
                  )
                ),
              ),
              Container(
                  // color: Colors.grey[200],
                  width: SizeConfig.screenWidth,
                  alignment: Alignment.centerRight,
                  // margin: EdgeInsets.only(right:SizeConfig.blockSizeHorizontal*10),
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        widget.coupon = !widget.coupon;
                        if(widget.coupon){
                          widget.icon = Icons.arrow_drop_up;
                        }else{
                          widget.icon = Icons.arrow_drop_down;
                        }
                      });
                    },
                    child: Container(
                      width: SizeConfig.blockSizeHorizontal*60,
                      child: Row(
                        children: <Widget>[
                          Text(UseString.dopromo,
                            style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*16,color: PickCarColor.colorFont1), 
                          ),
                          GestureDetector(
                            child: Icon(widget.icon), 
                            onTap: (){
                              setState(() {
                                widget.coupon = !widget.coupon;
                                if(widget.coupon){
                                  widget.icon = Icons.arrow_drop_up;
                                }else{
                                  widget.icon = Icons.arrow_drop_down;
                                }
                              });
                            }
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              Visibility(
                visible: widget.coupon,
                child: Container(
                  width: SizeConfig.screenWidth,
                  child: Container(
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.only(right:SizeConfig.blockSizeHorizontal*8),
                    width: SizeConfig.blockSizeHorizontal*40,
                    height: SizeConfig.blockSizeHorizontal*8,
                    child: Container(),
                  ),
                ),
              ),
              Visibility(
                visible: widget.coupon,
                child: Container(
                  // margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*5),
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.blockSizeVertical*10,
                  // color:Colors.black,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left:SizeConfig.blockSizeHorizontal*35,top:SizeConfig.blockSizeVertical),
                        width: SizeConfig.blockSizeHorizontal*35,
                        height: SizeConfig.blockSizeVertical*5,
                        // color: Colors.blue,
                        child: Material(
                          elevation: 8.0,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          shadowColor: Colors.grey[300],
                          child: Center(
                            child: TextFormField(
                              // maxLength: 12,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(12),
                              ],
                              // textAlignVertical: TextAlignVertical.center,
                              // keyboardType: TextInputType.number,
                              controller: widget.code,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: data.textScaleFactor*18,
                                  // color: Color.fromRGBO(69,79,99,1)
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(left:SizeConfig.blockSizeHorizontal*2,bottom: SizeConfig.blockSizeVertical*2),
                                // border: OutlineInputBorder(
                                //   borderSide: BorderSide(
                                //     color: Colors.grey[300],
                                //     width: 3,
                                //   ),
                                //   borderRadius: const BorderRadius.all(Radius.circular(10)),
                                // ),
                                // border: InputBorder.none,
                                hintText: UseString.promo,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topRight,
                        margin: EdgeInsets.only(right:SizeConfig.blockSizeHorizontal*7),
                        child: Container(
                          margin: EdgeInsets.only(top:SizeConfig.blockSizeVertical),
                          width: SizeConfig.blockSizeHorizontal*20,
                          height: SizeConfig.blockSizeVertical*5,
                          child: FlatButton(
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            color: PickCarColor.colorbuttom,
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(8.0),
                              // side: BorderSide(color: Colors.red)
                            ),
                            onPressed: (){
                              
                            },
                            child: AutoSizeText(UseString.apply,
                              maxLines: 1,
                              style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*17,color: Colors.white), 
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
                Container(
                margin: EdgeInsets.only(top:SizeConfig.blockSizeVertical*1),
                width: data.size.width,
                child: Stack(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*6),
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      child: Text(UseString.totalprice,
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*22,color: PickCarColor.colorcmu), 
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal*6),
                      alignment: Alignment.centerRight,
                      width: double.infinity,
                      child: Text(widget.pricetotal.toString()+' '+Currency.thb,
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*22,color: PickCarColor.colorcmu), 
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top:SizeConfig.blockSizeHorizontal),
                width: data.size.width-SizeConfig.blockSizeHorizontal*8,
                height: 2,
                color: Colors.grey[300],
              ),
              // Container(
              //   alignment: Alignment.centerLeft,
              //   margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*4,left: SizeConfig.blockSizeHorizontal*5),
              //   child: Text(UseString.userdetail,
              //       style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*25,color: PickCarColor.colormain), 
              //   ),
              // ),
              // Container(
              //   alignment: Alignment.centerLeft,
              //   margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical,left: SizeConfig.blockSizeHorizontal*7),
              //   child: Row(
              //     children: <Widget>[
              //       Icon(Icons.person,color: Colors.grey[500],),
              //       SizedBox(width: SizeConfig.blockSizeHorizontal,),
              //       Text(Datamanager.user.name,
              //           style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*22,color: PickCarColor.colorcmu), 
              //       ),
              //     ],
              //   ),
              // ),
              // Container(
              //   alignment: Alignment.centerLeft,
              //   margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical,left: SizeConfig.blockSizeHorizontal*7),
              //   child: Row(
              //     children: <Widget>[
              //       Icon(Icons.email,color: Colors.grey[500],),
              //       SizedBox(width: SizeConfig.blockSizeHorizontal,),
              //       Text(Datamanager.user.email,
              //           style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*22,color: PickCarColor.colorcmu), 
              //       ),
              //     ],
              //   ),
              // ),
              // Container(
              //   alignment: Alignment.centerLeft,
              //   margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical,left: SizeConfig.blockSizeHorizontal*7),
              //   child: Row(
              //     children: <Widget>[
              //       Icon(Icons.phone,color: Colors.grey[500],),
              //       SizedBox(width: SizeConfig.blockSizeHorizontal,),
              //       Text(Datamanager.user.tel,
              //           style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*22,color: PickCarColor.colorcmu), 
              //       ),
              //     ],
              //   ),
              // ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*3,left: SizeConfig.blockSizeHorizontal*7),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        SizedBox(
                          height: SizeConfig.blockSizeHorizontal*7,
                          width: SizeConfig.blockSizeHorizontal*7,
                          child: Checkbox(
                          value: Checkpolicy.checkpolicy,
                            onChanged: (bool value) {
                              setState(() {
                                Checkpolicy.checkpolicy = value;
                                widget.alertpolicy =false;
                              });
                            },
                          ),
                        ),
                        Text(UseString.readandagree,
                            style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*17,color: PickCarColor.colorcmu), 
                        ),
                        GestureDetector(
                          onTap: (){},
                          child: Row(
                            children: <Widget>[
                              Text(UseString.policy,
                                style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*17,color: Colors.blue[600],decoration: TextDecoration.underline,), 
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*7),
                      alignment: Alignment.centerLeft,
                      child: Text(UseString.forpolicy,
                        style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*17,color: PickCarColor.colorcmu), 
                      ),
                    ),
                    alertpolicy(context),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: SizeConfig.blockSizeHorizontal*23,
                    height: SizeConfig.blockSizeVertical*5,
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left:SizeConfig.blockSizeHorizontal*4,top: SizeConfig.blockSizeVertical*1),
                    // color: Colors.black,
                    child: RaisedButton(
                      color: Colors.grey[600],
                      onPressed: (){
                          Navigator.pop(context);
                      },
                      child: Text(UseString.cancel,
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*18,color: Colors.white), 
                        ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal,top: SizeConfig.blockSizeVertical*1),
                    width: SizeConfig.blockSizeHorizontal*70,
                    child: RaisedButton(
                      color: PickCarColor.colormain,
                      onPressed: (){
                        if(Checkpolicy.checkpolicy == true){
                          _ackAlert(context);
                        }else{
                          setState(() {
                            widget.alertpolicy = true;
                          });
                        }
                        // Navigator.of(context).pushNamed(Datamanager.detailsearch);
                      },
                      child: Text(UseString.confirm,
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*18,color: Colors.white), 
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
    );
  }
}



// Text("Slotpage"),
            // RaisedButton(
            //   onPressed: (){
            //     booking(context);
            //     if(Datamanager.listcarslot.timeslotlist.length ==0){
            //       Navigator.pop(context);
            //       Navigator.pop(context);
            //       Navigator.pop(context);
            //     }else{
            //       Navigator.pop(context);
            //       Navigator.pop(context);
            //     }
            //     // Navigator.of(context).pushNamed(Datamanager.detailsearch);
            //   },
            //   child: Text("Confirm"),
            // ),