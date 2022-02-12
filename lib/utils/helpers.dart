import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Helpers {

  static String getTimeFromTimestamp(int timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var formatter = DateFormat('h:mm a');

    return formatter.format(date);
  }

  static String getDateFromTimestamp(int timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var formatter = DateFormat('E');
    return formatter.format(date);
  }

  static Image getWeatherIcon(String _icon) {
    String path = 'assets/icons/';
    String imageExtension = '.png';

    return Image.asset(
      path + _icon + imageExtension,
      width: 70,
      height: 70,
    );
  }

  static Image getWeatherIconSmall(String _icon) {
    String path = 'assets/icons/';
    String imageExtension = ".png";
    return Image.asset(
      path + _icon + imageExtension,
      width: 40,
      height: 40,
    );
  }

  static double kelvinToCelsius(double temp){
    return temp - 273.15;
  }

}

