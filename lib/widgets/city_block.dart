import 'package:flutter/material.dart';
import '../models/location.dart';
import '../screens/currentWeather.dart';
import '../utils/colors.dart';

class LocationBlock extends StatelessWidget {
  final Location location;
  const LocationBlock({Key? key, required this.location}): super(key: key);

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => CurrentWeather(locations: [location])));
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Card(
          shadowColor: secondaryColor,
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: SizedBox(
            width: 300,
            height: 120,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 20),
                    child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 150,
                              child: Text(
                                location.city,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            const SizedBox(width: 10,),
                          ],
                        ),
                        const SizedBox(height: 3,),
                        Row(
                          children: [
                            SizedBox(
                              width: 250,
                              child: Text(
                                  "Country: ${location.country}",
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 16)),
                            ),
                            const SizedBox(width: 10,),
                          ],
                        ),
                        const SizedBox(height: 3,),
                        Row(
                          children: [
                            Text(
                                "Latitude: ${location.lat}",
                                style: const TextStyle(fontSize: 14)
                            ),
                            const SizedBox(width: 10,),
                            Text(
                                "Longitude: ${location.lon}",
                                style: const TextStyle(fontSize: 14)
                            ),
                          ],
                        ),
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

