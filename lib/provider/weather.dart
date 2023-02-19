import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  final List<Weather?> data = [];
  final List<Weather?> selectedData = [];
  final List<int> favouriteStations = [];
  static const String _favouriteLabel = "favourites";

  void getData() async {
    var url = Uri.https('danepubliczne.imgw.pl', 'api/data/synop');
    var response = await http.get(url);
    final parsedData = jsonDecode(response.body);
    data.clear();
    for (var weather in parsedData) {
      data.add(Weather(weather: weather));
    }
    search("");
    notifyListeners();
  }

  void refresh() {
    getData();
  }

  void search(String? word) {
    if (word == "" || word == " " || word == null) {
      selectedData.addAll(data);
      notifyListeners();
      return;
    }
    selectedData.clear();
    for (var station in data) {
      if (station?.station?.toLowerCase().contains(word) ?? false) {
        selectedData.add(station);
      }
    }
    notifyListeners();
  }

  void loadFavourites() async {
    final prefs = await SharedPreferences.getInstance();
    final stringFavourites = prefs.getStringList(_favouriteLabel) ?? [];
    favouriteStations.clear();
    for (var id in stringFavourites) {
      favouriteStations.add(int.parse(id));
    }
    notifyListeners();
  }

  void like(int? id) async {
    if (id == null) return;
    if(favouriteStations.contains(id)){
      favouriteStations.remove(id);
    } else {
      favouriteStations.add(id);
    }
    var stringIds = <String>[];
    for (var intId in favouriteStations) {
      stringIds.add(intId.toString());
    }
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(_favouriteLabel, stringIds);
    notifyListeners();
  }

  WeatherProvider() {
    getData();
  }
}
