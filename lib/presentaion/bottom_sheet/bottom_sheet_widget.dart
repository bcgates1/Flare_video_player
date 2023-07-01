import 'package:flare_video_player/application/bloc/grid_bloc/grid_list_bloc.dart';
import 'package:flare_video_player/presentaion/bottom_sheet/bottom_sheet_list.dart';
import 'package:flare_video_player/presentaion/bottom_sheet/bottom_sheet_playlist.dart';
import 'package:flare_video_player/colors.dart';
import 'package:flare_video_player/presentaion/common_widgets/grid_view.dart';
import 'package:flare_video_player/presentaion/common_widgets/toast_view.dart';
import 'package:flare_video_player/presentaion/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

final likedBox = Hive.box('likedList');
final playlistbox = Hive.box('Playlist');

showMyBottomSheet(
    {required BuildContext context,
    required int index,
    required List bottomSheetList,
    required bool showCreatePlaylistOption}) {
  return showModalBottomSheet(
    backgroundColor: Color(themeColor).withOpacity(.9),
    context: context,
    builder: (BuildContext context) {
      return MyBottomSheet(
        context: context,
        list: bottomSheetLists[bottomNavIndex],
        index: index,
        bottomSheetList: bottomSheetList,
        showCreatePlaylistOption: showCreatePlaylistOption,
      );
    },
  );
}

class MyBottomSheet extends StatefulWidget {
  final BuildContext context;
  final List list;
  int index;
  List bottomSheetList;
  bool showCreatePlaylistOption;

  MyBottomSheet({
    super.key,
    required this.context,
    required this.list,
    required this.index,
    required this.bottomSheetList,
    required this.showCreatePlaylistOption,
  });

  @override
  _MyBottomSheetState createState() => _MyBottomSheetState();
}

class _MyBottomSheetState extends State<MyBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return !(widget.showCreatePlaylistOption)
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ListView.builder(
                itemCount: widget.list.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async {
                      if (index == 0) {
                        if (likedBox.values
                            .contains(widget.bottomSheetList[widget.index])) {
                          likedBox.delete(widget.bottomSheetList[widget.index]);

                          if (bottomNavIndex == 2) {
                            // gridListValueNotifier.value =
                            //     gridViewList = likedBox.values.toList();

                            // gridListValueNotifier.notifyListeners();
                            BlocProvider.of<GridListBloc>(context).add(
                                GridListEvent(
                                    blocGridViewList:
                                        likedBox.values.toList()));
                          }
                        } else {
                          likedBox.put(widget.bottomSheetList[widget.index],
                              widget.bottomSheetList[widget.index]);
                        }

                        Navigator.of(context).pop();
                      }
                      if (index == 1 && bottomNavIndex != 3) {
                        setState(() {
                          widget.showCreatePlaylistOption = true;
                        });
                      }

                      if (index == 1 && bottomNavIndex == 3 && flag == false) {
                        playlistbox.deleteAt(widget.index);

                        // gridListValueNotifier.value = gridViewList = playlistbox
                        //     .values
                        //     .map((playlist) => playlist.playListName)
                        //     .toList();

                        BlocProvider.of<GridListBloc>(context).add(
                            GridListEvent(
                                blocGridViewList: playlistbox.values
                                    .map((playlist) => playlist.playListName)
                                    .toList()));

                        toastMessage(message: 'Playlist deleted');

                        Navigator.of(context).pop();
                      } else if (index == 1 &&
                          bottomNavIndex == 3 &&
                          flag == true) {
                        final playlist = playlistbox.getAt(playlistValue);
                        playlist.playListItems.removeAt(widget.index);

                        await playlistbox.putAt(playlistValue, playlist);
                        toastMessage(message: 'Video deleted from playlist');

                        Navigator.of(context).pop();
                        // gridListValueNotifier.notifyListeners();******************************
                      }
                      if (index == 2 /*look list*/ && bottomNavIndex == 3) {
                        // textFieldController.text = gridViewList[widget.index];

                        playlistcreate(
                            context: context,
                            iconText: 'Update',
                            updateOrNot: true);
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
                                  ? likedBox.values.contains(
                                          widget.bottomSheetList[widget.index])
                                      ? Icons.favorite_sharp
                                      : widget.list[index][0]
                                  : widget.list[index][0],
                              color: Color(secondaryColor),
                            ),
                            title: (flag == false && index == 0) &&
                                        (bottomNavIndex == 0 ||
                                            bottomNavIndex == 3) ||
                                    (index == 2 && flag == true)
                                ? null
                                : Text(
                                    index == 0
                                        ? likedBox.values.contains(widget
                                                .bottomSheetList[widget.index])
                                            ? 'Unlike'
                                            : widget.list[index][1]
                                        : bottomNavIndex == 3 &&
                                                flag == false &&
                                                index == 1
                                            ? 'Delete Playlist'
                                            : widget.list[index][1],
                                    style:
                                        TextStyle(color: Color(secondaryColor)),
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
                  Navigator.of(context).pop();

                  playlistcreate(
                      context: context, iconText: 'OK', updateOrNot: false);
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

                          if (!(playlist.playListItems.contains(
                              widget.bottomSheetList[widget.index]))) {
                            playlist.playListItems
                                .add(widget.bottomSheetList[widget.index]);
                            toastMessage(message: 'Video added to playlist');
                            await playlistbox.putAt(index, playlist);
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
  }
}
