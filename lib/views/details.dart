import 'package:flutter/material.dart';
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
          title: "Detale",
          child: Hero(
              tag: "Title$arg",
              child: Text(
                weather.station!,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    decoration: TextDecoration.none,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.bold),
              )),
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
                    style: const TextStyle(fontSize: 35),
                  ),
                ),
              ),
            ),
            Detail.temperature(weather.temperature),
            Detail.pressure(weather.pressure),
            Detail.rain(weather.rain),
            Detail.relativeHumidity(weather.relativeHumidity),
            Detail.wind(weather.windSpeed),
            Detail.date(weather.date),
          ],
        ),
      ),
    );
  }
}
