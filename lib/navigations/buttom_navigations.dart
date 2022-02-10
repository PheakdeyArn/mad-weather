import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/painting.dart';
import '../utils/colors.dart';

import '../screens/home.dart';
import '../screens/location.dart';
import '../screens/currentWeather.dart';
import '../screens/search_screen.dart';
import '../models/location.dart';



class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);


  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomNavigation> {

  DateTime date = DateTime (2022,12,24);
  int index = 0;

  List<Location> haha = [
    Location(city: "Phnom Penh", country: "Cambodia", lat: "51.5072", lon: "0.1276")
  ];


  final taps = [
    Home(),
    LocationScreens(),
    // TestCurrent(),
    SearchTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: taps[index],
      bottomNavigationBar: bottomNavigationBar(),
    );
  }

  Widget bottomNavigationBar(){
    return BottomNavyBar(
      selectedIndex: index,
      onItemSelected: (index) => setState(() {
        this.index = index;
      }),
      items: <BottomNavyBarItem> [
        BottomNavyBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
            activeColor: secondaryColor,
            inactiveColor: primaryColor
        ),
        BottomNavyBarItem(
            icon: Container(
                child: Icon(Icons.location_on)
            ),
            title: Text('Location'),
            activeColor: secondaryColor,
            inactiveColor: primaryColor
        ),

        // BottomNavyBarItem(
        //     icon: Container(
        //         child: Icon(Icons.wb_cloudy_sharp)
        //     ),
        //     title: Text('Current'),
        //     activeColor: secondaryColor,
        //     inactiveColor: primaryColor
        // ),
        BottomNavyBarItem(
            icon: Container(
                child: Icon(Icons.search)
            ),
            title: Text('Search'),
            activeColor: secondaryColor,
            inactiveColor: primaryColor
        ),

      ],
    );
  }
}


