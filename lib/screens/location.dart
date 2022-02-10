import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../screens/home.dart';
import '../navigations/buttom_navigations.dart';

class LocationScreens extends StatefulWidget {
  const LocationScreens({Key? key}) : super(key: key);

  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<LocationScreens> {

  bool isSearching = false;
  Icon actionIcon = Icon(Icons.search);
  Widget appBarTitle = Text("Favourite");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
    );
  }

  appBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: secondaryColor,
      title: Text("Favourite"),
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

  _appBar(){
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 5,
      backgroundColor: secondaryColor,
      title: appBarTitle,
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
      actions:<Widget>[
        IconButton(
            onPressed: (){
              setState(() {
                _action_search();
              });
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
