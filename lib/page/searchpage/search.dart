import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pickcar/datamanager.dart';
import 'package:pickcar/models/universityplace.dart';

class SearchPage extends StatefulWidget {
  int indicatorpage = 0;
  var timeselect = ['08.00 - 09.30','09.30 - 11.00','11.00 - 12.30','13.00 - 14.30','14.30 - 16.00','16.00 - 17.30'];
  int i =0;
  var colorselect1 = Colors.white;
  var colorselect2 = Colors.white;
  var colorselect3 = Colors.white;
  var colorselect4 = Colors.white;
  var colorselect5 = Colors.white;
  var colorselect6 = Colors.white;
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with TickerProviderStateMixin {
  void initState(){
    TimeSearch.time1 = false;
    TimeSearch.time2 = false;
    TimeSearch.time3 = false;
    TimeSearch.time4 = false;
    TimeSearch.time5 = false;
    TimeSearch.time6 = false;
    widget.colorselect1 = Colors.white;
    widget.colorselect2 = Colors.white;
    widget.colorselect3 = Colors.white;
    widget.colorselect4 = Colors.white;
    widget.colorselect5 = Colors.white;
    widget.colorselect6 = Colors.white;
    SearchString.university = UseString.universityhint;
    SearchString.location = UseString.locationhint;
    TimeSearch.today = DateTime.now();
    super.initState();
  }
  String monthy(int month){
    switch(month){
      case 1:return 'Jan';break;
      case 2:return 'Feb';break;
      case 3:return 'Mar';break;
      case 4:return 'Apr';break;
      case 5:return 'May';break;
      case 6:return 'Jun';break;
      case 7:return 'Jul';break;
      case 8:return 'Aug';break;
      case 9:return 'Sep';break;
      case 10:return 'Oct';break;
      case 11:return 'Nov';break;
      default:return 'Dec';break;
    }
  }
  @override
  Widget build(BuildContext context) {
    var data = MediaQuery.of(context);
    showalertuni(BuildContext context){
    var data = MediaQuery.of(context);
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(20),
            ),
            // title: Text('place have same name.'),
            content: Text(UseString.chooseuni,
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*25,color:PickCarColor.colorFont1), 
              ),
          );
        }
      );
    }
    showalertlo(BuildContext context){
    var data = MediaQuery.of(context);
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(20),
            ),
            // title: Text('place have same name.'),
            content: Text(UseString.chooselo,
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*25,color:PickCarColor.colorFont1), 
              ),
          );
        }
      );
    }
    showalertall(BuildContext context){
    var data = MediaQuery.of(context);
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(20),
            ),
            // title: Text('place have same name.'),
            content: Text(UseString.chooseuniandlo,
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*25,color:PickCarColor.colorFont1), 
              ),
          );
        }
      );
    }
    selecttime(BuildContext context){
    var data = MediaQuery.of(context);
    // print(TimeSearch.time1);
      return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                  // side: BorderSide(color: Colors.red)
                ),
                title:  Text(UseString.selecttime,
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*25,color: PickCarColor.colormain), 
                  ),
                content: Container(
                  height: 340,
                  // width: 300,
                  // decoration: new BoxDecoration(
                  //   borderRadius: BorderRadius.circular(12),
                  //   color: Colors.black,
                  // ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 200,
                        child: RaisedButton(
                          color: widget.colorselect1,
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0),
                            side: BorderSide(color: PickCarColor.colormain)
                          ),
                          onPressed: (){
                            setState(() {
                              TimeSearch.time1 = !TimeSearch.time1;
                              if(TimeSearch.time1){
                                widget.colorselect1 = Colors.green[400];
                              }else{
                                widget.colorselect1 = Colors.white;
                              }
                            });
                          },
                          child:  Row(
                            children: <Widget>[
                              Icon(Icons.alarm),
                              SizedBox(width: 10,),
                              Text(widget.timeselect[0],
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*22,color: PickCarColor.colorFont1), 
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 200,
                        child: RaisedButton(
                          color: widget.colorselect2,
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0),
                            side: BorderSide(color: PickCarColor.colormain)
                          ),
                          onPressed: (){
                            setState(() {
                              TimeSearch.time2 = !TimeSearch.time2;
                              if(TimeSearch.time2){
                                widget.colorselect2 = Colors.green[400];
                              }else{
                                widget.colorselect2 = Colors.white;
                              }
                            });
                          },
                          child:  Row(
                            children: <Widget>[
                              Icon(Icons.alarm),
                              SizedBox(width: 10,),
                              Text(widget.timeselect[1],
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*22,color: PickCarColor.colorFont1), 
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 200,
                        child: RaisedButton(
                          color: widget.colorselect3,
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0),
                            side: BorderSide(color: PickCarColor.colormain)
                          ),
                          onPressed: (){
                            setState(() {
                              TimeSearch.time3 = !TimeSearch.time3;
                              if(TimeSearch.time3){
                                widget.colorselect3 = Colors.green[400];
                              }else{
                                widget.colorselect3 = Colors.white;
                              }
                            });
                          },
                          child:  Row(
                            children: <Widget>[
                              Icon(Icons.alarm),
                              SizedBox(width: 10,),
                              Text(widget.timeselect[2],
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*22,color: PickCarColor.colorFont1), 
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 200,
                        child: RaisedButton(
                          color: widget.colorselect4,
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0),
                            side: BorderSide(color: PickCarColor.colormain)
                          ),
                          onPressed: (){
                            setState(() {
                              TimeSearch.time4 = !TimeSearch.time4;
                              if(TimeSearch.time4){
                                widget.colorselect4 = Colors.green[400];
                              }else{
                                widget.colorselect4 = Colors.white;
                              }
                            });
                          },
                          child:  Row(
                            children: <Widget>[
                              Icon(Icons.alarm),
                              SizedBox(width: 10,),
                              Text(widget.timeselect[3],
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*22,color: PickCarColor.colorFont1), 
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 200,
                        child: RaisedButton(
                          color: widget.colorselect5,
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0),
                            side: BorderSide(color: PickCarColor.colormain)
                          ),
                          onPressed: (){
                            setState(() {
                              TimeSearch.time5 = !TimeSearch.time5;
                              if(TimeSearch.time5){
                                widget.colorselect5 = Colors.green[400];
                              }else{
                                widget.colorselect5 = Colors.white;
                              }
                            });
                          },
                          child:  Row(
                            children: <Widget>[
                              Icon(Icons.alarm),
                              SizedBox(width: 10,),
                              Text(widget.timeselect[4],
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*22,color: PickCarColor.colorFont1), 
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 200,
                        child: RaisedButton(
                          color: widget.colorselect6,
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0),
                            side: BorderSide(color: PickCarColor.colormain)
                          ),
                          onPressed: (){
                            setState(() {
                              TimeSearch.time6 = !TimeSearch.time6;
                              if(TimeSearch.time6){
                                widget.colorselect6 = Colors.green[400];
                              }else{
                                widget.colorselect6 = Colors.white;
                              }
                            });
                          },
                          child:  Row(
                            children: <Widget>[
                              Icon(Icons.alarm),
                              SizedBox(width: 10,),
                              Text(widget.timeselect[5],
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*22,color: PickCarColor.colorFont1), 
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 120,
                        alignment:Alignment.center,
                        child: RaisedButton(
                          color: PickCarColor.colorbuttom,
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0),
                            side: BorderSide(color: PickCarColor.colormain)
                          ),
                          onPressed: (){
                            setState(() {
                              widget.colorselect1 = Colors.white;
                              widget.colorselect2 = Colors.white;
                              widget.colorselect3 = Colors.white;
                              widget.colorselect4 = Colors.white;
                              widget.colorselect5 = Colors.white;
                              widget.colorselect6 = Colors.white;
                              TimeSearch.time1 = false;
                              TimeSearch.time2 = false;
                              TimeSearch.time3 = false;
                              TimeSearch.time4 = false;
                              TimeSearch.time5 = false;
                              TimeSearch.time6 = false;
                            });
                          },
                          child: Text(UseString.reset,
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*22,color: Colors.white), 
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // actions: <Widget>[
                //   FlatButton(
                //     onPressed: () => Navigator.pop(context),
                //     child: Text(UseString.confirm),
                //   ),
                //   FlatButton(
                //     onPressed: () => Navigator.pop(context),
                //     child: Text(UseString.cancel),
                //   ),
                // ],
              );
            },
          );
        },
      );
    }
    final List<Tab> myTabs = <Tab>[
      new Tab(
        child: Container(
          margin: EdgeInsets.only(top: 10),
          child: Text(UseString.search,
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*20,color: PickCarColor.colormain), 
            ),
        ),
      ),
      new Tab(
        child: Container(
          margin: EdgeInsets.only(top: 10),
          child: Text(UseString.nearby,
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*20,color: PickCarColor.colormain), 
          ),
        ),
      ),
    ];
    TabController _tabController;
    _tabController = new TabController(vsync: this, length: myTabs.length,initialIndex: widget.indicatorpage);
    body(BuildContext context){
      if(widget.indicatorpage == 0){
        return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top:20,left: 10,right: 10),
                width: data.size.width,
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      child: Image.asset("assets/images/imagesearch/cardselect.png",fit: BoxFit.fill,)
                    ),
                    GestureDetector(
                      onTap: (){
                        showSearch(context: context,delegate:SearcUniversity());
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 40,left: 20,right: 20),
                        width: double.infinity,
                        child: Stack(
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              child: Image.asset("assets/images/imagesearch/search.png",fit: BoxFit.fill,),
                            ),
                            Container(
                              width: double.infinity,
                              margin:EdgeInsets.only(left: 25,top: 15),
                              child: Text(SearchString.university,
                                  style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*22,color: Colors.grey[700]), 
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              margin:EdgeInsets.only(left: 270,top: 15),
                              child: Icon(Icons.search,color: Colors.grey[700],),
                            ),
                          ],
                        )
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15,left: 20),
                      width: double.infinity,
                      child: Text(UseString.selectuniversity,
                          style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*22,color: PickCarColor.colorFont1), 
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top:5,left: 10,right: 10),
                width: data.size.width,
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      child: Image.asset("assets/images/imagesearch/cardselect.png",fit: BoxFit.fill,)
                    ),
                    GestureDetector(
                      onTap: (){
                        if(SearchString.university != UseString.universityhint){
                          showSearch(context: context,delegate:SearcLocation());
                        }else{
                          showalertuni(context);
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 40,left: 20,right: 20),
                        width: double.infinity,
                        child: Stack(
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              child: Image.asset("assets/images/imagesearch/search.png",fit: BoxFit.fill,),
                            ),
                            Container(
                              width: double.infinity,
                              margin:EdgeInsets.only(left: 25,top: 15),
                              child: Text(SearchString.location,
                                  style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*22,color: Colors.grey[700]), 
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              margin:EdgeInsets.only(left: 270,top: 15),
                              child: Icon(Icons.search,color: Colors.grey[700],),
                            ),
                          ],
                        )
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15,left: 20),
                      width: double.infinity,
                      child: Text(UseString.selectlocation,
                          style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*22,color: PickCarColor.colorFont1), 
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top:5,left: 10,right: 10),
                width: data.size.width,
                height: 265,
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: Image.asset("assets/images/imagesearch/backdate.png",fit: BoxFit.fill,)
                    ),
                    GestureDetector(
                      onTap: (){
                        print('aaa');
                        // selectday(context);
                        showDatePicker(
                          context: context,
                          initialDate: TimeSearch.today,
                          firstDate: TimeSearch.yesterday,
                          lastDate: TimeSearch.nextmonth,
                        ).then((data){
                          setState(() {
                            if(data != null){
                              TimeSearch.today = data;
                            }
                          });
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(top:45,left: 120),
                        width: 150,
                        height: 130,
                        child: Stack(
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              height: double.infinity,
                              child: Image.asset("assets/images/imagesearch/calender.png",fit: BoxFit.fill,),
                            ),
                            Container(
                              width: double.infinity,
                              height: 34,
                              // color: Colors.black,
                              alignment:  Alignment.center,
                              child: Text(monthy(TimeSearch.today.month) + ' | ' + TimeSearch.today.year.toString(),
                                style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*22,color: Colors.white), 
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              // color: Colors.black,
                              margin: EdgeInsets.only(top: 30),
                              alignment:  Alignment.center,
                              child: Text(TimeSearch.today.day.toString(),
                                style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*80,color: PickCarColor.colorFont1), 
                              ),
                            ),
                          ],
                        )
                      ),
                    ),
                    // GestureDetector(
                    //   onTap: (){
                    //     if(SearchString.university != UseString.universityhint){
                    //       showSearch(context: context,delegate:SearcLocation());
                    //     }else{
                    //       showalertuni(context);
                    //     }
                    //   },
                    //   child: Container(
                    //     margin: EdgeInsets.only(top: 40,left: 20,right: 20),
                    //     width: double.infinity,
                    //     child: Stack(
                    //       children: <Widget>[
                    //         Container(
                    //           width: double.infinity,
                    //           child: Image.asset("assets/images/imagesearch/search.png",fit: BoxFit.fill,),
                    //         ),
                    //         Container(
                    //           width: double.infinity,
                    //           margin:EdgeInsets.only(left: 25,top: 15),
                    //           child: Text(SearchString.location,
                    //               style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*22,color: Colors.grey[700]), 
                    //           ),
                    //         ),
                    //         Container(
                    //           width: double.infinity,
                    //           margin:EdgeInsets.only(left: 270,top: 15),
                    //           child: Icon(Icons.search,color: Colors.grey[700],),
                    //         ),
                    //       ],
                    //     )
                    //   ),
                    // ),
                    Container(
                      margin: EdgeInsets.only(top:180,left: 121),
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          // borderRadius: new BorderRadius.circular(12.0),
                          side: BorderSide(color: Colors.black)
                        ),
                        onPressed: (){
                          selecttime(context);
                        },
                        child: Text(UseString.selecttime,
                          style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*22,color: PickCarColor.colorFont1), 
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15,left: 20),
                      width: double.infinity,
                      child: Text(UseString.selectlocation,
                          style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*22,color: PickCarColor.colorFont1), 
                      ),
                    ),
                  ],
                ),
              ),
              RaisedButton(
                color: PickCarColor.colorbuttom,
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(13.0),
                  // side: BorderSide(color: PickCarColor.colormain)
                ),
                onPressed: (){
                  if(SearchString.location != UseString.locationhint && SearchString.university != UseString.universityhint){
                    Navigator.of(context).pushNamed(Datamanager.listcar);
                  }else  if(SearchString.location == UseString.locationhint &&SearchString.university != UseString.universityhint){
                    showalertlo(context);
                  }else{
                    showalertall(context);
                  }
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: Text(UseString.find,
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*25,color: Colors.white), 
                    ),
                ),
              ),
              SizedBox(height: 15,),
              // SizedBox(height: 20,),
              // RaisedButton(
              //   onPressed: (){
              //     Navigator.of(context).pushNamed(Datamanager.selectUniversity);
              //     // Navigator.of(context).pushNamed(Datamanager.detailsearch);
              //   },
              //   child: Text("goto place"),
              // ),
            ],
          ),
        );
      }else{
        return Container();
      }
    }
    // print(Datamanager.universityshow.listplacebox);
    // print(Datamanager.listUniversity);
    // print(Datamanager.universityshow);
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
                print(widget.indicatorpage);
                widget.i =0;
              });
            },
          ),
        title: Text(UseString.logo,
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
class SearcUniversity extends SearchDelegate<String> {
  // final data = ["asssssd","b"];
  // final suggest = ["cadad","d"];
  final data = Datamanager.listUniversity;
  final suggest = Datamanager.listUniversity;
  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(
        icon: Icon(Icons.clear),
        onPressed:(){
          query ='';
        },
      )];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // SearchString.university = UseString.universityhint;
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: (){
        SearchString.university = UseString.universityhint;
        SearchString.location = UseString.locationhint;
        close(context,null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    var data = MediaQuery.of(context);
    var index = Datamanager.listUniversity.indexOf(query);
    if(index != -1){
      SearchString.university = Datamanager.listUniversity[index];
      close(context,null);
      return Container();
    }else{
      query ="";
      return Center(
        child: Text(UseString.notfound,
            style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*30,color: PickCarColor.colorFont1), 
         ),
      );
    }
    
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty ? suggest
        :data.where((p) => p.startsWith(query)).toList();
    return ListView.builder(
      itemBuilder: (context,index){
        return ListTile(
          onTap: (){
            // showResults(context);
            SearchString.university = Datamanager.listUniversity[index];
            close(context,null);
            // print(index);
          },
          leading: Icon(Icons.location_city),
          title: RichText(
            text: TextSpan(
              text: suggestionList[index].substring(0,query.length),
              style: TextStyle(
                color: Colors.black,fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: suggestionList[index].substring(query.length),
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        );
      },
      itemCount: suggestionList.length,
    );
  }

}
class SearcLocation extends SearchDelegate<String> {
  // final data = ["asssssd","b"];
  // final suggest = ["cadad","d"];
  List<dynamic> data = [];
  List<dynamic> suggest = [];
  fetchdata(){
    for(var i in Datamanager.universityshow){
      if(i.universityname == SearchString.university){
        data = i.listplacelocation;
        suggest = i.listplacelocation;
      }
    }
  }
  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(
        icon: Icon(Icons.clear),
        onPressed:(){
          query ='';
        },
      )];
  }

  @override
  Widget buildLeading(BuildContext context) {
    fetchdata();
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: (){
        SearchString.location = UseString.locationhint;
        close(context,null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    var data = MediaQuery.of(context);
    var index = suggest.indexOf(query);
    if(index != -1){
      SearchString.university = suggest[index];
      close(context,null);
      return Container();
    }else{
      return Center(
        child: Text(UseString.notfound,
            style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*30,color: PickCarColor.colorFont1), 
         ),
      );
    }
    
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty ? suggest
        :data.where((p) => p.startsWith(query)).toList();
    return ListView.builder(
      itemBuilder: (context,index){
        return ListTile(
          onTap: (){
            // showResults(context);
            SearchString.location = suggest[index];
            close(context,null);
            // print(index);
          },
          leading: Icon(Icons.location_city),
          title: RichText(
            text: TextSpan(
              text: suggestionList[index].substring(0,query.length),
              style: TextStyle(
                color: Colors.black,fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: suggestionList[index].substring(query.length),
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        );
      },
      itemCount: suggestionList.length,
    );
  }

}

// Center(
//         child: Column(
//           children: <Widget>[
//             Text("ChatPage"),
//             RaisedButton(
//               onPressed: (){
//                 Navigator.of(context).pushNamed(Datamanager.listcar);
//                 // Navigator.of(context).pushNamed(Datamanager.detailsearch);
//               },
//               child: Text("search"),
//             ),
//             SizedBox(height: 20,),
//             RaisedButton(
//               onPressed: (){
//                 Navigator.of(context).pushNamed(Datamanager.boxselectadmin);
//                 // Navigator.of(context).pushNamed(Datamanager.detailsearch);
//               },
//               child: Text("goto box"),
//             ),
//             SizedBox(height: 20,),
//             RaisedButton(
//               onPressed: (){
//                 Navigator.of(context).pushNamed(Datamanager.placeselectadmin);
//                 // Navigator.of(context).pushNamed(Datamanager.detailsearch);
//               },
//               child: Text("goto place"),
//             ),
//             SizedBox(height: 20,),
//             RaisedButton(
//               onPressed: (){
//                 Navigator.of(context).pushNamed(Datamanager.mapaddmark);
//                 // Navigator.of(context).pushNamed(Datamanager.detailsearch);
//               },
//               child: Text("goto add mark"),
//             ),
//             SizedBox(height: 20,),
//             RaisedButton(
//               onPressed: (){
//                 Navigator.of(context).pushNamed(Datamanager.registerMap);
//                 // Navigator.of(context).pushNamed(Datamanager.detailsearch);
//               },
//               child: Text("register map"),
//             ),
//             SizedBox(height: 20,),
//             RaisedButton(
//               onPressed: (){
//                 Navigator.of(context).pushNamed(Datamanager.mapplaceselect);
//                 // Navigator.of(context).pushNamed(Datamanager.detailsearch);
//               },
//               child: Text("mapplaceselect"),
//             ),
//           ],
//         ),
//       ),

