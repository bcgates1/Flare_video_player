import 'dart:developer';

import 'package:fetch_all_videos/fetch_all_videos.dart';
import 'package:flare_video_player/infrastructure/fetched_directory_lists.dart';
import 'package:flare_video_player/presentaion/home_screen/home_screen.dart';
import 'package:flutter/material.dart';

Future videoFetch() async {
  FetchAllVideos ob = FetchAllVideos();
  List videos = await ob.getAllVideos();
  log('fetch finished');
  List fetchedFolders = [];
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

        folderMapList[folderList[j]].add(videos[i]);
      }
    }
  }
  videoList = videos;
}

Future<void> waitForPermission({required BuildContext context}) async {
    // await Future.delayed(const Duration(seconds: 2));

    await videoFetch();

    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: ((ctx) {
      return HomeScreen();
    })));
  }
