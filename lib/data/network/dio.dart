import 'package:dio/dio.dart';

class DioInstance {
  static const _baseUrl = "https://rickandmortyapi.com/api";

  static final dio = Dio(BaseOptions(baseUrl: _baseUrl, connectTimeout: Duration(seconds: 2)));
}
