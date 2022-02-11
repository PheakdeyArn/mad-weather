import 'package:flutter/material.dart';
import 'package:weatherapp_madtwo/widgets/city_block.dart';
import 'dart:convert';
import '../widgets/search.dart';
import '../utils/colors.dart';
import 'package:http/http.dart' as http;
import '../models/location.dart';
import '../utils/constants.dart';


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
        title:  const Text("Search"),
      ),
      body: Stack(
        children: [
          if (_searchString.isEmpty)
            const Center(
              child: Text(
                "Search Results",
              ),
            )
          else
            FutureBuilder(
              future: getSearchCity(_searchString),
              builder: (context, AsyncSnapshot<Location?> snapshot) {
                if (snapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text("Error: ${snapshot.error}"),
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data != null){
                    return ListView(
                        padding: const EdgeInsets.only(
                          top: 128.0,
                          bottom: 12.0,
                        ),
                        children: [
                          CityBlock(location: snapshot.data!),
                        ]
                    );
                  } else {
                    return const Center(
                      child: Text("Error: Can not find the city."),
                    );
                  }
                }

                // Loading
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
    );
  }

}

Future<Location?> getSearchCity(String location) async {
  String city= location;
  Location? getLocation;
  String currentWeatherUrl = "$openWeatherUrl?q=$city&appid=$apiKey";

  Uri url = Uri.parse(currentWeatherUrl);
  final response = await http.get(url);

  if (response.statusCode == 200) {
    getLocation = Location.fromJson(jsonDecode(response.body));
  }

  return getLocation;
}