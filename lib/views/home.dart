import 'package:flutter/material.dart';
import 'package:pogoda/provider/weather.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    var data = context.watch<WeatherProvider>().data;
    return Scaffold(
      appBar: AppBar(title: const Text("Home Page"), actions: [
        Center(child: Text(data?[0].date?.toIso8601String() ?? ""))
      ]),
      body: RefreshIndicator(
        onRefresh: () async => context.read<WeatherProvider>().refresh(),
        child: ListView.builder(
          itemCount: data?.length ?? 0,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(data?[index].station! ?? ""),
              trailing: Text(data?[index].temperature.toString() ?? ""),
            );
          },
        ),
      ),
    );
  }
}
