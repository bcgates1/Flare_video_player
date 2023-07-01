import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class ThumbnailWidget extends StatelessWidget {
  ThumbnailWidget({super.key, required this.videoPath});
  String videoPath;
  String? img;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getThumbnail('/$videoPath'),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
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

  Future<String> getThumbnail(String video) async {
    final String? fileName = await VideoThumbnail.thumbnailFile(
      video: video,
      thumbnailPath: (await getTemporaryDirectory()).path,
      quality: 100,
    );
    return fileName!;
  }
}
