import 'package:flare_video_player/infrastructure/common_lists.dart';
import 'package:flare_video_player/presentaion/common_widgets/grid_view.dart';
import 'package:flutter/material.dart';

class VideoScreen extends StatelessWidget {
  const VideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    flag = true;
    return MyGridView(gridViewListLocal: videoList as List<String>);
  }
}
