import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/weather.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> with AutomaticKeepAliveClientMixin {
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
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var provider = context.watch<WeatherProvider>();
    var date = provider.data.isNotEmpty ? provider.data[0]?.date.toString() : "";
    var data = provider.selectedData;
    return CustomScrollView(slivers: [
      SliverAppBar(
        floating: true,
        pinned: true,
        snap: true,
        title: const Text("Pogoda"),
        backgroundColor: Colors.black,
        surfaceTintColor: Colors.black,
        bottom: Tab(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
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
          Center(child: Text(date ?? "")),
          PopupMenuButton(
            itemBuilder: (context) {
              return <PopupMenuEntry>[
                PopupMenuItem(
                    child: TextButton(
                  onPressed: () => context.read<WeatherProvider>().refresh(),
                  child: const Text("Odśwież dane"),
                )),
              ];
            },
          ),
        ],
      ),
      SliverList(
        delegate: SliverChildBuilderDelegate(
          childCount: data.length,
          (context, index) {
            return Padding(
                padding: const EdgeInsets.all(7),
                child: ListTile(
                  onTap: () => Navigator.of(context).pushNamed(
                    "/details",
                    arguments: data[index]?.stationId,
                  ),
                  tileColor: Colors.black54,
                  splashColor: Colors.black54,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  title: Text(
                    data[index]?.station ?? "",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        decoration: TextDecoration.none,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.bold),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.star_border),
                    onPressed: () => context
                        .read<WeatherProvider>()
                        .like(data[index]?.stationId),
                  ),
                ));
          },
        ),
      ),
    ]);
  }
}
