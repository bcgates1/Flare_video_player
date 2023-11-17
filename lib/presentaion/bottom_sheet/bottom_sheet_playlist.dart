import 'package:flare_video_player/application/bloc/grid_bloc/grid_list_bloc.dart';
import 'package:flare_video_player/application/cubit/playlistcreate/cubit/playlist_create_cubit.dart';
import 'package:flare_video_player/domain/db/db_model.dart/model.dart';
import 'package:flare_video_player/presentaion/common_widgets/grid_view.dart';
import 'package:flare_video_player/presentaion/common_widgets/toast_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

TextEditingController textFieldController = TextEditingController();
playlistcreate(
    {required BuildContext context, required String iconText, required bool updateOrNot}) {
  // bool playlistExists = false; // new variable to track if playlist already exists
  return showDialog(
      context: context,
      builder: (context) {
        return BlocBuilder<PlaylistCreateCubit, PlaylistCreateState>(builder: (context, state) {
          return AlertDialog(
            title: const Text('Playlist Name'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: textFieldController,
                  decoration: InputDecoration(
                    hintText: "Enter the Playlist name",
                    errorText: state.playlistExists
                        ? 'Playlist already exists'
                        : null, // conditionally show error text
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  BlocProvider.of<PlaylistCreateCubit>(context).reserPlaylistExists();
                  Navigator.pop(context);
                },
              ),
              ElevatedButton(
                child: Text(iconText),
                onPressed: () async {
                  final playlistbox = Hive.box('Playlist');

                  if (textFieldController.text != '' &&
                      !(playlistbox.values.map((playlist) => playlist.playListName).toList())
                          .contains(textFieldController.text.trim()) &&
                      !updateOrNot) {
                    final newPlaylist =
                        Playlist(playListName: textFieldController.text.trim(), playListItems: []);
                    await playlistbox.add(newPlaylist);
                    toastMessage(message: 'New Playlist Created');
                    textFieldController.text = '';

                    if (!context.mounted) return;
                    BlocProvider.of<PlaylistCreateCubit>(context).reserPlaylistExists();

                    Navigator.pop(context);
                  } else if (!updateOrNot) {
                    // update playlistExists to show error text
                    BlocProvider.of<PlaylistCreateCubit>(context).playlistExists();
                  }
                  if (updateOrNot && textFieldController.text != '') {
                    if ((playlistbox.values.map((playlist) => playlist.playListName).toList())
                        .contains(textFieldController.text.trim())) {
                      // update playlistExists to show error text

                      BlocProvider.of<PlaylistCreateCubit>(context).playlistExists();
                    } else {
                      final playlistUpdate = playlistbox.getAt(playlistValue);
                      // print(playlistUpdate.playListName);
                      playlistUpdate.setPlaylistName(textFieldController.text);
                      playlistbox.putAt(playlistValue, playlistUpdate);

                      textFieldController.text = '';

                      BlocProvider.of<GridListBloc>(context).add(GridListEvent(
                          blocGridViewList: playlistbox.values
                              .map((playlist) => playlist.playListName)
                              .toList()as List<String>));

                      toastMessage(message: 'Playlist Name updated successfully');
                      if (!context.mounted) return;

                      BlocProvider.of<PlaylistCreateCubit>(context).reserPlaylistExists();
                      Navigator.pop(context);
                    }
                  }
                },
              ),
            ],
          );
        });
      });
}
