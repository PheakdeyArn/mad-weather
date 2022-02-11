import 'package:flutter/material.dart';
import '../models/forcast.dart';
import '../models/location.dart';
import '../models/weather.dart';
import '../utils/colors.dart';
import '../utils/providers.dart';
import '../widgets/weather_box.dart';
import '../widgets/forecast_hourly.dart';
import '../widgets/forecast_daily.dart';


class CurrentWeather extends StatefulWidget {
  final List<Location> locations;

  const CurrentWeather({Key? key, required this.locations}): super(key: key);

  @override
  _CurrentWeatherState createState() => _CurrentWeatherState(locations);
}

class _CurrentWeatherState extends State<CurrentWeather> {
  final List<Location> locations;
  final Location location;

  _CurrentWeatherState(this.locations)
      : location = locations[0];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: secondaryColor,
          title:  Text(location.city),
        ),
        body:
          ListView(
            children: [
              currentWeatherViews(location),
              forecastHourlyViews(location),
              forecastDailyViews(location),
            ],
          )
    );
  }

  // Create Forecast Weather View
  Widget forecastHourlyViews (Location location){
    Forecast? _forecast;

    return FutureBuilder(
        future: Providers.getForecast(location),
        builder: (context, AsyncSnapshot<Forecast?> snapshot){
          if (snapshot.hasData){
            _forecast = snapshot.data;

            if (_forecast == null){
              return const Text("Error fetching Forecast");
            } else {
              return Column (
                  children: [
                    Container (
                        margin: const EdgeInsets.all(5.0),
                        child: ForecastHourly(forecast: _forecast!)
                    )
                  ]
              );
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }
    );
  }

  Widget forecastDailyViews (Location location){
    Forecast? _forecast;

    return FutureBuilder(
        future: Providers.getForecast(location),

        builder: (context, AsyncSnapshot<Forecast?> snapshot){
          if (snapshot.hasData){
            _forecast = snapshot.data;

            if (_forecast == null){
              return const Text("Error fetching Forcast");
            } else {
              return Column (
                  children: [
                    Container (
                        margin: const EdgeInsets.all(5.0),
                        child: ForecastDaily(forecast: _forecast!)
                    )
                  ]
              );
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }
    );
  }

  // Create Current Weather View Widget
  Widget currentWeatherViews (Location location) {
    Weather? _weather;

    return FutureBuilder(
      future: Providers.getCurrentWeather(location),
      builder: (context, AsyncSnapshot<Weather?> snapshot) {
        if (snapshot.hasData){
          _weather = snapshot.data;
          if (_weather == null){
            return const Text("Error fetching weather");
          } else {
            return  Column(
              children: [
                WeatherBox(weather: _weather!),
              ],
            );
          }
        }else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

