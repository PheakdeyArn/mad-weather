import 'package:flutter/material.dart';
import '../screens/splash.dart';

void main()  {

  const app = MaterialApp(
    title: 'MAD-Weather',
    home: Splash(),
    debugShowCheckedModeBanner: false,
  );

  runApp(app);
}
