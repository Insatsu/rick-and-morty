import 'package:get/get.dart';
import 'package:rick_and_morty/data/character.dart';

abstract class CharacterController implements GetxController {
  final characters = <Character>[].obs;

  var isLoading = true.obs;
  var isUploading = false.obs;

  Future<void> fetchCharactres();
  Future<void> loadMoreCharacters();
  void updateFavorites();

  void setCharacterFavorite(int id, bool isFavorite);
}
