import 'package:hive_flutter/adapters.dart';
part 'model.g.dart';

@HiveType(typeId: 1)
class LikedList {
  @HiveField(0)
  final String likedList;

  LikedList({required this.likedList});
}

@HiveType(typeId: 2)
class Playlist {
  @HiveField(0)
  String playListName;

  @HiveField(1)
  List? playListItems;

  Playlist({required this.playListName, required this.playListItems});
  setPlaylistName(String name) {
    playListName = name;
  }
}

@HiveType(typeId: 3)
class HistoryList {
  @HiveField(0)
  final String historyVideoName;
  HistoryList({required this.historyVideoName});
}
