import 'package:flare_video_player/infrastructure/common_lists.dart';
import 'package:flare_video_player/presentaion/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

Future seperateFoldersVideosFromPath({required List<String> videoPaths}) async {
  List<String> fetchedFolders = [];
  for (String elements in videoPaths) {
    List folderPath = elements.split('/');
    fetchedFolders.add(folderPath[folderPath.length - 2]); //getting folder name from video path
  }

  folderList.addAll(fetchedFolders.toSet()); //removing duplicates
  folderList.sort();

//creating a map of folder name and list of videos
  for (int i = 0; i < videoPaths.length; i++) {
    for (int j = 0; j < folderList.length; j++) {
      List folderPath = videoPaths[i].split('/');
      String folderName = folderPath.elementAt(folderPath.length - 2);
      if (folderName == 'WhatsApp Documents') {}
      if (folderName.contains(folderList[j])) {
        folderMapList[folderList[j]] ??= [];

        folderMapList[folderList[j]]?.add(videoPaths[i]);
      }
    }
  }
  videoList = videoPaths;
}

Future<void> fetchAllVideoAndroid() async {
  final status = await Permission.manageExternalStorage.request();

//method channel for searching videos in storage only for android devices
  if (status.isGranted) {
    const MethodChannel _platform = MethodChannel('com.bharath/video_files/search');
    List<String>? videoList = await _platform.invokeListMethod('search');
    if (videoList != null) {
      seperateFoldersVideosFromPath(videoPaths: videoList);
    }
  }
}

Future<void> fetchAllVideoFromSplash({required BuildContext context}) async {
  await fetchAllVideoAndroid();

  await Future.delayed(const Duration(seconds: 3)); //To show splash screen gif
  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: ((ctx) {
    return HomeScreen();
  })));
}




//old video fetch
// await Future.delayed(const Duration(seconds: 2));
// List<FileSystemEntity> _files = [];

// void _getFiles() async {
// if (!(await Permission.videos.isGranted)) {
// final status =  await Permission.videos.request();
// log(status.toString());
// }
// // Directory? directory = await getExternalStorageDirectory();

// Directory directory = Directory('/storage/emulated/0');

// log(directory.toString());
// List<String> files = [];
// void listFiles(FileSystemEntity entity) {
//   if (entity is File && entity.path.endsWith('.mp4') || entity.path.endsWith('.mkv')) {
//     files.add(entity.path);
//     log('file added ${entity.path}');
//   } else if (entity is Directory && !entity.path.contains('/Android')) {
//     try {
//       entity.listSync().forEach(listFiles);
//     } catch (e) {
//       log('Error while listing files in directory ${entity.path}: $e');
//     }
//   }
// }
