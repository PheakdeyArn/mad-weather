import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import '../utils/colors.dart';
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
  int index = 0;

  List<Location> locations = [
    Location(city: "Phnom Penh", country: "Cambodia", lat: "11.5564", lon: "104.928"),
    Location(city: "Battambang", country: "Cambodia", lat: "13.0957", lon: "103.2022"),
    Location(city: "Siem Reap", country: "Cambodia", lat: "13.3633", lon: "103.8564"),
    Location(city: "Kampong Cham", country: "Cambodia", lat: "11.9924", lon: "105.4645"),
    Location(city: "Preah Sihanouk", country: "Cambodia", lat: "10.6268", lon: "103.5116"),
    Location(city: "Kampot", country: "Cambodia", lat: "10.5942", lon: "104.1640"),
    Location(city: "Kep", country: "Cambodia", lat: "10.5432", lon: "104.3191"),
    Location(city: "Ratanakiri", country: "Cambodia", lat: "13.8577", lon: "107.1012"),
  ];

  @override
  Widget build(BuildContext context) {

    final taps = [
      CurrentWeather(locations, this.context),
      LocationScreens(locations, this.context),
      SearchTab(),
    ];

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
            icon: const Icon(Icons.home),
            title: const Text('Home'),
            activeColor: secondaryColor,
            inactiveColor: primaryColor
        ),

        BottomNavyBarItem(
            icon: const Icon(Icons.location_on),
            title: const Text('Location'),
            activeColor: secondaryColor,
            inactiveColor: primaryColor
        ),

        BottomNavyBarItem(
            icon: const Icon(Icons.search),
            title: const Text('Search'),
            activeColor: secondaryColor,
            inactiveColor: primaryColor
        ),
      ],
    );
  }
}

