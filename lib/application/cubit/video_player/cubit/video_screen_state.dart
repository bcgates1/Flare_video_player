part of 'video_screen_cubit.dart';

class VideoScreenState {
  final bool isLoading;

  VideoScreenState({required this.isLoading});
}

class VideoScreanInitial extends VideoScreenState {
  VideoScreanInitial() : super(isLoading: true);
}
