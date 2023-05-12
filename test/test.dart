// // // import 'dart:async';
// // // import 'dart:io';

// // // import 'package:flutter/material.dart';
// // // import 'package:path_provider/path_provider.dart';
// // // import 'package:permission_handler/permission_handler.dart';

// // // void main() async {
// // //   WidgetsFlutterBinding.ensureInitialized();
// // //   FetchAllVideos ob = FetchAllVideos();
// // //   List<String> videos = await ob.getAllVideos();
// // //   print("videos.length ${videos.length}");
// // //   print('Completed');
// // // }

// // // class FetchAllVideos {
// // //   List<String> videosDirectories = [];

// // //   Future<List<String>> getAllVideos() async {
// // //     print("fetching");

// // //     var status = await Permission.storage.request();
// // //     if (status.isGranted) {
// // //       videosDirectories.clear();

// // //       List<Directory>? extDirs = await getExternalStorageDirectories();
// // //       List<String> pathForCheck = [];

// // //       // Filter paths to only include directories that are likely to contain videos.
// // //       extDirs?.forEach((dir) {
// // //         String dirPath = dir.path.toLowerCase();
// // //         if (!dirPath.contains('/android/') &&
// // //             !dirPath.contains('/.thumbnails/') &&
// // //             !dirPath.contains('/.trash/') &&
// // //             !dirPath.contains('/music/') &&
// // //             !dirPath.contains('/podcasts/') &&
// // //             !dirPath.contains('/pictures/') &&
// // //             !dirPath.contains('/ringtones/')) {
// // //           pathForCheck.add(dirPath);
// // //         }
// // //       });

// // //       await Future.wait(
// // //           pathForCheck.map((path) => _fetchVideosInDirectory(Directory(path))));

// // //       return videosDirectories;
// // //     } else {
// // //       return [];
// // //     }
// // //   }

// // //   Future<void> _fetchVideosInDirectory(Directory directory) async {
// // //     try {
// // //       var entries = await directory.list().toList();

// // //       // Filter entries to only include video files and directories.
// // //       var videoFiles = entries.where((entry) =>
// // //           (entry is File &&
// // //               (entry.path.toLowerCase().endsWith('.mp4') ||
// // //                   entry.path.toLowerCase().endsWith('.mkv'))) ||
// // //           (entry is Directory &&
// // //               !entry.path.toLowerCase().contains('/android/') &&
// // //               !entry.path.toLowerCase().contains('/.thumbnails/') &&
// // //               !entry.path.toLowerCase().contains('/.trash/')));

// // //       for (var entry in videoFiles) {
// // //         if (entry is File) {
// // //           print("FETCHING : ${entry.path}");
// // //           videosDirectories.add(entry.path);
// // //         } else if (entry is Directory) {
// // //           await _fetchVideosInDirectory(entry);
// // //         }
// // //       }
// // //     } on FileSystemException catch (e) {
// // //       print("Error while fetching videos in directory ${directory.path}: $e");
// // //     }
// // //   }
// // // }



// // import 'dart:io';
// // import 'package:flutter/material.dart';
// // import 'package:path_provider/path_provider.dart';
// // import 'package:permission_handler/permission_handler.dart';

// // void main() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   FetchAllVideos ob = FetchAllVideos();
// //   List<String> videos = await ob.getAllVideos();
// //   print("videos.length ${videos.length}");
// //   print('Completed');
// // }

// // class FetchAllVideos {
// //   List<String> videosDirectories = [];

// //   Future<List<String>> getAllVideos() async {
// //     print("fetching");

// //     var status = await Permission.storage.request();
// //     if (status.isGranted) {
// //       videosDirectories.clear();

// //       List<Directory>? extDir = await getExternalStorageDirectories();
// //       List<String> pathForCheck = [];

// //       for (var path in extDir!) {
// //         String actualPath = path.path;
// //         int found = 0;
// //         int startIndex = 0;
// //         for (int pathIndex = actualPath.length - 1;
// //             pathIndex >= 0;
// //             pathIndex--) {
// //           if (actualPath[pathIndex] == "/") {
// //             found++;
// //             if (found == 4) {
// //               startIndex = pathIndex;
// //               break;
// //             }
// //           }
// //         }
// //         var splitPath = actualPath.substring(0, startIndex + 1);
// //         pathForCheck.add(splitPath);
// //       }

