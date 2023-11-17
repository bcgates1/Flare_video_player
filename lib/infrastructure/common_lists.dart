import 'package:flare_video_player/presentaion/liked_screen/liked_screen.dart';
import 'package:flare_video_player/presentaion/playlist_screen/playlist_screen.dart';

import '../presentaion/folder_screen/folder_screen.dart';
import '../presentaion/video_screen/video_screen.dart';

Map<String, List<String>> folderMapList = {}; //contains all the folders and videos
List<String> folderList = []; //contains all the folders
List<String> videoList = []; // contains all the videos

//List of screens for bottom navigation
List screenList = [
  FolderScreen(),
  VideoScreen(),
  LikedScreen(),
  PlaylistScreen(),
];
