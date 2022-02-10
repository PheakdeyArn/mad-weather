import 'package:flutter/material.dart';
// import '.navigations/bottom_navigation_bar.dart';
// import 'package:weather_madii/src/splash.dart';
import 'package:weatherapp_madtwo/screens/splash.dart';
// import 'package:firebase_core/firebase_core.dart';

void main()  {

  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  const app = MaterialApp(
    title: 'KOT TRA',
    home: Splash(),
    debugShowCheckedModeBanner: false,
  );

  runApp(app);
}