import 'package:flutter/material.dart';
import 'package:pogoda/provider/weather.dart';
import 'package:provider/provider.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final WeatherProvider provider = context.watch<WeatherProvider>(); 
    if(provider.favouriteStations.isEmpty){
      return const Center(child: Text("Nie masz obecnie żadnych ulubionych stacji pogodowych!"));
    }
    return ReorderableListView.builder(
      itemBuilder: (context, index) => Container(),
      itemCount: provider.favouriteStations.length,
      onReorder: (oldIndex, newIndex) {
        
      },
    );
  }
}