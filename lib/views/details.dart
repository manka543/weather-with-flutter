import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:pogoda/provider/weather.dart';
import 'package:pogoda/widget/detail.dart';
import 'package:provider/provider.dart';

class DetailsView extends StatefulWidget {
  const DetailsView({super.key});

  @override
  State<DetailsView> createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  @override
  Widget build(BuildContext context) {
    var arg = ModalRoute.of(context)!.settings.arguments as int?;
    if (arg == null) {
      Navigator.of(context).pop();
    }
    Weather weather = context
        .read<WeatherProvider>()
        .data!
        .singleWhere((element) => element.stationId == arg);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Title(
          color: Colors.black,
          child: const Text(
            "Detale",
            style: TextStyle(
                color: Colors.white,
                decoration: TextDecoration.none,
                fontFamily: "Roboto",
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.black54),
                child: Center(
                  child: Text(
                    weather.station ?? "Error 404",
                    style: const TextStyle(
                                color: Colors.white,
                                decoration: TextDecoration.none,
                                fontSize: 35,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Detail.temperature(weather.temperature),
            Detail.pressure(weather.pressure),
            Detail.rain(weather.rain),
            Detail.relativeHumidity(weather.relativeHumidity),
            Detail.date(weather.date),
            Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.black38),
        padding: const EdgeInsets.all(15),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text("Wiatr", style: TextStyle(fontSize: 17)),
          Expanded(child: Container()),
          Text("${weather.windSpeed}km/h", style: const TextStyle(fontSize: 17)),
          Transform.rotate(angle: weather.windDirection! / 180 * math.pi,child: const Icon(Icons.arrow_upward)),
        ]),
      ),
    ),
          ],
        ),
      ),
    );
  }
}
