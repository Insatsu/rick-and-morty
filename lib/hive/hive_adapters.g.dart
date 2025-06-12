// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_adapters.dart';

// **************************************************************************
// AdaptersGenerator
// **************************************************************************

class CharacterHiveAdapter extends TypeAdapter<CharacterHive> {
  @override
  final typeId = 1;

  @override
  CharacterHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CharacterHive(
      (fields[0] as num).toInt(),
      fields[1] as String,
      fields[3] as String,
      fields[4] as String,
      fields[5] as String,
      (fields[2] as List?)?.cast<int>(),
      fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CharacterHive obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.imageFile)
      ..writeByte(3)
      ..write(obj.status)
      ..writeByte(4)
      ..write(obj.species)
      ..writeByte(5)
      ..write(obj.gender)
      ..writeByte(7)
      ..write(obj.imageUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CharacterHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
