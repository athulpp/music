// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoritesmosdelAdapter extends TypeAdapter<Favoritesmosdel> {
  @override
  final int typeId = 4;

  @override
  Favoritesmosdel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Favoritesmosdel(
      fav: fields[0] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, Favoritesmosdel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.fav);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoritesmosdelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
