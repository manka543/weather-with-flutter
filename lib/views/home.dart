import 'package:flutter/material.dart';
import 'package:pogoda/provider/weather.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final TextEditingController _searchController;

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
    var provider = context.watch<WeatherProvider>();
    var data = provider.selectedData;
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(
          floating: true,
          pinned: true,
          snap: true,
          title: const Text("Pogoda"),
          backgroundColor: Colors.black54,
          bottom: Tab(
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(25))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) => context
                      .read<WeatherProvider>()
                      .search(_searchController.text),
                  onSubmitted: (value) => context
                      .read<WeatherProvider>()
                      .search(_searchController.text),
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: "Nazwa stacji np.Białystok",
                    icon: Icon(Icons.search),
                  ),
                ),
              ),
            ),
          ),
          actions: [
            Center(child: Text(data?.isNotEmpty ?? false ? data![0].date.toString() : "")),
            PopupMenuButton(itemBuilder: (context) {
              return <PopupMenuEntry>[
                PopupMenuItem(child: TextButton(
                  onPressed: () => context.read<WeatherProvider>().refresh(),
                  child: const Text("Odśwież dane"),
                )),
              ];
            },),
          ],
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: data?.length,
            (context, index) {
              return Padding(
                  padding: const EdgeInsets.all(7),
                  child: ListTile(
                    onTap: () => Navigator.of(context).pushNamed("/details",
                        arguments: data?[index].stationId),
                    tileColor: Colors.black54,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    title: Hero(
                        tag: "Title${data?[index].stationId}",
                        child: Text(
                          data?[index].station ?? "",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              decoration: TextDecoration.none,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.bold),
                        )),
                    trailing: Text(data?[index].temperature.toString() ?? ""),
                  ));
            },
          ),
        ),
      ]),
    );
  }
}
