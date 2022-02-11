import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../models/location.dart';
import '../screens/search_screen.dart';
import '../widgets/city_block.dart';


class LocationScreens extends StatefulWidget {
  final List<Location> locations;

  const LocationScreens({Key? key, required this.locations}): super(key: key);

  @override
  _LocationState createState() => _LocationState(this.locations);
}

class _LocationState extends State<LocationScreens> {

  final List<Location> locations;

  _LocationState(this.locations);

  bool isSearching = false;
  Icon actionIcon = const Icon(Icons.search);
  Widget appBarTitle = const Text("Locations");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: ListView(
        children: [
          cityList(locations),
        ],
      ),
    );
  }

  Widget cityList(List<Location> locations) {
    return Expanded(
        child: ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.only(left: 8, top: 0, bottom: 0, right: 8),
            itemCount: locations.length,
            itemBuilder: (BuildContext context, int index) {
              return CityBlock(location: locations[index]);
            })
    );
  }

  _appBar(){
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 5,
      backgroundColor: secondaryColor,
      title: appBarTitle,
      actions:<Widget>[
        IconButton(
            onPressed: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchTab())
              );
            },
            icon: actionIcon
        ),
      ],
    );
  }

}
