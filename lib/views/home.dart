import 'package:flutter/material.dart';
import 'package:pogoda/provider/weather.dart';
import 'package:pogoda/widget/home/favourite.dart';
import 'package:pogoda/widget/home/list.dart';
import 'package:pogoda/widget/home/stats.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  late final TextEditingController _searchController;
  late final TabController _tabController;

  @override
  void initState() {
    _searchController = TextEditingController();
    _tabController = TabController(vsync: this, length: 3);
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Stack(children: [
          Container(
            color: Colors.black,
            height: 73,
          ),
          TabBar(
              splashBorderRadius: BorderRadius.circular(15),
              automaticIndicatorColorAdjustment: false,
              controller: _tabController,
              tabs: const [
                Tab(
                  icon: Icon(Icons.list),
                  text: "Lista",
                ),
                Tab(
                  icon: Icon(Icons.star_border),
                  text: "Ulubione",
                ),
                Tab(
                  icon: Icon(Icons.arrow_upward),
                  text: "Statystyki",
                ),
              ]),
        ]),
        body: TabBarView(controller: _tabController, children: const <Widget>[
          ListPage(),
          FavouritePage(),
          StatsPage(),
        ]));
  }
}
