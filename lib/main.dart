import 'package:flutter/material.dart';
import 'package:pogoda/provider/weather.dart';
import 'package:pogoda/views/details.dart';
import 'package:pogoda/views/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WeatherProvider(),
      child: MaterialApp(
        title: 'Pogoda',
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.blue,
        ),
        darkTheme: ThemeData.dark(useMaterial3: true),
        home: const HomeView(),
        routes: {
          "/home": (context) => const HomeView(),
          "/details": (context) => const DetailsView(),
        },
      ),
    );
  }
}
