import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rick_and_morty/feature/common/character_controller.dart';
import 'package:rick_and_morty/feature/common/characters_list.dart';
import 'package:rick_and_morty/feature/favorite/favorite_controller.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();

  void updateFavorites() {
    Get.find<CharacterController>(tag: _FavoritesState.tag);
  }
}

class _FavoritesState extends State<Favorites> {
  static final tag = "favorite";

  final gridController = ScrollController();

  final gridKey = GlobalKey();

  final favoriteController = FavoriteController();

  @override
  void initState() {
    super.initState();
    Get.put<CharacterController>(favoriteController, tag: tag);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CharacterController>(
      init: favoriteController,
      tag: tag,
      autoRemove: false,
      global: false,
      builder: (controller) {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator.adaptive());
        }
        if (controller.characters.isEmpty) {
          return Center(child: Text("You add nobody yet"));
        }

        return CustomScrollView(
          controller: gridController,
          slivers: [
            CharactersList(
              key: gridKey,
              tag: tag,
              characters: controller.characters,
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    gridController.dispose();
    super.dispose();
  }
}
