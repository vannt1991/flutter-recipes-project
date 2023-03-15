// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecipeAdapter extends TypeAdapter<Recipe> {
  @override
  final int typeId = 0;

  @override
  Recipe read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Recipe(
      calories: fields[0] as String?,
      carbos: fields[1] as String?,
      description: fields[2] as String?,
      difficulty: fields[3] as int?,
      fats: fields[4] as String?,
      headline: fields[5] as String?,
      id: fields[6] as String?,
      image: fields[7] as String?,
      name: fields[8] as String?,
      proteins: fields[9] as String?,
      thumb: fields[10] as String?,
      time: fields[11] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Recipe obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.calories)
      ..writeByte(1)
      ..write(obj.carbos)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.difficulty)
      ..writeByte(4)
      ..write(obj.fats)
      ..writeByte(5)
      ..write(obj.headline)
      ..writeByte(6)
      ..write(obj.id)
      ..writeByte(7)
      ..write(obj.image)
      ..writeByte(8)
      ..write(obj.name)
      ..writeByte(9)
      ..write(obj.proteins)
      ..writeByte(10)
      ..write(obj.thumb)
      ..writeByte(11)
      ..write(obj.time);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecipeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
