import 'package:flutter/material.dart';

import 'NewsPage.dart';
import 'location_screen.dart';
import 'my_page.dart';

class AppHome extends StatefulWidget {
  AppHome({this.locationWeather});
  final locationWeather;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePageState();
  }
}

class _HomePageState extends State<AppHome>{

  int _currentIndex=0;
  List<Widget> _widgets=List();
  @override
  void initState() {
    super.initState();
    _widgets.add(LocationScreen(locationWeather: widget.locationWeather,));
    _widgets.add(NewsPage());
    _widgets.add(MyPage());
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _widgets,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.wb_sunny),title: Text("今日天气")
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.library_books),title: Text("今日目标")
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),title: Text("关于我的")
          )
        ],
        currentIndex: _currentIndex,
        onTap: _itemTapped,
      ),
    );
  }
  void _itemTapped (int index){
    setState(() {
      _currentIndex=index;
    });
  }
}


