import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pickcar/datamanager.dart';
import 'package:pickcar/models/coupon.dart';
import 'package:random_string/random_string.dart';

createcoupon(String userdocid) async {
  var now = DateTime.now();
  String code ="";
  for(int i = 0; i<12;i++){
    if(Random().nextBool()){
      code = code + Random().nextInt(9).toString();
    }else{
      code = code + randomAlpha(1);
    }
  }
  String docid = await Firestore.instance.collection("Coupon")
                          .document(userdocid)
                          .collection("Coupongroup").document().documentID;
  Coupon coupon = Coupon(
    startdate: now,
    expireddate: DateTime(now.year,now.month+1,now.day,now.hour,now.minute,now.second,now.millisecond),
    code: code,
    percent: Random().nextInt(5)+10,
    use: false,
    coupondocid: docid
  );
  await Firestore.instance.collection("Coupon")
                          .document(userdocid)
                          .collection("Coupongroup")
                          .document(docid)
                          .setData(coupon.toJson());
}