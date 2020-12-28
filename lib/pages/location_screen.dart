import 'package:flutter/material.dart';
import 'package:flutter_weather_app/services/weather.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../type.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {

  LocationScreen({this.locationWeather});
  final locationWeather;
  @override
  _LocationScreenState createState() => _LocationScreenState();

}
class _LocationScreenState extends State<LocationScreen> {

  WeatherModel weather = WeatherModel();
  String temperature;
  String condition;
  String cityName;
  String imgId="assets/images/init.JPG";
  String weatherMessage;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  Future<void> updateUI(dynamic weatherData) async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    prefs.setString('temperature', "∅");
    prefs.setString('condition', "未知");
    prefs.setString('weatherMessage', "没有查到天气");
    prefs.setString('cityName', '绵阳');
    prefs.setString('imgId', 'assets/images/init.JPG');
    setState(()  {
      if(weatherData=="empty"||weatherData['result']==null){
        temperature = prefs.get('temperature');
        condition = prefs.get('condition');
        weatherMessage = prefs.get('weatherMessage');
        cityName = prefs.get('cityName');
        imgId=prefs.get('imgId');
      }
      else {
        var result = weatherData['result'];
        var sk = result['sk'];
        var today = result['today'];
        temperature = sk['temp'];
        cityName = weatherData['result']['today']['city'];
        condition = today['weather'];
        weatherMessage = weather.getMessage(int.parse(temperature));
        if(condition.contains("雨")){
          imgId="assets/images/rain.jpg";
        }else if(condition.contains("晴")){
          imgId="assets/images/qing.png";
        } else if(condition.contains("多云")){
          imgId="assets/images/duoyun.png";
        }
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.wb_sunny,color: Colors.white,),
        title: Text("今日天气"),
        backgroundColor: Color(0xff343434),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imgId==null?'assets/images/init.JPG':imgId),
            fit: BoxFit.cover,
          ),
        ),
        //constraints: BoxConstraints.expand(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton(
                  onPressed: () async {
                    var weatherData = await weather.getLocationWeather();
                    updateUI(weatherData);
                  },
                  child: Icon(
                    Icons.near_me,
                    color: Colors.white,
                    size: 50.0,
                  ),
                ),
                FlatButton(
                  onPressed: () async{
                    var typedName =await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return CityScreen();
                        },
                      ),
                    );
                    if(typedName!=null){
                      var weatherData = await weather.getCityWeather(typedName);
                      updateUI(weatherData);
                    }
                  },
                  child: Icon(
                    Icons.location_city,
                    color: Colors.white,
                    size: 50.0,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Row(
                children: <Widget>[
                  Text(
                    '$temperature°',
                    style: kTempTextStyle,
                  ),
                  Text(
                    condition,
                    style: kConditionTextStyle,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 15.0),
              child: Text(
                '$weatherMessage in $cityName',
                textAlign: TextAlign.right,
                style: kMessageTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
