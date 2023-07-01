import 'dart:io';
import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flare_video_player/presentaion/common_widgets/thumbnail_widget.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

String videoPathString = '';

class VideoPlayer extends StatefulWidget {
  const VideoPlayer({Key? key}) : super(key: key);

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late VideoPlayerController _videoPlayerController;

  late CustomVideoPlayerController _customVideoPlayerController;

  final CustomVideoPlayerSettings _customVideoPlayerSettings =
      const CustomVideoPlayerSettings();

  @override
  void initState() {
    super.initState();
    File videoPath = File('/$videoPathString');
    _videoPlayerController = VideoPlayerController.file(videoPath)
      ..initialize().then((value) => setState(() {
            _videoPlayerController.play();
          }));

    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: _videoPlayerController,
      customVideoPlayerSettings: _customVideoPlayerSettings,
    );
  }

  @override
  void dispose() {
    _customVideoPlayerController.dispose();
    howManySecondsPlayed();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   title: Text(
      //     "Flare Video Player",
      //     style: TextStyle(color: Color(secondaryColor)),
      //   ),
      //   centerTitle: true,
      //   iconTheme: IconThemeData(color: Color(secondaryColor)),
      // ),
      body: Center(
        child: CustomVideoPlayer(
          customVideoPlayerController: _customVideoPlayerController,
        ),
      ),
    );
  }

  howManySecondsPlayed() async {
    final historyListBox = Hive.box('History');
    // historyListBox.clear();

    int videoPlayedTime = _videoPlayerController.value.position.inSeconds;
    var totalDuration = await getVideoDurationForSearch(videoPathString) / 1000;

    if (videoPlayedTime >= (totalDuration / 2)) {
      if (historyListBox.length >= 5) {
        historyListBox.deleteAt(0);
      }
      if (!historyListBox.values.contains(videoPathString)) {
        historyListBox.add(videoPathString);
      } else {
        int index = historyListBox.values.toList().indexOf(videoPathString);
        if (index != -1) {
          historyListBox.deleteAt(index);

          historyListBox.add(videoPathString);
        }
      }
    }
    // print('aaaaaa${historyListBox.values}');
  }
}
