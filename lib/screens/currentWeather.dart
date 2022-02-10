import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/forcast.dart';
import '../models/location.dart';
import '../models/weather.dart';

import 'package:http/http.dart' as http;
import '../utils/constants.dart';
import '../utils/colors.dart';
import '../utils/extensions.dart';

import '../models/daily.dart';
import '../models/hourly.dart';

import 'package:intl/intl.dart';


class TestCurrent extends StatelessWidget {
  List<Location> locations = [
    Location(city: "Phnom Penh", country: "Cambodia", lat: "51.5072", lon: "0.1276")
  ];

  TestCurrent({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CurrentWeather(locations, context),
    );
  }
}


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

  Weather? _weather;

  _CurrentWeatherState(this.locations, this.context)
      : location = locations[0];

  @override
  Widget build(BuildContext context) {

    final ButtonStyle style =
    ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

    return Scaffold(
        appBar: AppBar(
          title:  Text(location.city),
        ),
        body:
        ListView(
          children: [
            currentWeatherViews(locations, location, this.context),
            forecastHourlyViews(locations, location, this.context),
            forecastDailyViews(location)
            // create forecast daily

          ],
        )
    );
  }


  // crreate Forcase Weather View
  Widget forecastHourlyViews (List<Location> locations, Location location, BuildContext context){
    Forecast? _forecast;

    return FutureBuilder(
        future: getForecast(location),
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
                        child: forecastHourlySection(_forecast!, context)
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
        future: getForecast(location),

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

  Widget dailyBoxes(Forecast _forcast) {
    return Expanded(
        child: ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            padding: const EdgeInsets.only(left: 8, top: 0, bottom: 0, right: 8),
            itemCount: _forcast.daily.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  padding: const EdgeInsets.only(
                      left: 10, top: 5, bottom: 5, right: 10),
                  margin: const EdgeInsets.all(5),
                  child: Row(children: [
                    Expanded(
                        child: Text(
                          "${getDateFromTimestamp(_forcast.daily[index].dt)}",
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        )),
                    Expanded(
                        child: getWeatherIconSmall(_forcast.daily[index].icon)),
                    Expanded(
                        child: Text(
                          "${_forcast.daily[index].high.toInt()}/${_forcast.daily[index].low.toInt()}",
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        )),
                  ]));
            }));
  }



  // Create Current Weather View Widget
  Widget currentWeatherViews (List<Location> locations, Location location, BuildContext context) {
    Weather? _weather;

    return FutureBuilder(
      future: getCurrentWeather(location),
      builder: (context, AsyncSnapshot<Weather?> snapshot) {
        if (snapshot.hasData){
          _weather = snapshot.data;
          if (_weather == null){
            return const Text("Error fetching weather");
          } else {
            return  Column(
              children: [
                weatherBox(_weather!),
              ],
            );
          }
        }else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget forecastHourlySection(Forecast _forecast, BuildContext context){

    List<Hourly> hourly = _forecast.hourly;

    final List<String> entries = <String>['A'];
    final List<int> colorCodes = <int>[600];

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
                    getWeatherIcon(_forecast.hourly[index].icon),

                    Text(
                      getTimeFromTimestamp(_forecast.hourly[index].dt),
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: Colors.grey),
                    ),

                  ]));
            }
        )
    );
  }


  String getTimeFromTimestamp(int timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var formatter = DateFormat('h:mm a');

    return formatter.format(date);
  }

  String getDateFromTimestamp(int timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var formatter = DateFormat('E');
    return formatter.format(date);
  }

  Widget weatherBox(Weather _weather) {
    return Stack(children: [
      Container(
        padding: const EdgeInsets.all(15.0),
        margin: const EdgeInsets.all(15.0),
        height: 160.0,
        decoration: const BoxDecoration(
            color: Colors.lightBlueAccent,
            borderRadius: BorderRadius.all(Radius.circular(20))),
      ),
      ClipPath(
          clipper: Clipper(),
          child: Container(
              padding: const EdgeInsets.all(15.0),
              margin: const EdgeInsets.all(15.0),
              height: 160.0,
              decoration: BoxDecoration(
                  color: Colors.lightBlue,
                  borderRadius: const BorderRadius.all(Radius.circular(20))))),
      Container(
          padding: const EdgeInsets.all(15.0),
          margin: const EdgeInsets.all(15.0),
          height: 160.0,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Row(
            children: [
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        getWeatherIcon(_weather.icon),
                        Container(
                            margin: const EdgeInsets.all(5.0),
                            child: Text(
                              _weather.description.capitalizeFirstOfEach,
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16,
                                  color: Colors.white),
                            )),
                        Container(
                            margin: const EdgeInsets.all(5.0),
                            child: Text(
                              "H:${_weather.high.toInt()}° L:${_weather.low.toInt()}°",
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 13,
                                  color: Colors.white),
                            )),
                      ])),
              Column(children: <Widget>[
                Text(
                  "${_weather.temp.toInt()}°",
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 60,
                      color: Colors.white),
                ),
                Container(
                    margin: const EdgeInsets.all(0),
                    child: Text(
                      "Feels like ${_weather.feelsLike.toInt()}°",
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 13,
                          color: Colors.white),
                    )),
              ])
            ],
          ))
    ]);
  }

  Widget _currentWeather() {
    return Column(
      children: const [
        Text("Current Weather Screen"),

      ],
    );
  }
}

Image getWeatherIcon(String _icon) {
  String path = 'assets/icons/';
  String imageExtension = '.png';

  return Image.asset(
    path + _icon + imageExtension,
    width: 70,
    height: 70,
  );
}

Image getWeatherIconSmall(String _icon) {
  String path = 'assets/icons/';
  String imageExtension = ".png";
  return Image.asset(
    path + _icon + imageExtension,
    width: 40,
    height: 40,
  );
}

class Clipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height - 20);

    path.quadraticBezierTo((size.width / 6) * 1, (size.height / 2) + 15,
        (size.width / 3) * 1, size.height - 30);
    path.quadraticBezierTo((size.width / 2) * 1, (size.height + 0),
        (size.width / 3) * 2, (size.height / 4) * 3);
    path.quadraticBezierTo((size.width / 6) * 5, (size.height / 2) - 20,
        size.width, size.height - 60);

    path.lineTo(size.width, size.height - 60);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(Clipper oldClipper) => false;
}

// get Current Weather
Future<Weather?> getCurrentWeather(Location location) async {
  Weather? weather;

  String city= location.city;
  String currentWeatherUrl = "$openWeatherUrl?q=$city&appid=$apiKey";

  Uri url = Uri.parse(currentWeatherUrl);
  final response = await http.get(url);

  // Response response1 = await get()

  if (response.statusCode == 200) {
    weather = Weather.fromJson(jsonDecode(response.body));
  }

  return weather;
}

Future<Forecast?> getForecast(Location location) async {
  Forecast? forecast;
  String lat = location.lat;
  String lon = location.lon;

  String forecastUrl =
      "https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&appid=$apiKey&units=metric";

  Uri url = Uri.parse(forecastUrl);
  final response = await http.get(url);

  if (response.statusCode == 200) {
    forecast = Forecast.fromJson(jsonDecode(response.body));
  }

  return forecast;
}

