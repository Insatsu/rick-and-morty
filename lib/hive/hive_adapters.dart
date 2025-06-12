
import 'package:hive_ce/hive.dart';
import 'package:rick_and_morty/data/character.dart';

@GenerateAdapters([AdapterSpec<CharacterHive>()])
part 'hive_adapters.g.dart';