// //       for (var pForCheck in pathForCheck) {
// //         Directory directory = Directory(pForCheck);
// //         if (directory.statSync().type == FileSystemEntityType.directory) {
// //           await for (var entity in directory.list()) {
// //             if (entity is File && (entity.path.endsWith('.mp4') || entity.path.endsWith('.mkv'))) {
// //               print("FETCHING : ${entity.path}");
// //               videosDirectories.add(entity.path);
// //             } else if (entity is Directory) {
// //               if (!entity.path.contains('.') &&
// //                   !entity.path.contains('android') &&
// //                   !entity.path.contains('Android')) {
// //                 await getAllSubDirectories(entity);
// //               }
// //             }
// //           }
// //         }
// //       }
// //     }
// //     return videosDirectories;
// //   }

// //   Future<void> getAllSubDirectories(Directory directory) async {
// //     if (!directory.path.contains('/Android')) {
// //       await for (var entity in directory.list()) {
// //         if (entity is File && (entity.path.endsWith('.mp4') || entity.path.endsWith('.mkv'))) {
// //           print("FETCHING : ${entity.path}");
// //           videosDirectories.add(entity.path);
// //         } else if (entity is Directory) {
// //           if (!entity.path.contains('.') &&
// //               !entity.path.contains('android') &&
// //               !entity.path.contains('Android')) {
// //             await getAllSubDirectories(entity);
// //           }
// //         }
// //       }
// //     }
// //   }
// // }

// //refactored bottom sheet 

// import 'package:flare_video_player/bottom_sheet/bottom_sheet_list.dart';
// import 'package:flare_video_player/bottom_sheet/bottom_sheet_playlist.dart';
// import 'package:flare_video_player/colors.dart';
// import 'package:flare_video_player/common_widgets/grid_view.dart';
// import 'package:flare_video_player/common_widgets/toast_view.dart';
// import 'package:flare_video_player/home_screen/home_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';

// final likedBox = Hive.box('likedList');
// final playlistBox = Hive.box('Playlist');

// class MyBottomSheet extends StatefulWidget {
//   final BuildContext context;
//   final List list;
//   final int index;
//   final List bottomSheetList;
//   final bool showCreatePlaylistOption;

//   const MyBottomSheet({super.key, 
//     required this.context,
//     required this.list,
//     required this.index,
//     required this.bottomSheetList,
//     required this.showCreatePlaylistOption,
//   });

//   @override
//   _MyBottomSheetState createState() => _MyBottomSheetState();
// }

// class _MyBottomSheetState extends State<MyBottomSheet> {
//   bool get showCreatePlaylistOption => widget.showCreatePlaylistOption;
//   List get bottomSheetList => widget.bottomSheetList;
//   int get index => widget.index;
//   List get list => widget.list;
//   BuildContext get context => widget.context;

//   Future<void> toggleLike() async {
//     if (likedBox.values.contains(bottomSheetList[index])) {
//       likedBox.delete(bottomSheetList[index]);
//       if (bottomNavIndex == 2) {
//         gridViewList = likedBox.values.toList();
//         gridListValueNotifier.value = gridViewList;
//       }
//     } else {
//       likedBox.put(bottomSheetList[index], bottomSheetList[index]);
//     }
//     Navigator.of(context).pop();
//   }

//   Future<void> toggleCreatePlaylistOption() async {
//     setState(() {
//       widget.showCreatePlaylistOption = true;
//     });
//   }

//   Future<void> deletePlaylist() async {
//     playlistBox.deleteAt(index);
//     gridViewList = playlistBox.values.map((playlist) => playlist.playListName).toList();
//     toastMessage(message: 'Playlist deleted');
//     Navigator.of(context).pop();
//   }

//   Future<void> deleteVideoFromPlaylist() async {
//     final playlist = playlistBox.getAt(playlistValue);
//     playlist.playListItems.removeAt(index);
//     await playlistBox.putAt(playlistValue, playlist);
//     toastMessage(message: 'Video deleted from playlist');
//     Navigator.of(context).pop();
//     gridListValueNotifier.notifyListeners();
//   }

//   Future<void> updatePlaylist() async {
//     textFieldController.text = gridViewList[index];
//     if (mounted) {
//       return;
//     }
//     playlistcreate(context: context, iconText: 'Update', updateOrNot: true);
//   }

//   Future<void> createPlaylist() async {
//     playlistcreate(context: context, iconText: 'OK', updateOrNot: false);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return !(showCreatePlaylistOption)
//         ? Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ListView.builder(
//                 itemCount: list.length,
//                 shrinkWrap: true,
//                 itemBuilder: (context, index) {
//                   return InkWell(
//                     onTap: () async {
//                       if (index == 0) {
//                         toggleLike();
//                       }
//                       if (index == 1 && bottomNavIndex != 3) {
//                         toggleCreatePlaylistOption();
//                       }
//                       if (index == 1 && bottomNavIndex == 3 && flag == false) {
//                         deletePlaylist();
//                       } else if (index == 1 && bottom


