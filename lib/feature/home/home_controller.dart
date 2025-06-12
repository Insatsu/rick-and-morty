import 'package:get/get.dart';
import 'package:rick_and_morty/data/character.dart';
import 'package:rick_and_morty/data/db/characters_hive_service.dart';
import 'package:rick_and_morty/data/network/rick_morty_api.dart';
import 'package:rick_and_morty/feature/common/character_controller.dart';

class HomeController extends GetxController implements CharacterController {
  final RickMortyApi _rickMortyApi;
  final CharactersHiveService _charactersHiveService;
  var _isLocal = false;

  @override
  final characters = <Character>[].obs;
  @override
  var isLoading = true.obs;
  @override
  var isUploading = false.obs;

  var page = 1;

  HomeController()
    : _rickMortyApi = Get.find<RickMortyApi>(),
      _charactersHiveService = Get.find();

  @override
  void onInit() {
    fetchCharactres();
    _setHiveListeners();
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
    List<Character>? result;
    if (!_isLocal) {
      result = await _rickMortyApi.getCharactersByPage(1);
      _isLocal = !_rickMortyApi.isConnected!;
      if (!_isLocal && result != null) {
        _setFavorites(result);
      }
    } else {
      result = _charactersHiveService.getCharacters();
    }

    characters.clear();

    characters.value = result ?? [];
    isLoading.value = false;
    update();
  }

  @override
  Future<void> loadMoreCharacters() async {
    if (_isLocal) return;

    isUploading.value = true;
    update();

    page++;
    final result = await _rickMortyApi.getCharactersByPage(page);
    if (result == null) {
      isUploading.value = false;
      update();
      return;
    }
    characters.addAll(result);

    isUploading.value = false;
    update();
  }

  @override
  void setCharacterFavorite(int id, bool isFavorite) {
    _charactersHiveService.setFavorite(id, isFavorite);
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
    for (var character in chs) {
      character.isFavorite.value = _charactersHiveService.isCharaterFavorite(
        character.id,
      );
    }
  }
}
