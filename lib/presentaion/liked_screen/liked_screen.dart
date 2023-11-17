import 'package:flare_video_player/presentaion/common_widgets/grid_view.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class LikedScreen extends StatelessWidget {
  const LikedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final likedBox = Hive.box('likedList');
    flag = true;

    return MyGridView(
        gridViewListLocal: likedBox.values.map((likedList) => likedList.toString()).toList());
  }
}
