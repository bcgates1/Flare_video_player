import 'dart:developer';

import 'package:flare_video_player/application/bloc/grid_bloc/grid_list_bloc.dart';
import 'package:flare_video_player/infrastructure/fetched_directory_lists.dart';
import 'package:flare_video_player/presentaion/bottom_sheet/bottom_sheet_widget.dart';
import 'package:flare_video_player/colors.dart';
import 'package:flare_video_player/presentaion/common_widgets/thumbnail_widget.dart';
import 'package:flare_video_player/presentaion/common_widgets/video_player_screen.dart';
import 'package:flare_video_player/presentaion/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

// List gridViewList = [];
bool flag = false;
late int playlistValue;
// ValueNotifier<List> gridListValueNotifier = ValueNotifier(gridViewList);

class MyGridView extends StatelessWidget {
  late List gridViewList;
  MyGridView({super.key, required gridViewListLocal}) {
    this.gridViewList = gridViewListLocal;
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<GridListBloc>(context)
        .add(GridListEvent(blocGridViewList: gridViewList));

    return BlocBuilder<GridListBloc, GridListState>(
      builder: (context, state) {
        log('${state.gridViewList.toString()} gridViewList');
        return state.gridViewList.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.count(
                  crossAxisCount: flag == false ? 4 : 2,
                  // childAspectRatio: 1,
                  crossAxisSpacing: 6,
                  padding: const EdgeInsets.only(top: 10),
                  children: List.generate(
                    state.gridViewList.length,
                    (index) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              state.gridViewList[index].endsWith('.mp4') ||
                                      state.gridViewList[index].endsWith('.mkv')
                                  ? InkWell(
                                      child: thumbnailWidget(
                                          videoPath: state.gridViewList[index]),
                                      onTap: () {
                                        videoPathString = state
                                            .gridViewList[index]
                                            .toString();

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
                                          state.gridViewList = folderMapList[
                                              state.gridViewList[index]];
                                        }
                                        if (bottomNavIndex == 3 &&
                                            playlistbox.values.isNotEmpty) {
                                          final a = playlistbox.getAt(index);

                                          state.gridViewList = a.playListItems;
                                        }
                                        // gridListValueNotifier.value = gridViewList;
                                        // gridListValueNotifier.notifyListeners();
                                        BlocProvider.of<GridListBloc>(context)
                                            .add(GridListEvent(
                                                blocGridViewList:
                                                    state.gridViewList));

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
                                            bottomSheetList: state.gridViewList,
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
                                  state.gridViewList[index].endsWith('.mp4') ||
                                          state.gridViewList[index]
                                              .toString()
                                              .endsWith('.mkv')
                                      ? state.gridViewList[index]
                                          .toString()
                                          .split('/')
                                          .last
                                      : state.gridViewList[index],
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
                                          bottomSheetList: state.gridViewList,
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
