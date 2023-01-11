import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

enum Status {
  init,
  normal,
  error,
}

class Weather {
  Weather({required Map<String, dynamic> weather}) {
    stationId = int.parse(weather["id_stacji"]);
    station = weather["stacja"];
    date = DateTime.tryParse(
        "${weather["data_pomiaru"]} ${weather["godzina_pomiaru"]}:00");
    temperature = double.parse(weather["temperatura"]);
    //windSpeed = int.tryParse(weather["predkosc_wiatru"]);
    //windDirection = int.parse(weather["kierunek_wiatru"]);
    relativeHumidity = double.parse(weather["wilgotnosc_wzgledna"]);
    rain = double.parse(weather["suma_opadu"]);
    //pressure = double.tryParse(weather["cisnienie"]);
  }

  late final int? stationId;
  late final String? station;
  late final DateTime? date;
  late final double? temperature;
  late final int? windSpeed;
  late final int? windDirection;
  late final double? relativeHumidity;
  late final double? rain;
  late final double? pressure;
}

class WeatherProvider extends ChangeNotifier {
  List<Weather>? data;

  void getData() async {
    var url = Uri.https('danepubliczne.imgw.pl', 'api/data/synop');
    var response = await http.get(url);
    final parsedData = jsonDecode(response.body);
    data = [];
    for (var weather in parsedData) {
      data!.add(Weather(weather: weather));
    }
    notifyListeners();
  }

  void refresh() {
    getData();
  }

  WeatherProvider() {
    getData();
  }
}
