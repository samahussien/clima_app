import 'package:clima/screens/city_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class LocationScreen extends StatefulWidget {
  final dynamic locationWeather;

  const LocationScreen({Key? key, this.locationWeather}) : super(key: key);
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();
  late double temp;
  late int id;
   String inText ='';
  late String cityName;
  late String icon;
  late String message;
  void updateUi(weatherData) {
    setState(() {
      if (weatherData == null) {
        temp = 0;
        icon = 'error';
        message = 'unable to get data';
        cityName = '';
        return;
      }
inText='in';
      temp = weatherData['main']['temp'];
      id = weatherData['weather'][0]['id'];
      cityName = weatherData['name'];
      WeatherModel weatherModel = WeatherModel();
      icon = weatherModel.getWeatherIcon(temp.toInt());
      message = weatherModel.getMessage(temp.toInt());
    });
  }

  @override
  void initState() {
    updateUi(widget.locationWeather);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    onPressed: () async {
                      var weatherData = await weatherModel.getLocationWeather();
                      updateUi(weatherData);
                    },
                    padding: const EdgeInsets.only(left: 15),
                    icon: const Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  IconButton(
                    padding: const EdgeInsets.only(right: 15),
                    onPressed: () async{
                   var typedName= await  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CityScreen()));
               if(typedName!=null) {
               var weatherData= await   weatherModel.getCityWeather(typedName);
               updateUi(weatherData);
                      }
                    },
                    icon: const Icon(
                      Icons.location_city,
                      color: Colors.white,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      temp.round().toString(),
                      style: kTempTextStyle,
                    ),
                    Text(
                      icon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(
                  '$message $inText $cityName',
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
