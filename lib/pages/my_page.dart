import 'package:flutter/material.dart';
class MyPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    String msg = "天气在日常中扮演着重要的角色。有时天气的好坏会影响一天的行程与安排，或者一天的心情，因此及时的获取天气信息就显得尤为重要。设计这个app的目的是为了方便查到当天的天气和设定当天的目标，元气满满的开始新一天！"
        "不仅可以作为作业还可以在日常生活中反复使用,简单实用。";
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff343434),
          leading: Icon(Icons.person,color: Colors.white,),
          title: Text("关于我的",style: TextStyle(fontSize: 18,color: Colors.white),),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(msg,style: TextStyle(color: Color(0xff555555),fontSize: 14)),
            ],
          ),
        )
    );
  }

}