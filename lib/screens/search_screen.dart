import 'package:flutter/material.dart';
import 'dart:convert';
import '../widgets/search.dart';
import '../utils/colors.dart';

import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;


import '../models/location.dart';
import '../models/weather.dart';
import '../utils/constants.dart';
import '../screens/currentWeather.dart';


class SearchTab extends StatefulWidget {
  const SearchTab({Key? key}) : super(key: key);

  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  // FirebaseServices _firebaseServices = FirebaseServices();
  String _searchString = "";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondaryColor,
        title:  Text("Search"),
      ),
      body: Container(
        child: Stack(
          children: [
            if (_searchString.isEmpty)
              Center(
                child: Container(
                  child: const Text(
                    "Search Results",
                    // style: Constants.regularDarkText,
                  ),
                ),
              )
            else
              FutureBuilder(

                future: getSearchCity(_searchString),
                builder: (context, AsyncSnapshot<Location?> snapshot) {
                  // Location? hsha;

                  if (snapshot.hasError) {
                    return Scaffold(
                      body: Center(
                        child: Text("Error: ${snapshot.error}"),
                      ),
                    );
                  }

                  // Collection Data ready to display
                  if (snapshot.connectionState == ConnectionState.done) {
                    // Display the data inside a list view

                    // print("++++++++++++++++");
                    // print(snapshot);
                    //
                    // hsha = snapshot.data;

                    if (snapshot.data != null){
                      return ListView(
                          padding: const EdgeInsets.only(
                            top: 128.0,
                            bottom: 12.0,
                          ),
                          children: [
                            cityCard(snapshot.data!),
                          ]
                      );
                    } else {
                      return const Text("Error to fetch data");
                    }

                  }

                  // Loading State
                  return const Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              ),
            Padding(
              padding: const EdgeInsets.only(
                top: 45.0,
              ),
              child: CustomInput(
                hintText: "Search here...",
                onSubmitted: (value) {
                  setState(() {
                    _searchString = value.toLowerCase();
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget cityCard (Location location){
    return GestureDetector(
      onTap: () {
        // print('Clicked Locations: ${location.city}');
        Navigator.push(context, MaterialPageRoute(builder: (context) => CurrentWeather([location], context)));
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 5),
        child: Card(
          shadowColor: secondaryColor,
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: SizedBox(
            width: 300,
            height: 100,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  // Image.asset('assets/images/img_note.png'),
                  Padding(
                    padding: EdgeInsets.only(left: 10, top: 20),
                    child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 150,
                              child: Text(location.city, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
                            ),
                            SizedBox(width: 10,),
                            // Icon(Icons.favorite, color: Cus_Color.secondary_color, size: 25,),
                          ],
                        ),
                        SizedBox(height: 3,),
                        Row(
                          children: [
                            Text("Latitude: ${location.lat}", style: TextStyle(fontSize: 14)),
                            const SizedBox(width: 10,),
                            Text("Longitude: ${location.lon}", style: TextStyle(fontSize: 14)),
                            const SizedBox(width: 10,),
                            Text("Country: ${location.country}", style: TextStyle(fontSize: 14)),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<Location?> getSearchCity(String location) async {
  Weather? weather;
  String city= location;

  Location? getLocation;

  String currentWeatherUrl = "$openWeatherUrl?q=$city&appid=$apiKey";

  Uri url = Uri.parse(currentWeatherUrl);
  final response = await http.get(url);

  if (response.statusCode == 200) {
    weather = Weather.fromJson(jsonDecode(response.body));
    getLocation = Location.fromJson(jsonDecode(response.body));

    print("Body: ${response.body}");
  }

  return getLocation;
}