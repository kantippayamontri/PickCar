import 'package:flutter/material.dart';
import 'package:pickcar/datamanager.dart';

class SearchPage extends StatefulWidget {
  int indicatorpage = 0;
  int i =0;
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with TickerProviderStateMixin {
  void initState(){
    SearchString.university = UseString.universityhint;
    SearchString.location = UseString.locationhint;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var data = MediaQuery.of(context);
    
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
        return Column(
          children: <Widget>[
            GestureDetector(
              onTap: (){
                showSearch(context: context,delegate:SearcUniversity());
              },
              child: Container(
                margin: EdgeInsets.only(top:20,left: 10,right: 10),
                width: data.size.width,
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      child: Image.asset("assets/images/imagesearch/cardselect.png",fit: BoxFit.fill,)
                    ),
                    Container(
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
            ),
            GestureDetector(
              onTap: (){
                
              },
              child: Container(
                margin: EdgeInsets.only(top:5,left: 10,right: 10),
                width: data.size.width,
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      child: Image.asset("assets/images/imagesearch/cardselect.png",fit: BoxFit.fill,)
                    ),
                    Container(
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
            ),
            SizedBox(height: 20,),
            RaisedButton(
              onPressed: (){
                Navigator.of(context).pushNamed(Datamanager.selectUniversity);
                // Navigator.of(context).pushNamed(Datamanager.detailsearch);
              },
              child: Text("goto place"),
            ),
          ],
        );
      }else{
        return Container();
      }
    }
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
  final data = ["asssssd","b"];
  final suggest = ["cadad","d"];
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
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: (){
        close(context,null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    var data = MediaQuery.of(context);
    var index = Datasearch.placelocationname.indexOf(query);
    if(index != -1){
      Datasearch.placelocationindex = index;
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
            Datasearch.placelocationindex = index;
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

