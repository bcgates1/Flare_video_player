import 'package:flare_video_player/application/bloc/grid_bloc/grid_list_bloc.dart';
import 'package:flare_video_player/application/cubit/bottom_sheet/bottom_sheet_cubit.dart';
import 'package:flare_video_player/presentaion/bottom_sheet/bottom_sheet_list.dart';
import 'package:flare_video_player/presentaion/bottom_sheet/bottom_sheet_playlist.dart';
import 'package:flare_video_player/colors.dart';
import 'package:flare_video_player/presentaion/common_widgets/grid_view.dart';
import 'package:flare_video_player/presentaion/common_widgets/toast_view.dart';
import 'package:flare_video_player/presentaion/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'dart:developer';

final likedBox = Hive.box('likedList');
final playlistbox = Hive.box('Playlist');

showMyBottomSheet({
  required BuildContext context,
  required int index,
  required List bottomSheetList,
}) {
  return showModalBottomSheet(
    backgroundColor: Color(themeColor).withOpacity(.9),
    context: context,
    builder: (BuildContext context) {
      return MyBottomSheet(
        context: context,
        list: bottomSheetLists[bottomNavIndex],
        index: index,
        bottomSheetList: bottomSheetList,
      );
    },
  );
}

class MyBottomSheet extends StatelessWidget {
  final BuildContext context;
  final List list;
  final int index;
  final List bottomSheetList;

  MyBottomSheet({
    super.key,
    required this.context,
    required this.list,
    required this.index,
    required this.bottomSheetList,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<BottomSheetCubit>(context);

    return BlocBuilder<BottomSheetCubit, BottomSheetState>(
      builder: (context, state) {
        return !(state.showCreatePlaylistOption)
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListView.builder(
                    itemCount: list.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () async {
                          if (index == 0) {
                            if (likedBox.values.contains(bottomSheetList[this.index])) {
                              likedBox.delete(bottomSheetList[this.index]);

                              if (bottomNavIndex == 2) {
                                BlocProvider.of<GridListBloc>(context).add(GridListEvent(
                                    blocGridViewList: likedBox.values.toList() as List<String>));
                              }
                              toastMessage(message: 'video removed from liked list');
                            } else {
                              likedBox.put(
                                  bottomSheetList[this.index], bottomSheetList[this.index]);
                              toastMessage(message: 'video added to liked list');
                            }

                            Navigator.of(context).pop();
                          }
                          if (index == 1 && bottomNavIndex != 3) {
                            cubit.showCreatePlaylistOption(showCreatePlaylistOption: true);
                          }

                          if (index == 1 && bottomNavIndex == 3 && flag == false) {
                            playlistbox.deleteAt(this.index);
                            List playlistNames = playlistbox.values
                                .map((playlist) => playlist.playListName)
                                .toList();

                            BlocProvider.of<GridListBloc>(context).add(
                                GridListEvent(blocGridViewList: playlistNames as List<String>));
                            log('${playlistNames.toString()} playlist names');

                            toastMessage(message: 'Playlist deleted');

                            Navigator.of(context).pop();
                          } else if (index == 1 && bottomNavIndex == 3 && flag == true) {
                            final playlist = playlistbox.getAt(playlistValue);
                            playlist.playListItems.removeAt(this.index);

                            await playlistbox.putAt(playlistValue, playlist);

                            if (playlistbox.values.isNotEmpty) {
                              final a = playlistbox.getAt(playlistValue);

                              BlocProvider.of<GridListBloc>(context)
                                  .add(GridListEvent(blocGridViewList: a.playListItems));
                            } else {
                              BlocProvider.of<GridListBloc>(context)
                                  .add(GridListEvent(blocGridViewList: []));
                            }

                            toastMessage(message: 'Video deleted from playlist');

                            Navigator.of(context).pop();
                          }
                          if (index == 2 /*look list*/ && bottomNavIndex == 3) {
                            textFieldController.text = bottomSheetList[this.index];
                            Navigator.of(context).pop();

                            playlistcreate(context: context, iconText: 'Update', updateOrNot: true);
                          }
                        },
                        splashColor: Colors.black,
                        child: (flag == false &&
                                    index == 0 &&
                                    (bottomNavIndex == 0 || bottomNavIndex == 3) ||
                                (index == 2 && flag == true))
                            ? Container()
                            : ListTile(
                                leading: Icon(
                                  index == 0
                                      ? likedBox.values.contains(bottomSheetList[this.index])
                                          ? Icons.favorite_sharp
                                          : list[index][0]
                                      : list[index][0],
                                  color: Color(secondaryColor),
                                ),
                                title: (flag == false && index == 0) &&
                                            (bottomNavIndex == 0 || bottomNavIndex == 3) ||
                                        (index == 2 && flag == true)
                                    ? null
                                    : Text(
                                        index == 0
                                            ? likedBox.values.contains(bottomSheetList[this.index])
                                                ? 'Unlike'
                                                : list[index][1]
                                            : bottomNavIndex == 3 && flag == false && index == 1
                                                ? 'Delete Playlist'
                                                : list[index][1],
                                        style: TextStyle(color: Color(secondaryColor)),
                                      ),
                              ),
                      );
                    },
                  ),
                ],
              )
            : Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Navigator.of(context).pop();

                      playlistcreate(context: context, iconText: 'OK', updateOrNot: false);
                    },
                    child: const Text('Create Playlist'),
                  ),
                  Flexible(
                    child: ListView.builder(
                      itemCount: playlistbox.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: ElevatedButton(
                            onPressed: () async {
                              final playlist = playlistbox.getAt(index);
                              log('${playlist.playListItems} playlist');

                              if (!(playlist.playListItems.contains(bottomSheetList[this.index]))) {
                                playlist.playListItems.add(bottomSheetList[this.index]);
                                toastMessage(message: 'Video added to playlist');
                                await playlistbox.putAt(index, playlist);
                              } else {
                                toastMessage(message: 'Video already exists in playlist');
                              }
                              Navigator.of(context).pop();
                            },
                            child: Text(playlistbox.getAt(index).playListName),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
      },
    );
  }
}
