import 'package:flare_video_player/bottom_sheet/bottom_sheet_widget.dart';
import 'package:flare_video_player/colors.dart';
import 'package:flare_video_player/common_widgets/thumbnail_widget.dart';
import 'package:flare_video_player/common_widgets/video_player_screen.dart';
import 'package:flare_video_player/fetched_directory_lists.dart';
import 'package:flare_video_player/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

List gridViewList = [];
bool flag = false;
late int playlistValue;
ValueNotifier<List> gridListValueNotifier = ValueNotifier(gridViewList);

class MyGridView extends StatelessWidget {
  MyGridView({super.key, required gridViewListLocal}) {
    gridViewList = gridViewListLocal;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: gridListValueNotifier,
      builder: (context, value, _) {
        return gridViewList.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.count(
                  crossAxisCount: flag == false ? 4 : 2,
                  // childAspectRatio: 1,
                  crossAxisSpacing: 6,
                  padding: const EdgeInsets.only(top: 10),
                  children: List.generate(
                    gridViewList.length,
                    (index) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              gridViewList[index].endsWith('.mp4') ||
                                      gridViewList[index].endsWith('.mkv')
                                  ? InkWell(
                                      child: thumbnailWidget(
                                          videoPath: gridViewList[index]),
                                      onTap: () {
                                        videoPathString =
                                            gridViewList[index].toString();

                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) =>
                                              const VideoPlayer(),
                                        ));
                                      },
                                    )
                                  : InkWell(
                                      onTap: () {
                                        final playlistbox =
                                            Hive.box('Playlist');
                                        if (bottomNavIndex == 0 ||
                                            bottomNavIndex == 1 ||
                                            bottomNavIndex == 2) {
                                          gridViewList = folderMapList[
                                              gridViewList[index]];
                                        }
                                        if (bottomNavIndex == 3 &&
                                            playlistbox.values.isNotEmpty) {
                                          final a = playlistbox.getAt(index);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              

                                          gridViewList = a.playListItems;
                                        }
                                        // gridListValueNotifier.value = gridViewList;
                                        gridListValueNotifier.notifyListeners();

                                        if (bottomNavIndex == 3 &&
                                            flag == false) {
                                          playlistValue = index;
                                        }
                                        flag = true;
                                      },
                                      onLongPress: () {
                                        if (bottomNavIndex == 3) {
                                          playlistValue = index;
                                          showMyBottomSheet(
                                            context: context,
                                            index: index,
                                            bottomSheetList: gridViewList,
                                            showCreatePlaylistOption: false,
                                          );
                                        }
                                      },
                                      child: Icon(
                                        Icons.folder,
                                        size: 50,
                                        color: Color(secondaryColor),
                                      ),
                                    ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: flag == false
                                    ? const EdgeInsets.only(top: 0)
                                    : const EdgeInsets.only(left: 15),
                              ),
                              Flexible(
                                child: Text(
                                  gridViewList[index].endsWith('.mp4') ||
                                          gridViewList[index]
                                              .toString()
                                              .endsWith('.mkv')
                                      ? gridViewList[index]
                                          .toString()
                                          .split('/')
                                          .last
                                      : gridViewList[index],
                                  style: const TextStyle(
                                      // height: 2,
                                      fontSize: 16,
                                      overflow: TextOverflow.ellipsis),
                                  maxLines: 2,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              (flag == false &&
                                      (bottomNavIndex == 3 ||
                                          bottomNavIndex == 0))
                                  ? const SizedBox(
                                      width: 0,
                                    )
                                  : InkWell(
                                      onTap: () {
                                        showMyBottomSheet(
                                          context: context,
                                          index: index,
                                          bottomSheetList: gridViewList,
                                          showCreatePlaylistOption: false,
                                        );
                                      },
                                      child: Icon(
                                        Icons.more_vert,
                                        color: Color(themeColor),
                                      ),
                                    ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
              )
            : const Center(
                child: Text('Empty'),
              );
      },
    );
  }
}
