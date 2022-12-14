import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
const apiKey = 'e1964fbd323709fde8b4adcda8f9f7ea';
const openWeatherMapUrl='https://api.openweathermap.org/data/2.5/weather';
class WeatherModel {
  Future<dynamic> getCityWeather(String cityName)async{

    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapUrl?q=$cityName&units=metric&appid=$apiKey');
    var weatherData = await networkHelper.getDate();
    // print(weatherData);
    return weatherData;
  }
  Future<dynamic> getLocationWeather()async{
    Location location = Location();
    await location.getLocation();
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapUrl?lat=${location.latitude}&lon=${location.longitude}&units=metric&appid=$apiKey');
    var weatherData = await networkHelper.getDate();
return weatherData;
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