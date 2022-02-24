// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlistmodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlaylistModelsAdapter extends TypeAdapter<PlaylistModels> {
  @override
  final int typeId = 1;

  @override
  PlaylistModels read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlaylistModels(
      title: fields[0] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, PlaylistModels obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.title);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlaylistModelsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
