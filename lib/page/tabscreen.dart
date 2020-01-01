import 'package:flutter/material.dart';
import 'package:pickcar/datamanager.dart';
import 'package:pickcar/page/chatpage.dart';
import 'package:pickcar/page/homepage.dart';
import 'package:pickcar/page/listcarpage.dart';
import 'package:pickcar/page/profilepage.dart';
import 'package:pickcar/page/settingpage.dart';

class TabScreenPage extends StatefulWidget {
  @override
  _TabScreenPageState createState() => _TabScreenPageState();
}

class _TabScreenPageState extends State<TabScreenPage> {
  int _selecedindex = 0;
  List<Map<String, Object>> _pages;

  @override
  void initState() {
    // TODO: implement initState
    _pages = [
      {'page': HomePage(), 'title': 'Home'},
      {'page': ChatPage(), 'title': 'Chat'},
      {'page': ListCarPage(), 'title': 'ListCar'},
      {'page': ProfilePage(), 'title': 'Profile'},
      {'page': SettingPage(), 'title': 'setting'},
    ];
    super.initState();
  }

  void _selectedtab(int index) {
    setState(() {
      _selecedindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selecedindex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => _selectedtab(index),
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.white,
        selectedItemColor: PickCarColor.colormain,
        currentIndex: _selecedindex,
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Colors.yellow,
            title: Text("1"),
             icon: Icon(Icons.category),
          ),
          BottomNavigationBarItem(
            backgroundColor:  Colors.yellow,
            title: Text("2"),
             icon: Icon(Icons.category),
          ),
          BottomNavigationBarItem(
            backgroundColor:  Colors.yellow,
            title: Text("3"),
             icon: Icon(Icons.category),
          ),
          BottomNavigationBarItem(
            backgroundColor:  Colors.yellow,
            title: Text("4"),
             icon: Icon(Icons.category),
          ),
          BottomNavigationBarItem(
            backgroundColor:  Colors.yellow,
            title: Text("5"),
             icon: Icon(Icons.category),
          ),
        ],
      ),
    );
  }
}
