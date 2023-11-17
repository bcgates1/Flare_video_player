import 'package:flare_video_player/presentaion/common_widgets/grid_view.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class PlaylistScreen extends StatelessWidget {
  const PlaylistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final playlistbox = Hive.box('Playlist');
    // playlistbox.clear();
    // Get all playlist names as a list
    List<String> playlistNames =
        playlistbox.values.map((playlist) => playlist.playListName.toString()).toList();

    return MyGridView(gridViewListLocal: playlistNames);
  }
}
