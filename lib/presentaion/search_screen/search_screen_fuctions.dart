import 'package:flare_video_player/infrastructure/fetched_directory_lists.dart';
import 'package:flare_video_player/presentaion/bottom_sheet/bottom_sheet_widget.dart';
import 'package:flare_video_player/presentaion/common_widgets/thumbnail_widget.dart';

List<List<dynamic>> searchTerms = [];

nameInsert() async {
  searchTerms = List.generate(videoList.length, (_) => List.filled(2, 'a'));

  for (int i = 0; i < videoList.length; i++) {
    for (int j = 0; j < 2; j++) {
      if (j == 0) searchTerms[i][j] = videoList[i].toString().split('/').last;
      if (j == 1) {
        searchTerms[i][j] = await getVideoDurationForSearch(videoList[i]);
      }
    }
  }
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
  return likedBox.values
      .contains(videoList[searchScreenIndexOf(videoName: string)]);
}
