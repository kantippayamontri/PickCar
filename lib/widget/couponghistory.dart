import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pickcar/datamanager.dart';
import 'package:pickcar/models/coupon.dart';
import 'package:pickcar/ui/uisize.dart';

  int couter = 0;
  String monthy(int month) {
    switch (month) {
      case 1:
        return 'Jan';
        break;
      case 2:
        return 'Feb';
        break;
      case 3:
        return 'Mar';
        break;
      case 4:
        return 'Apr';
        break;
      case 5:
        return 'May';
        break;
      case 6:
        return 'Jun';
        break;
      case 7:
        return 'Jul';
        break;
      case 8:
        return 'Aug';
        break;
      case 9:
        return 'Sep';
        break;
      case 10:
        return 'Oct';
        break;
      case 11:
        return 'Nov';
        break;
      default:
        return 'Dec';
        break;
    }
  }
  showbutton(BuildContext context){
    SizeConfig().init(context);
    var data = MediaQuery.of(context);
    if(couter == 0){
      return Visibility(
        visible: Activate.activatecoupon,
        child: Container(
          margin: EdgeInsets.only(top:SizeConfig.blockSizeVertical*1),
          child: FlatButton(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color: PickCarColor.colorbuttom,
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(8.0),
              // side: BorderSide(color: Colors.red)
            ),
            onPressed: () {
              Activate.pressed = false;
              Navigator.of(context).pop();
            },
            child: AutoSizeText(UseString.back,
              maxLines: 1,
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*17,color: Colors.white), 
            ),
          ),
        ),
      );
    }else{
      return Container();
    }
  }
  @override
  Widget historycoupon(BuildContext context) {
    SizeConfig().init(context);
    var datasize = MediaQuery.of(context);
    Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
      couter = couter -1;
      // print(couter);
      Couponshow coupon = Couponshow.fromSnapshot(data);
      return Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left:SizeConfig.blockSizeHorizontal*2,right:SizeConfig.blockSizeHorizontal*2,top:SizeConfig.blockSizeVertical),
                height: SizeConfig.blockSizeVertical*15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  //  color: Colors.black,
                ),
                width: datasize.size.width,
                child: Image.asset('assets/images/imagecoupon/historycupon.png',fit: BoxFit.fill,),
              ),
              GestureDetector(
                onTap: (){
                  if(Activate.activatecoupon){
                    Datamanager.couponshow = coupon;
                    Activate.pressed = true;
                    Navigator.of(context).pop();
                  }
                },
                child: Container(
                  // color:Colors.blue,
                  margin: EdgeInsets.only(left:SizeConfig.blockSizeHorizontal*2,top:SizeConfig.blockSizeVertical),
                  height: SizeConfig.blockSizeVertical*15,
                  width: SizeConfig.blockSizeHorizontal*70,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top:SizeConfig.blockSizeVertical,left:SizeConfig.blockSizeHorizontal*3),
                        // color: Colors.blue,
                        width: SizeConfig.blockSizeHorizontal*18,
                        height: SizeConfig.blockSizeVertical*9,
                        child: Image.asset("assets/images/imagecoupon/carhistory.png",fit: BoxFit.cover),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*23,top:SizeConfig.blockSizeVertical*2),
                        child: AutoSizeText(coupon.percent.toString()+"% "+UseString.offin+".",
                            style: TextStyle(fontWeight: FontWeight.normal,fontSize: datasize.textScaleFactor*24,color: Colors.white),
                          ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*5,top:SizeConfig.blockSizeVertical*11),
                        child: AutoSizeText(UseString.validexpaired+
                              coupon.expireddate.day.toString()+" "+
                              monthy(coupon.expireddate.month)+" "+
                              coupon.expireddate.year.toString(),
                            style: TextStyle(fontWeight: FontWeight.normal,fontSize: datasize.textScaleFactor*16,color: Colors.white),
                          ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                // color:Colors.blue,
                margin: EdgeInsets.only(left:SizeConfig.blockSizeHorizontal*70,top:SizeConfig.blockSizeVertical),
                height: SizeConfig.blockSizeVertical*15,
                width: SizeConfig.blockSizeHorizontal*28,
                child: Stack(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*3,top:SizeConfig.blockSizeVertical*2),
                      child: AutoSizeText(coupon.percent.toString()+"%",
                          maxLines: 1,
                          style: TextStyle(fontWeight: FontWeight.normal,fontSize: datasize.textScaleFactor*50,color: Colors.white),
                        ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*6,top:SizeConfig.blockSizeVertical*10),
                      child: AutoSizeText(UseString.discount,
                          maxLines: 1,
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: datasize.textScaleFactor*18,color: Colors.white),
                        ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          showbutton(context),
        ],
      );
    }
    Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
      couter = snapshot.length;
      if(snapshot.length > 0){
        return ListView(
          // padding: EdgeInsets.only(top: 20.0),
          children: snapshot.map((data) => _buildListItem(context, data)).toList(),
        );
      }else{
        var datasize = MediaQuery.of(context);
        return Container(
            height: datasize.size.height/1.4,
            child: Center(
              child: AutoSizeText(UseString.notcoupon,
                maxLines: 1,
                style: TextStyle(fontWeight: FontWeight.normal,fontSize: datasize.textScaleFactor*36,color: PickCarColor.colorFont1),
              ),
            ),
          );
      }
    }
    var data = MediaQuery.of(context);
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection("Coupon")
                                  .document(Datamanager.user.documentid)
                                  .collection("Coupongroup")
                                  .where("use",isEqualTo:true)
                                  .orderBy("expireddate")
                                  .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
             return Container(
              height: datasize.size.height/1.4,
              child: Center(
                child: AutoSizeText(UseString.notcoupon,
                  maxLines: 1,
                  style: TextStyle(fontWeight: FontWeight.normal,fontSize: datasize.textScaleFactor*36,color: PickCarColor.colorFont1),
                ),
              ),
            );
          }else{
            // print(snapshot.data.documents);
            // return Container();
            return _buildList(context, snapshot.data.documents);
          }
        },
      ),
      );
  }