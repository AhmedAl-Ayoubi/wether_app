import 'package:weather_app/services/location.dart';

import '../utilities/constants.dart';
import 'networking.dart';

class WeatherModel {
  late double temp;
  late int weatherId;
  late String name;
 // late String city;

  Future<void> getCurrentLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    Map<String, dynamic> weatherInfo = await NetworkHelper(
      url: 'https://api.openweathermap.org/data/2.5/weather?'
          'lat=${location.lat}&lon=${location.long}'
          '&appid=$kApiKey&units=metric',
    ).getData();

    temp = weatherInfo['main']['temp'];
    weatherId = weatherInfo['weather'][0]['id'];
    name = weatherInfo['name'];
  }


  Future<void> getCurrentLocationWeatherSelected(String c) async {
    Location location = Location();
    await location.getCurrentLocation();

    Map<String, dynamic> weatherInfo = await NetworkHelper(
      url: 'https://api.openweathermap.org/data/2.5/weather?'
          'q=$c&appid=70eb96a081ea9ad1626f9b1d5d80422d&units=metric',
    ).getData();

    temp = weatherInfo['main']['temp'];
    weatherId = weatherInfo['weather'][0]['id'];
    name = weatherInfo['name'];
  }

  String getWeatherIcon() {
    if (weatherId < 300) {
      return '🌩';
    } else if (weatherId < 400) {
      return '🌧';
    } else if (weatherId < 600) {
      return '☔️';
    } else if (weatherId < 700) {
      return '☃️';
    } else if (weatherId < 800) {
      return '🌫';
    } else if (weatherId == 800) {
      return '☀️';
    } else if (weatherId <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage() {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
