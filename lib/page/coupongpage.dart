import 'package:flutter/material.dart';
import 'package:pickcar/datamanager.dart';
import 'package:pickcar/ui/uisize.dart';
import 'package:pickcar/widget/couponghistory.dart';
import 'package:pickcar/widget/usedcoupon.dart';

class Coupongpage extends StatefulWidget {
  int indicatorpage = 0;
  var motorshow;
  int i =0;
  @override
  _CoupongpageState createState() => _CoupongpageState();
}

class _CoupongpageState extends State<Coupongpage> with TickerProviderStateMixin{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
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
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // var a = true;
    // while(a){
    //   try{
    //     print(a);
    //     Realtime.timecar.cancel();
    //     Realtime.timekey.cancel();
    //   }catch(e){
    //     a =false;
    //   } 
    // }
    body(BuildContext context){
      if(widget.indicatorpage == 0){
        return usecoupon(context);
      }else{
        return historycoupon(context);
      }
    }
    var data = MediaQuery.of(context);
    final List<Tab> myTabs = <Tab>[
      new Tab(
        child: Container(
          margin: EdgeInsets.only(top: 10),
          child: Text(UseString.expire,
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*20,color: PickCarColor.colormain), 
            ),
        ),
      ),
      new Tab(
        child: Container(
          margin: EdgeInsets.only(top: 10),
          child: Text(UseString.expired,
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*20,color: PickCarColor.colormain), 
          ),
        ),
      ),
    ];

    TabController _tabController;
    _tabController = new TabController(vsync: this, length: myTabs.length,initialIndex: widget.indicatorpage);
   
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        flexibleSpace: Image(
            image: AssetImage('assets/images/imagesprofile/appbar/background.png'),
            fit: BoxFit.cover,
          ),
        centerTitle: true,
        bottom: TabBar(
            controller: _tabController,
            labelColor: PickCarColor.colormain,
            tabs: myTabs,
            indicatorColor: PickCarColor.colormain,
            onTap: (data){
              setState(() {
                widget.indicatorpage=data;
                // print(widget.indicatorpage);
                widget.i =0;
              });
            },
          ),
        title: Text(UseString.history,
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
      body: body(context),
      );
  }
}