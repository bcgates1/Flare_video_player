import 'dart:developer';

import 'package:flare_video_player/infrastructure/common_lists.dart';
import 'package:flare_video_player/presentaion/bottom_sheet/bottom_sheet_widget.dart';
import 'package:flare_video_player/presentaion/common_widgets/thumbnail_widget.dart';

List<List<dynamic>> searchTerms = [];

searchNameDurationInsert({bool filterOn = false}) async {
  searchTerms = List.generate(videoList.length, (_) => List.filled(2, 'a'));
  final start = DateTime.now();

  for (int i = 0; i < videoList.length; i++) {
    if (!filterOn) {
      searchTerms[i][0] = videoList[i].toString().split('/').last;
    } else {
      searchTerms[i][1] = await getVideoDurationForSearch(videoList[i]);
    }
  }
  final end = DateTime.now();
  log((end.difference(start)).toString());
  log(searchTerms.toString());
}

int searchScreenIndexOf({required String videoName}) {
  for (int i = 0; i < searchTerms.length; i++) {
    if (searchTerms[i][0] == videoName) {
      return i;
    }
  }
  return 0;
}

bool likedOrNot({required String string}) {
  return likedBox.values.contains(videoList[searchScreenIndexOf(videoName: string)]);
}
