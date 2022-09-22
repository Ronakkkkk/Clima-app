import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen(this.locationweather);
  final locationweather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  int temperature;
  String weathercondition;
  String cityname;
  String comment;

  @override
  void initState() {
    super.initState();
    updateuilocationweather(widget.locationweather);
  }

  void updateuicityweather(weatherdata) {
    setState(() {
      if (weatherdata == null) {
        temperature = 0;
        weathercondition = 'error';
        comment = 'Unable to fetch the error';
        cityname = '';
        return;
      }
      double temp = weatherdata['main']['temp'];
      temperature = temp.toInt();
      var condition = weatherdata['weather'][0]['id'];
      weathercondition = weather.getWeatherIcon(condition);
      comment = weather.getMessage(temperature);
    });
  }

  void updateuilocationweather(weatherdata) {
    setState(() {
      if (weatherdata == null) {
        temperature = 0;
        weathercondition = 'error';
        comment = 'Unable to fetch the error';
        cityname = '';
        return;
      }
      double temp = weatherdata['current']['temp'];
      temperature = temp.toInt();
      var condition = weatherdata['current']['weather'][0]['id'];
      weathercondition = weather.getWeatherIcon(condition);
      cityname = weatherdata['timezone'];
      comment = weather.getMessage(temperature);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var weatherdata = await weather.getweather();
                      updateuilocationweather(weatherdata);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var typedname = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
                          },
                        ),
                      );
                      if (typedname != null) {
                        var weatherdata =
                            await weather.getcityweather(typedname);
                        cityname = typedname;
                        updateuicityweather(weatherdata);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
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
                      '$weathercondition',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$comment in $cityname',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
