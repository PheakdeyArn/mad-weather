import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/weather.dart';
import '../models/location.dart';
import '../models/forcast.dart';
import '../utils/constants.dart';


class Providers {

  static Future<Weather?> getCurrentWeather(Location location) async {
    Weather? weather;
    String currentWeatherUrl = "$openWeatherUrl?q=${location.city}&appid=$apiKey";

    Uri url = Uri.parse(currentWeatherUrl);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      weather = Weather.fromJson(jsonDecode(response.body));
    }

    return weather;
  }

  static Future<Forecast?> getForecast(Location location) async {
    Forecast? forecast;
    String forecastUrl =
        "https://api.openweathermap.org/data/2.5/onecall?lat=${location.lat}&lon=${location.lon}&appid=$apiKey&units=metric";

    Uri url = Uri.parse(forecastUrl);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      forecast = Forecast.fromJson(jsonDecode(response.body));
    }

    return forecast;
  }

  static Future<Location?> getLocation(String city) async {
    Location? location;
    String currentWeatherUrl = "$openWeatherUrl?q=$city&appid=$apiKey";

    Uri url = Uri.parse(currentWeatherUrl);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      location = Location.fromJson(jsonDecode(response.body));
    }

    return location;
  }

  static Future<List<Location>> getListLocations () async {
    List<Location> locations = [];

    String url = 'http://192.168.1.19:8000/location/';

    Uri getLocations = Uri.parse(url);
    final response = await http.get(getLocations);

    if (response.statusCode == 200) {
      var data = response.body;
      locations = (data as List).map((data) => Location.fromDjango(data)).toList();
    }

    return locations;
  }

}
