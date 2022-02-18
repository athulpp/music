// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'songsdata.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DataSongModelAdapter extends TypeAdapter<DataSongModel> {
  @override
  final int typeId = 0;

  @override
  DataSongModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DataSongModel()..songs = (fields[0] as List?)?.cast<dynamic>();
  }

  @override
  void write(BinaryWriter writer, DataSongModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.songs);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataSongModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
