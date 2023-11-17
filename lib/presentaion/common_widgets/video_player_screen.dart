import 'dart:io';
import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flare_video_player/application/cubit/history_screen/cubit/history_screen_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      const CustomVideoPlayerSettings(enterFullscreenOnStart: true, showSeekButtons: true,);

  @override
  void initState() {
    super.initState();
    File videoPath = File(videoPathString);
    _videoPlayerController = VideoPlayerController.file(videoPath)
      ..initialize().then((value) {
        setState(() {
          _videoPlayerController.play();
        });
      });

    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: _videoPlayerController,
      customVideoPlayerSettings: _customVideoPlayerSettings,
    );
  }

  @override
  void dispose() {
    _customVideoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: WillPopScope(
        onWillPop: () async {
          final historyListBox = Hive.box('History');
          //history length set to 5
          if (historyListBox.length >= 5) {
            historyListBox.deleteAt(0);
          }
          if (!historyListBox.values.contains(videoPathString)) {
            historyListBox.add(videoPathString);
          } else {
            //if video already in history delete it and add again to come at the top
            int index = historyListBox.values.toList().indexOf(videoPathString);
            if (index != -1) {
              historyListBox.deleteAt(index);
              historyListBox.add(videoPathString);
            }
          }

          final cubit = BlocProvider.of<HistoryScreenCubit>(context);
          cubit.historyList(historyListBox.values.toList());

          return true;
        },
        child: Center(
          child: CustomVideoPlayer(
            customVideoPlayerController: _customVideoPlayerController,
          ),
        ),
      ),
    );
  }
}
