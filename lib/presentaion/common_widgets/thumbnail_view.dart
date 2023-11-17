import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class ThumbnailWidget extends StatelessWidget {
  ThumbnailWidget({super.key, required this.videoPath});
  final String videoPath;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getThumbnail(videoPath),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: SizedBox(),
          );
        }
        if (snapshot.hasData) {
          return Image.file(
            File(snapshot.data!),
            fit: BoxFit.fitWidth,
          );
        } else {
          return const Center(
            child: Text(
              'Failed to load thumbnail',
              style: TextStyle(color: Colors.red),
            ),
          );
        }
      },
    );
  }

  Future<String> getThumbnail(String videoPath) async {
    String videoName = videoPath.split('/').last.replaceAll('.mp4', '.jpg');
    // Use getTemporaryDirectory() for obtaining the app's cache directory
    Directory appDocDir = await getTemporaryDirectory();
    String thumbnailPath = '${appDocDir.path}/$videoName';
    // Use existsSync() for synchronous check
    bool status = File(thumbnailPath).existsSync();
    log(status.toString());
    log('videopath $videoPath');
    if (!status) {
      log('videopath $videoPath');
      final String? fileName = await VideoThumbnail.thumbnailFile(
        //for faster loading used jpeg , png can be used but takes too much time to load and high storage use
        imageFormat: ImageFormat.JPEG,
        video: videoPath,
        thumbnailPath: (await getTemporaryDirectory()).path,
      );
      return fileName!;
    } else {
      return thumbnailPath;
    }
  }
}
