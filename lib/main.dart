import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:rick_and_morty/app.dart';
import 'package:rick_and_morty/data/db/characters_hive_service.dart';
import 'package:rick_and_morty/data/network/dio.dart';

Future<void> main() async {
  DioInstance.dio.interceptors.add(LogInterceptor());

  await Hive.initFlutter();
  
  Get.put(CharactersHiveService());
  await Get.find<CharactersHiveService>().init();

  runApp(const MainApp());
}
