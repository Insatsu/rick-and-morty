import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rick_and_morty/feature/common/character_controller.dart';
import 'package:rick_and_morty/feature/common/characters_list.dart';
import 'package:rick_and_morty/feature/home/home_controller.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();

  void updateFavorites() {
    Get.find<CharacterController>(tag: _HomeState.tag);
  }
}

class _HomeState extends State<Home> {
  static final tag = "home";

  final gridController = ScrollController();

  final gridKey = GlobalKey();

  final homeController = HomeController();

  @override
  void initState() {
    super.initState();
    Get.put<CharacterController>(homeController, tag: tag);
  }

  @override
  void didUpdateWidget(covariant Home oldWidget) {
    super.didUpdateWidget(oldWidget);
    homeController.updateFavorites();
  }

  @override
  Widget build(BuildContext context) {
    gridController.addListener(_gridControllerListener);

    return GetBuilder<CharacterController>(
      init: homeController,
      tag: tag,
      autoRemove: false,
      global: false,
      builder: (controller) {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator.adaptive());
        }
        if (controller.characters.isEmpty) {
          return Center(
            child: TextButton(
              onPressed: () => controller.fetchCharactres(),
              child: Text("Try again"),
            ),
          );
        }

        final grid = CharactersList(
          key: gridKey,
          tag: tag,
          characters: controller.characters,
        );

        return CustomScrollView(
          controller: gridController,
          slivers: [
            grid,
            if (controller.isUploading.value)
              SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: CircularProgressIndicator.adaptive(),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  void _gridControllerListener() {
    if (gridController.position.pixels + 100 <
        gridController.position.maxScrollExtent) {
      return;
    }
    homeController.loadMoreCharacters();
  }

  @override
  void dispose() {
    gridController.dispose();
    super.dispose();
  }
}
