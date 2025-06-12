import 'package:flutter/foundation.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:rick_and_morty/data/character.dart';
import 'package:rick_and_morty/hive/hive_registrar.g.dart';

class CharactersHiveService {
  CharactersHiveService();

  static const _charactersHiveName = "characters_hive_name";
  static const _favoriteCharactersHiveName = "favorite_characters_hive_name";
  late Box<CharacterHive> _characterBox;
  late Box<bool> _favoriteCharacterBox;

  Future<void> init() async {
    Hive.registerAdapters();

    _characterBox = await Hive.openBox(_charactersHiveName);
    _favoriteCharacterBox = await Hive.openBox(_favoriteCharactersHiveName);
  }

  void setFavorite(int id, bool isFavorite) {
    _favoriteCharacterBox.put(id, isFavorite);
  }

  List<int> getFavorites() {
    return _favoriteCharacterBox.keys
        .toList()
        .where((element) => _favoriteCharacterBox.get(element as int)!)
        .map((e) => e as int)
        .toList();
  }

  bool isCharaterFavorite(int id) {
    return _favoriteCharacterBox.get(id) ?? false;
  }

  void saveCharacter(Character ch) {
    _characterBox.put(ch.id, CharacterHive.fromCharacter(ch));
  }

  List<Character> getCharacters() {
    return _characterBox.values
        .map(
          (chHive) =>
              chHive.toCharacter()
                ..isFavorite.value = isCharaterFavorite(chHive.id),
        )
        .toList();
  }

  ValueListenable<Box<CharacterHive>> getCharacterListenable() {
    return _characterBox.listenable();
  }

  ValueListenable<Box<bool>> getFavoriteCharacterListenable() {
    return _favoriteCharacterBox.listenable();
  }
}
