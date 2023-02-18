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

class _HomeViewState extends State<HomeView> {
  late final TextEditingController _searchController;
  int _screen = 0;

  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _screen != 0
          ? AppBar(
              title: const Text("Pogoda"),
              backgroundColor: Colors.black,
              actions: [
                Text(
                    context.read<WeatherProvider>().data?[0].date?.toString() ??
                        ""),
                PopupMenuButton(
                  itemBuilder: (context) => <PopupMenuEntry>[
                    PopupMenuItem(
                      child: TextButton(
                        onPressed: () =>
                            context.read<WeatherProvider>().refresh(),
                        child: const Text("Odśwież dane"),
                      ),
                    ),
                  ],
                )
              ],
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _screen,
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.purple.shade100,
          onTap: (value) {
            setState(() {
              _screen = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: "list",
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.star_border,
                ),
                label: "favourite"),
            BottomNavigationBarItem(
                icon: Icon(Icons.arrow_upward), label: "stats"),
          ]),
      body: Builder(
        builder: (context) {
          switch (_screen) {
            case 0:
              return const ListPage();
            case 1:
              return const FavouritePage();
            case 2:
              return const StatsPage();
            default:
              return const Center(child: Text("#Problemy"));
          }
        },
      ),
    );
  }
}
