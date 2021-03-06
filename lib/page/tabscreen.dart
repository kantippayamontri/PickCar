import 'package:flutter/material.dart';
import 'package:pickcar/datamanager.dart';
import 'package:pickcar/widget/cancel.dart';

class TabScreenPage extends StatefulWidget {
  @override
  _TabScreenPageState createState() => _TabScreenPageState();
}

class _TabScreenPageState extends State<TabScreenPage> {
  int _selecedindex = 0;

  @override
  void initState() {

    Datamanager.gontosearchinHome = _gotosearchpageinHome;
    try{
      Realtime.checkalert.cancel();
    }catch(e){}
    
    super.initState();
  }

  void _selectedtab(int index) {
    setState(() {
      _selecedindex = index;
    });
  }

  void _gotosearchpageinHome(){
    setState(() {
      _selecedindex = 1;
    });
  }

  void dispose() {
    Realtime.checkalert.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    cancelshow(context);
    return Scaffold(
      body: Datamanager.pages[_selecedindex]['page'],
      bottomNavigationBar: BottomNavigationBar(
      // fixedColor: Colors.white,
      backgroundColor: Colors.white,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text(UseString.navhome),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          title: Text(UseString.chat),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          title: Text(UseString.navlist),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.assignment_ind),
          title: Text(UseString.navprofile),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          title: Text(UseString.navsetting),
        ),
      ],
      currentIndex: _selecedindex,
      selectedItemColor: Color.fromRGBO(33, 197, 155, 1),
      onTap: (index) => _selectedtab(index),
      type: BottomNavigationBarType.fixed,
      
    ),
    );
  }
}
