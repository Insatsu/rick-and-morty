import 'package:get/get.dart';
import 'package:rick_and_morty/data/character.dart';
import 'package:rick_and_morty/data/db/characters_hive_service.dart';
import 'package:rick_and_morty/feature/common/character_controller.dart';

class FavoriteController extends GetxController implements CharacterController {
  final CharactersHiveService _charactersHiveService;

  @override
  final characters = <Character>[].obs;
  @override
  var isLoading = true.obs;
  @override
  var isUploading = false.obs;

  var page = 1;

  FavoriteController()
    :
      _charactersHiveService = Get.find();

  @override
  void onInit() {
    _setHiveListeners();
    fetchCharactres();
    super.onInit();
  }

  void _setHiveListeners() {
    _charactersHiveService.getFavoriteCharacterListenable().addListener(() {
      updateFavorites();
    });
    _charactersHiveService.getCharacterListenable().addListener(() {
      updateFavorites();
    });
  }

  @override
  Future<void> fetchCharactres() async {
    _setFavorites(characters);
    isLoading.value = false;
    update();
  }

  @override
  Future<void> loadMoreCharacters() async {}

  @override
  void setCharacterFavorite(int id, bool isFavorite) {
    _charactersHiveService.setFavorite(id, isFavorite);
    if (!isFavorite) {
      characters.removeAt(characters.indexWhere((element) => element.id == id));
    }
    update();
  }

  @override
  void onClose() {
    characters.close();
    isLoading.close();
    isUploading.close();
    super.onClose();
  }

  @override
  void updateFavorites() {
    _setFavorites(characters);
    update();
  }

  void _setFavorites(List<Character> chs) {
    final favoritesId = _charactersHiveService.getFavorites();

    List<Character> result = [];

    final allCharacters = _charactersHiveService.getCharacters();
    result =
        allCharacters.where((element) => favoritesId.contains(element.id)).map((
          e,
        ) {
          e.isFavorite.value = true;
          return e;
        }).toList();

    characters.value = result;
  }
}
