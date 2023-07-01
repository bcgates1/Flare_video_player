// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LikedListAdapter extends TypeAdapter<LikedList> {
  @override
  final int typeId = 1;

  @override
  LikedList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LikedList(
      likedList: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LikedList obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.likedList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LikedListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PlaylistAdapter extends TypeAdapter<Playlist> {
  @override
  final int typeId = 2;

  @override
  Playlist read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Playlist(
      playListName: fields[0] as String,
      playListItems: (fields[1] as List?)?.cast<dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, Playlist obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.playListName)
      ..writeByte(1)
      ..write(obj.playListItems);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlaylistAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HistoryListAdapter extends TypeAdapter<HistoryList> {
  @override
  final int typeId = 3;

  @override
  HistoryList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HistoryList(
      historyVideoName: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HistoryList obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.historyVideoName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HistoryListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
