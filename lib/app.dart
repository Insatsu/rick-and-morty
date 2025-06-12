import 'package:flutter/material.dart';
import 'package:rick_and_morty/core/consts.dart';
import 'package:rick_and_morty/data/network/dio.dart';
import 'package:rick_and_morty/data/network/rick_morty_api.dart';
import 'package:rick_and_morty/feature/favorite/favorites.dart';
import 'package:rick_and_morty/feature/home/home.dart';
import 'package:get/get.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(RickMortyApi(DioInstance.dio));

    final home = Home(key: GlobalKey());
    final favorites = Favorites(key: GlobalKey());

    final widgets = [home, favorites];
    var selectedIndex = 0;

    return MaterialApp(
      home: StatefulBuilder(
        builder: (context, setState) {
          return Scaffold(
            body: IndexedStack(index: selectedIndex, children: widgets),
            bottomNavigationBar: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.list),
                  label: HOME_WIDGET_LABEL,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: FAVORITE_WIDGET_LABEL,
                ),
              ],
              currentIndex: selectedIndex,
              selectedItemColor: Colors.cyanAccent[700],
              onTap: (value) => setState(() => selectedIndex = value),
            ),
          );
        },
      ),
    );
  }
}
