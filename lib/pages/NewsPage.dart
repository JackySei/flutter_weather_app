import 'package:flutter/material.dart';
import 'package:flutter_weather_app/services/DatabaseHelper.dart';
class NewsPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NewsPage();
  }
}
class MyListView extends StatelessWidget {
  String title;
  MyListView(this.title);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          children: <Widget>[
            Container(
              height: 53,
              child: _mineItem(title),
            ),
            Container(
              color: Color(0xffeaeaea),
              constraints: BoxConstraints.expand(height: 1.0),
            ),
          ],
        )
    );
  }

  Widget _mineItem(String title) {
    return InkWell(
      onTap: (){

      },
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
                padding: EdgeInsets.only(left: 16),
                child: Icon(Icons.access_time)
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                title,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: Icon(
                Icons.brightness_5,
                size: 20,
                color: Colors.grey,
              ),
            ),
          )
        ],
      ),
    );
  }
}
class _NewsPage extends State<NewsPage> {
   String goal;
   List widgets=[];

   @override
  void initState() {
     super.initState();
     DatabaseHelper.instance.queryAllRows().then((value) {
       setState(() {
         value.forEach((element) {
           widgets.add(element['goalText']);
         });
       });
     }).catchError((onError){
       print(onError);
     });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff343434),
        leading: Icon(Icons.library_books,color: Colors.white,),
        title: Text("今日目标"),),
      body:Column(
        children: [
          Container(
            padding: EdgeInsets.all(20.0),
            child: new TextField(
              style: TextStyle(
                color: Colors.black,
              ), //TextStyle
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                icon: Icon(
                  Icons.location_city,
                  color: Colors.black,
                ), //Icon
                hintText: '输入今天的目标吧！',
                hintStyle: TextStyle(
                  color: Colors.grey,
                ), //TextStyle
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value){
                 goal=value;
              },
            ),
          ),
          FlatButton(
             color: Colors.black,
            onPressed: () {
              setState(() {
                if(goal!=""){
                  widgets.add(goal);
                  DatabaseHelper.instance.insert(new Goal(goalText: goal));
                }
              });
            },
            child: Text(
              '设定目标！',
              style: TextStyle(
                fontSize: 15,
                  fontStyle: FontStyle.italic,
                color: Colors.white
              ),
              //style: kButtonTextStyle,
            ),
          ),
          Expanded(
                child:new ListView.builder(
                  itemCount: widgets.length,
                  itemBuilder:(context,index){
                    // return ListTile(
                    //   leading: new Icon(Icons.access_time),
                    //   title: Text('${widgets[index]}'),
                    // );
                    return new MyListView(widgets[index]);
                  },
                ),
              )
        ],
      ),
    );
  }
}