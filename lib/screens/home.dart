import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/strings.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  bool isSearching = false;
  Icon actionIcon = Icon(Icons.search);
  Widget appBarTitle = Text("KOT TRA");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: _appBar(),
      body: _topBar(),

    );
  }

  _topBar(){
    Size size = MediaQuery.of(context).size;
    return Container(
      // height: size.height * 0.2,
      height: 200,
      child: Stack(
        children: <Widget>[
          Container(
            height: 100,
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(appTitle,
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ],
              ),
            ),
          ),
          //Search TextField
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                // margin: EdgeInsets.symmetric(horizontal: 20),
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0,10),
                          blurRadius: 50,
                          color: secondaryColor.withOpacity(0.1)
                      ),
                    ]
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Search",
                            hintStyle: TextStyle(
                                color: secondaryColor
                            ),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                          onChanged: (value){},
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right:20),
                      child: Icon(Icons.search, color: secondaryColor,),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
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
