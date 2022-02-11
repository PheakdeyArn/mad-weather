import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../screens/home.dart';
import '../navigations/buttom_navigations.dart';
import '../models/location.dart';
import '../screens/currentWeather.dart';


import '../screens/search_screen.dart';

class LocationScreens extends StatefulWidget {
  final List<Location> locations;
  final BuildContext context;

  const LocationScreens(this.locations, this.context);

  @override
  _LocationState createState() => _LocationState(this.locations, this.context);
}

class _LocationState extends State<LocationScreens> {

  final List<Location> locations;
  final BuildContext context;

  _LocationState(this.locations, this.context);

  bool isSearching = false;
  Icon actionIcon = Icon(Icons.search);
  Widget appBarTitle = Text("Locations");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Container(
        child: ListView(
          children: [
            cityList(locations),
          ],
        ),

      ),
    );
  }

  appBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: secondaryColor,
      title: Text("Location"),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Home())
          );
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BottomNavigation())
          );
        },
      ),
    );
  }

  Widget cityList(List<Location> locations) {
    return Expanded(
        child: ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            padding: const EdgeInsets.only(left: 8, top: 0, bottom: 0, right: 8),
            itemCount: locations.length,
            itemBuilder: (BuildContext context, int index) {
              return cityCard(locations[index]);
            }));
  }


  Widget cityCard (Location location){
    return GestureDetector(
      onTap: () {
        print('Clicked Locations: ${location.city}');
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
                            SizedBox(width: 10,),
                            Text("Longitude: ${location.lon}", style: TextStyle(fontSize: 14)),
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

  _appBar(){
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 5,
      backgroundColor: secondaryColor,
      title: appBarTitle,
      actions:<Widget>[
        IconButton(
            onPressed: (){

              // setState(() {
              //   _action_search();
              // });
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

  _action_search(){
    if(actionIcon.icon == Icons.search){
      actionIcon = const Icon(Icons.close);
      appBarTitle = TextField(
        style: const TextStyle(
            color: Colors.white,
            fontSize: 20
        ),
        decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search, color: Colors.white,),
            hintText: "Search!",
            hintStyle: new TextStyle(color: Colors.white)
        ),
      );
    }else{
      actionIcon = const Icon(Icons.search);
      appBarTitle = const Text("KOT TRA");
    }
  }
}
