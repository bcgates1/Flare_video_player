import 'package:flare_video_player/infrastructure/fetched_directory_lists.dart';
import 'package:flare_video_player/presentaion/common_widgets/grid_view.dart';
import 'package:hive_flutter/hive_flutter.dart';

List navbar_list_update({required int index}) {
  switch (index) {
    case 0:
      {
        return folderList;
      }
    case 1:
      {
        flag = true;
        return videoList;
      }
    case 2:
      {
        final likedBox = Hive.box('likedList');
        flag = true;

        return likedBox.values.toList();
      }
    case 3:
      {
        final playlistbox = Hive.box('Playlist');
        // Get all playlist names as a list
        List playlistNames = playlistbox.values
            .map((playlist) => playlist.playListName)
            .toList();

        return playlistNames;
      }
  }
  return [];
}
