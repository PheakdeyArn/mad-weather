import 'dart:async';
import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/strings.dart';

import '../navigations/buttom_navigations.dart';


class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 2), ()=>Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => BottomNavigation()))
    );
  }

  final body = Center(
    child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(logoImage, height: 150,),
          Text(appTitle, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),),
          SizedBox(height: 100,),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
          ),
        ]
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Cus_Color.bg,
      body: body,
    );
  }

}





