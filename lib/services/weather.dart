import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/utilities/constants.dart';

class WeatherModel {
  double longitude;
  double latitude;

  Future<dynamic> getcityweather(String cityname) async {
    Networkhelper networkhelper = Networkhelper(
        'https://api.openweathermap.org/data/2.5/weather?q=$cityname&appid=$apikey&units=metric');

    var weatherdata = await networkhelper.getdata();
    return weatherdata;
  }

  Future<dynamic> getweather() async {
    Location location = Location();
    await location.getcurrentlocation();
    longitude = location.longitude;
    latitude = location.latitude;
    Networkhelper networkhelper = Networkhelper(
        'https://api.openweathermap.org/data/2.5/onecall?lat=$latitude&lon=$longitude&appid=$apikey&units=metric');

    var weatherdata = await networkhelper.getdata();
    return weatherdata;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '๐ฉ';
    } else if (condition < 400) {
      return '๐ง';
    } else if (condition < 600) {
      return 'โ๏ธ';
    } else if (condition < 700) {
      return 'โ๏ธ';
    } else if (condition < 800) {
      return '๐ซ';
    } else if (condition == 800) {
      return 'โ๏ธ';
    } else if (condition <= 804) {
      return 'โ๏ธ';
    } else {
      return '๐คทโ';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s ๐ฆ time';
    } else if (temp > 20) {
      return 'Time for shorts and ๐';
    } else if (temp < 10) {
      return 'You\'ll need ๐งฃ and ๐งค';
    } else {
      return 'Bring a ๐งฅ just in case';
    }
  }
}
