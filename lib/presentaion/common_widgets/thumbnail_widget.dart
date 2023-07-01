import 'package:flare_video_player/presentaion/common_widgets/thumbnail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_video_info/flutter_video_info.dart';

thumbnailWidget({required videoPath}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(5),
    child: Stack(
      children: [
        Container(
          // constraints: const BoxConstraints(
          // minWidth: 150, minHeight: 100, maxHeight: 100, maxWidth: 150),
          color: Colors.black,
          height: 100,
          width: 170,
          child: ThumbnailWidget(videoPath: videoPath),
        ),
        Positioned(
          bottom: 5,
          right: 5,
          child: VideoDuration(
            videoPath: videoPath,
          ),
        ),
      ],
    ),
  );
}

class VideoDuration extends StatelessWidget {
  const VideoDuration({super.key, required this.videoPath});
  final String videoPath;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getVideoDuration(videoPath),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Text(snapshot.data!,
              style: const TextStyle(
                  backgroundColor: Colors.black,
                  color: Colors.white,
                  fontSize: 12));
        } else {
          return Text('Error: ${snapshot.error}',
              style: const TextStyle(
                  backgroundColor: Colors.black, color: Colors.white));
        }
      },
    );
  }
}

Future<int> getVideoDurationForSearch(videoPath) async {
  final videoInfo = FlutterVideoInfo();
  var info = await videoInfo.getVideoInfo(videoPath);

  return (info!.duration!.toInt());
}

Future<String> getVideoDuration(videoPath) async {
  final videoInfo = FlutterVideoInfo();
  var info = await videoInfo.getVideoInfo(videoPath);

  return convertMillisecondsToTime(info!.duration!.toInt());
}

convertMillisecondsToTime(int milliseconds) {
  int seconds = (milliseconds ~/ 1000);
  int minutes = (seconds ~/ 60);
  int hours = (minutes ~/ 60);

  String hourText = '${hours.toString().padLeft(2, '')}:';
  if (hours == 0) {
    hourText = '';
  }

  String formattedTime =
      '$hourText${(minutes % 60).toString().padLeft(2, '0')}:${(seconds % 60).toString().padLeft(2, '0')}';
  return formattedTime;
}
