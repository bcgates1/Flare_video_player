import 'package:flare_video_player/bottom_sheet/bottom_sheet_widget.dart';
import 'package:flare_video_player/colors.dart';
import 'package:flare_video_player/common_widgets/grid_view.dart';
import 'package:flare_video_player/common_widgets/thumbnail_widget.dart';
import 'package:flare_video_player/common_widgets/video_player_screen.dart';
import 'package:flare_video_player/fetched_directory_lists.dart';
import 'package:flare_video_player/home_screen/home_screen.dart';
import 'package:flare_video_player/search_screen/search_screen_fuctions.dart';
import 'package:flutter/material.dart';

ValueNotifier searchScreenLike = ValueNotifier(likedBox.values);

class CustomSearchDelegate extends SearchDelegate {
  bool filter1 = false;
  int filter1Value = 20000;

  bool filter2 = false;
  int filter2Value = 60000;

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context);
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(
          Icons.clear,
          color: Color(secondaryColor),
        ),
      ),
      PopupMenuButton(
        itemBuilder: (BuildContext context) {
          return [
            PopupMenuItem(
              child: const Text("video < 20 sec"),
              onTap: () {
                filter1 = !filter1;
                filter2 = false;
                query = '';
              },
            ),
            PopupMenuItem(
              child: const Text("video > 1min"),
              onTap: () {
                filter2 = !filter2;
                filter1 = false;
                query = '';
              },
            ),
            PopupMenuItem(
              child: const Text("All video"),
              onTap: () {
                filter1 = filter2 = false;
                query = '';
              },
            ),
          ];
        },
        icon: Icon(
          Icons.filter_alt_rounded,
          color: Color(secondaryColor),
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
        if (bottomNavIndex == 2) {
          gridListValueNotifier.value = gridViewList = likedBox.values.toList();
        }
        if (bottomNavIndex == 3) {
          gridListValueNotifier.value = gridViewList = playlistbox.values
              .map((playlist) => playlist.playListName)
              .toList();
        }
      },
      icon: Icon(
        Icons.arrow_back,
        color: Color(secondaryColor),
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    searchFilter(matchQuery);
    return matchQuery.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListView.builder(
              itemCount: matchQuery.length,
              itemBuilder: (context, index) {
                var result = matchQuery[index];
                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.only(top: 15),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    tileColor: Color(themeColor),
                    leading: InkWell(
                      onTap: () {
                        videoPathString =
                            videoList[searchScreenIndexOf(videoName: result)];
                        close(context, null);
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const VideoPlayer(),
                        ));
                      },
                      child: SizedBox(
                        width: 120,
                        child: thumbnailWidget(
                            videoPath: videoList[
                                searchScreenIndexOf(videoName: result)]),
                      ),
                    ),
                    title: Text(
                      result,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ValueListenableBuilder(
                          valueListenable: searchScreenLike,
                          builder: (BuildContext context, value, _) {
                            return IconButton(
                                onPressed: () {
                                  if (likedOrNot(string: result)) {
                                    likedBox.delete(videoList[
                                        searchScreenIndexOf(
                                            videoName: result)]);
                                  } else {
                                    likedBox.put(
                                        videoList[searchScreenIndexOf(
                                            videoName: result)],
                                        videoList[searchScreenIndexOf(
                                            videoName: result)]);
                                  }
                                  searchScreenLike.value = likedBox.values;
                                },
                                icon: likedOrNot(string: result)
                                    ? const Icon(
                                        Icons.favorite_sharp,
                                        color: Colors.red,
                                      )
                                    : const Icon(Icons.favorite_border));
                          },
                        ),
                        IconButton(
                          onPressed: () {
                            showMyBottomSheet(
                                context: context,
                                index: searchScreenIndexOf(videoName: result),
                                bottomSheetList: videoList,
                                showCreatePlaylistOption: true);
                          },
                          icon: const Icon(Icons.playlist_add),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        : const Center(
            child: Text('Empty'),
          );
  }

  void searchFilter(List<String> matchQuery) {
    for (var searchText in searchTerms) {
      bool searchFoundorNot =
          searchText[0].toString().toLowerCase().contains(query.toLowerCase());

      if (filter1) {
        if (searchFoundorNot && (searchText[1] <= filter1Value)) {
          matchQuery.add(searchText[0]);
        }
      } else if (filter2) {
        if (searchFoundorNot && (searchText[1] >= filter2Value)) {
          matchQuery.add(searchText[0]);
        }
      } else if (searchFoundorNot) {
        matchQuery.add(searchText[0]);
      }
    }
  }
}
