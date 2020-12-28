import 'package:flutter/material.dart';
import 'package:flutter_weather_app/services/weather.dart';
import 'home.dart';

class WelcomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _WelcomePage();
  }
}

class _WelcomePage extends State<WelcomePage>{
  @override
  Widget build(BuildContext context) {
    void getLocationData() async {
      var weatherData = await WeatherModel().getLocationWeather();
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
        return AppHome(
          locationWeather: weatherData,
        );
      }), (route) => false);
    }

    // TODO: implement build
    Future.delayed(Duration(seconds: 2),(){
      getLocationData();
    });
    return Scaffold(
      body: Container(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Text("")),
              Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Image(image: AssetImage("assets/images/welcome.png")),
                      Text("Welcome To Weather App",style: TextStyle(fontSize: 26,color: Colors.blue,fontStyle: FontStyle.italic))
                    ],
                  )),
            ],
          )
      ),
    );
  }

}


