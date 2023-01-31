import 'dart:convert';
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
    if (weather["predkosc_wiatru"] != null) {
      windSpeed = int.parse(weather["predkosc_wiatru"]);
    } else {
      windSpeed = null;
    }
    if (weather["kierunek_wiatru"] != null) {
      windDirection = int.parse(weather["kierunek_wiatru"]);
    } else {
      windDirection = null;
    }
    relativeHumidity = double.parse(weather["wilgotnosc_wzgledna"]);
    rain = double.parse(weather["suma_opadu"]);
    if (weather["cisnienie"] != null) {
      pressure = double.parse(weather["cisnienie"]);
    } else {
      pressure = null;
    }
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

  @override
  String toString() {
    return "Instance of class 'Weather', id: $stationId, station: $station, date: $date, temperature: $temperature, windSpeed: $windSpeed, windDirection: $windDirection, relativeHumidity: $relativeHumidity, rain: $rain, pressure: $pressure";
  }

}

class WeatherProvider extends ChangeNotifier {
  List<Weather>? data;
  List<Weather>? selectedData = [];

  void getData() async {
    var url = Uri.https('danepubliczne.imgw.pl', 'api/data/synop');
    var response = await http.get(url);
    final parsedData = jsonDecode(response.body);
    data = [];
    for (var weather in parsedData) {
      data!.add(Weather(weather: weather));
    }
    search("");
    notifyListeners();
  }

  void refresh() {
    getData();
  }

  void search(String? word) {
    if(word == "" || word == " " || word == null){
      selectedData = data;
      notifyListeners();
      return;
    }
    selectedData = [];
    for (var station in data!){
      if (station.station?.toLowerCase().contains(word) ?? false) {
        selectedData!.add(station);
      }
    }
    notifyListeners();
  }

  WeatherProvider() {
    getData();
  }
}
