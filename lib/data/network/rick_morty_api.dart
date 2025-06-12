import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:rick_and_morty/data/character.dart';

class RickMortyApi {
  final Dio _dio;
  final _responseKey = "results";
  bool? isConnected;

  RickMortyApi(this._dio);

  Future<List<Character>?> getCharactersByPage(int page) async {
    try {
      final response = await _dio.get(
        "/character",
        queryParameters: {'page': page},
        options: Options(responseType: ResponseType.json),
      );

      final characters =
          (response.data[_responseKey] as List<dynamic>)
              .map((element) => Character.fromJson(element))
              .toList();
      isConnected = true;

      return characters;
    } catch (e) {
      isConnected = false;
      return null;
    }
  }

  Future<Uint8List?> loadImage(String url) async {
    try {
      final data =
          (await _dio.get(
            url,
            options: Options(responseType: ResponseType.bytes),
          )).data;

      isConnected = true;

      if (data == null) return null;

      return Uint8List.fromList(data);
    } catch (e) {
      isConnected = false;
      return null;
    }
  }

  Future<Character?> getCharater(int id) async {
    try {
      final response = await _dio.get(
        "/character/$id",
        options: Options(responseType: ResponseType.json),
      );

      isConnected = true;

      final character = Character.fromJson(response.data);

      return character;
    } catch (e) {
      isConnected = false;
      return null;
    }
  }
}
