import 'package:flutter/material.dart';
import '../models/forcast.dart';
import '../utils/helpers.dart';


class ForecastDaily extends StatelessWidget {
  final Forecast forecast;

  const ForecastDaily({Key? key, required this.forecast}): super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Expanded(
        child: ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.only(left: 8, top: 0, bottom: 0, right: 8),
            itemCount: forecast.daily.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  padding: const EdgeInsets.only(
                      left: 10, top: 5, bottom: 5, right: 10),
                  margin: const EdgeInsets.all(5),
                  child: Row(children: [
                    Expanded(
                        child: Text(
                          Helpers.getDateFromTimestamp(forecast.daily[index].dt),
                          style: const TextStyle(fontSize: 14, color: Colors.black),
                        )),
                    Expanded(
                        child: Helpers.getWeatherIconSmall(forecast.daily[index].icon)),
                    Expanded(
                        child: Text(
                          "${forecast.daily[index].high.toInt()}/${forecast.daily[index].low.toInt()}",
                          textAlign: TextAlign.right,
                          style: const TextStyle(fontSize: 14, color: Colors.grey),
                        )),
                  ]
                  )
              );
            }
            )
    );
  }
}
