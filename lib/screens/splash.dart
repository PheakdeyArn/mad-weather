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
    super.initState();
    // Set Timer after Duration Replace by Home Screen in Navigation
    Timer(const Duration(seconds: 2), () => Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const BottomNavigation()))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Cus_Color.bg,
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(logoImage, height: 150,),
              const Text(
                appTitle,
                style: TextStyle(
                    fontSize: 28,
                    fontWeight:
                    FontWeight.bold
                ),
              ),
              const SizedBox(height: 100,),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
              ),
            ]
        ),
      ),
    );
  }
}

