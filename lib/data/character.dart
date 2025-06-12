import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:hive_ce_flutter/adapters.dart';

class Character {
  final int id;
  final String name;
  final Rx<Uint8List?> imageFile = Rx<Uint8List?>(null);
  final String? imageUrl;

  final String status;
  final String species;
  final String gender;
  final RxBool isFavorite = RxBool(false);

  Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.gender,
    this.imageUrl,
  });

  Character.fromJson(dynamic json)
    : id = json["id"] as int,
      name = json["name"] as String,
      imageUrl = json["image"] as String,
      status = json["status"] as String,
      species = json["species"] as String,
      gender = json["gender"] as String;
}

class CharacterHive extends HiveObject {
  final int id;
  final String name;
  final List<int>? imageFile;
    final String? imageUrl;


  final String status;
  final String species;
  final String gender;

  CharacterHive(
    this.id,
    this.name,
    this.status,
    this.species,
    this.gender,
    this.imageFile, this.imageUrl,
  );

  CharacterHive.fromCharacter(Character ch)
    : this(
        ch.id,
        ch.name,
        ch.status,
        ch.species,
        ch.gender,
        ch.imageFile.value,
        ch.imageUrl
      );

  Character toCharacter() {
    return Character(
        id: id,
        name: name,
        status: status,
        species: species,
        gender: gender,
        imageUrl: imageUrl
      )
      ..imageFile.value = imageFile == null ? Uint8List.fromList([]) : Uint8List.fromList(imageFile!)
      ;
  }
}
