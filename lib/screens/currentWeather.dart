import 'package:flutter/material.dart';
import '../models/forcast.dart';
import '../models/location.dart';
import '../models/weather.dart';
import '../utils/colors.dart';
import '../utils/helpers.dart';
import '../utils/providers.dart';
import '../widgets/weather_box.dart';


class CurrentWeather extends StatefulWidget {
  final List<Location> locations;
  final BuildContext context;

  const CurrentWeather(this.locations, this.context);

  @override
  _CurrentWeatherState createState() => _CurrentWeatherState(this.locations, this.context);
}

class _CurrentWeatherState extends State<CurrentWeather> {
  final List<Location> locations;
  final Location location;
  final BuildContext context;

  _CurrentWeatherState(this.locations, this.context)
      : location = locations[0];

  @override
  Widget build(BuildContext context) {

    final ButtonStyle style =
    ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

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
                        child: forecastHourlySection(_forecast!)
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
                        child: dailyBoxes(_forecast!)
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

  Widget dailyBoxes(Forecast _forecast) {
    return Expanded(
        child: ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.only(left: 8, top: 0, bottom: 0, right: 8),
            itemCount: _forecast.daily.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  padding: const EdgeInsets.only(
                      left: 10, top: 5, bottom: 5, right: 10),
                  margin: const EdgeInsets.all(5),
                  child: Row(children: [
                    Expanded(
                        child: Text(
                          Helpers.getDateFromTimestamp(_forecast.daily[index].dt),
                          style: const TextStyle(fontSize: 14, color: Colors.black),
                        )),
                    Expanded(
                        child: Helpers.getWeatherIconSmall(_forecast.daily[index].icon)),
                    Expanded(
                        child: Text(
                          "${_forecast.daily[index].high.toInt()}/${_forecast.daily[index].low.toInt()}",
                          textAlign: TextAlign.right,
                          style: const TextStyle(fontSize: 14, color: Colors.grey),
                        )),
                  ]));
            }));
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

  // Forecast Section
  Widget forecastHourlySection(Forecast _forecast){

    return Container(
        margin: const EdgeInsets.symmetric(vertical: 0.0),
        height: 150.0,
        child: ListView.builder(
            padding: const EdgeInsets.only(left: 8, top: 0, bottom: 0, right: 8),
            scrollDirection: Axis.horizontal,
            itemCount: _forecast.hourly.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  padding: const EdgeInsets.only(
                      left: 10, top: 15, bottom: 15, right: 10),
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(18)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: const Offset(0, 1), // changes position of shadow
                        )
                      ]),
                  child: Column(children: [
                      Text(
                        "${_forecast.hourly[index].temp}°",
                        style:const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                            color: Colors.black),
                      ),
                      Helpers.getWeatherIcon(_forecast.hourly[index].icon),
                      Text(
                        Helpers.getTimeFromTimestamp(_forecast.hourly[index].dt),
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: Colors.grey),
                      ),
                  ]),
              );
            }
        )
    );
  }
}
