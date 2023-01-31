import 'package:flutter/material.dart';

class Detail extends StatelessWidget {
  const Detail({super.key, required this.text, required this.value});
  final String text;
  final String value;

  factory Detail.temperature(double? temp){
    return Detail(text: "Temperatura", value: "$temp\u00B0C",);
  }

  factory Detail.pressure(double? pressure){
    return Detail(text: "Ciśnienie", value: "$pressure hPa",);
  }

  factory Detail.rain(double? rain){
    return Detail(text: "Suma opadu", value: "$rain mm",);
  }

  factory Detail.wind(int? wind){
    return Detail(text: "Prędkość wiatru", value: "$wind km/h",);
  }

  factory Detail.relativeHumidity(double? relativeHumidity){
    return Detail(text: "Wilgotność względna", value: "$relativeHumidity%");
  }
  
  factory Detail.date(DateTime? date){
    return Detail(text: "Data aktualizacji", value: "${date?.hour}:${date?.minute}${(date?.minute ?? 0) <  10 ? "0" : ""} ${date?.day}-${date?.month}-${date?.year}");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(8),
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.black26),
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text(text, style: const TextStyle(fontSize: 17)),
                Text(value, style: const TextStyle(fontSize: 17))
              ]),
            ),
          );
  }
}