import 'package:flutter_weather_app/services/location.dart';
import 'network.dart';
  const apiKey = '8771b7a8cf303fde2792cbc8fb0ce646';
// const apiKey = 'a1229a6169b9ca8fa751980e7917fae5';
const openWeatherMapURL = 'http://v.juhe.cn/weather/geo';
const openCityWeatherMapURL = 'http://v.juhe.cn/weather/index';
class WeatherModel {
  //http://v.juhe.cn/weather/index?format=2&cityname=%E8%8B%8F%E5%B7%9E&key=您申请的KEY
  Future<dynamic> getCityWeather(String cityName) async{
    NetworkHelper networkHelper = NetworkHelper('$openCityWeatherMapURL?format=1&key=$apiKey&cityname=$cityName&dtype=json');
    var weatherData =await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async{
    Location location = Location();
    await location.getCurrentLocation();
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?format=2&key=$apiKey&dtype=json&lat=${location.latitude}&lon=${location.longitude}');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return '好热,现在适合吃冰淇淋！';
    } else if (temp > 20) {
      return '适合穿短袖T恤 ';
    } else if (temp <= 10) {
      return '好冷,戴上围巾和手套吧';
    } else {
      return '温度宜人，开心玩耍吧';
    }
  }
}
