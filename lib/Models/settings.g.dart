// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavouriteAdapter extends TypeAdapter<Settings> {
  @override
  final int typeId = 1;

  @override
  Settings read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Settings(
      value: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Settings obj) {
    writer
      ..writeByte(0)
      ..write(obj.value)
     ;
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavouriteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
