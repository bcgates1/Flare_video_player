
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'video_screen_state.dart';

class VideoScreenCubit extends Cubit<VideoScreenState> {
  VideoScreenCubit() : super(VideoScreanInitial());
  cubitVideoPlayerController(BuildContext context) async {
    emit(VideoScreenState(isLoading: false));
   
  }

  
}
