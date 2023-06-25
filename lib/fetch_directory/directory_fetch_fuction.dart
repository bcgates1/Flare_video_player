import 'dart:developer';

import 'package:fetch_all_videos/fetch_all_videos.dart';
import 'package:flare_video_player/fetched_directory_lists.dart';

Future videoFetch() async {
  FetchAllVideos ob = FetchAllVideos();
  List videos = await ob.getAllVideos();
  log('fetch finished');
  List fetchedFolders = [];
  print(fetchedFolders);
  for (String elements in videos) {
    var folderPath = elements.split('/');
    fetchedFolders.add(folderPath[folderPath.length - 2]);
  }
  Set folders = fetchedFolders.toSet();
  folderList.addAll(folders);

  for (int i = 0; i < videos.length; i++) {
    for (int j = 0; j < folderList.length; j++) {
      if (videos[i].toString().contains(folderList[j])) {
        folderMapList[folderList[j]] ??= [];

        folderMapList[folderList[j]]!.add(videos[i]);
      }
    }
  }
  videoList = videos;
}
