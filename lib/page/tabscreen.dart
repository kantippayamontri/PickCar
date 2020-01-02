import 'package:flutter/material.dart';
import 'package:pickcar/datamanager.dart';

class TabScreenPage extends StatefulWidget {
  @override
  _TabScreenPageState createState() => _TabScreenPageState();
}

class _TabScreenPageState extends State<TabScreenPage> {
  int _selecedindex = 0;

  @override
  void initState() {
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
      body: Datamanager.pages[_selecedindex]['page'],
      bottomNavigationBar: BottomNavigationBar(
      // fixedColor: Colors.white,
      backgroundColor: Colors.white,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('Home'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          title: Text('Search'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          title: Text('List'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.assignment_ind),
          title: Text('Profile'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          title: Text('Setting'),
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
