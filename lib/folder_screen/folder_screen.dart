import 'package:flare_video_player/fetched_directory_lists.dart';
import 'package:flare_video_player/common_widgets/grid_view.dart';

import 'package:flutter/material.dart';

class FolderScreen extends StatefulWidget {
  const FolderScreen({super.key});

  @override
  State<FolderScreen> createState() => _FolderScreenState();
}

class _FolderScreenState extends State<FolderScreen> {
  @override
  Widget build(BuildContext context) {
    return MyGridView(
      gridViewListLocal: folderList,
    );
  }
}
