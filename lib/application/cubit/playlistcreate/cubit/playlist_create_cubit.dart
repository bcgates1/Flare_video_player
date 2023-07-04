import 'package:bloc/bloc.dart';

part 'playlist_create_state.dart';

class PlaylistCreateCubit extends Cubit<PlaylistCreateState> {
  PlaylistCreateCubit() : super(PlaylistCreateState(playlistExists: false));
  playlistExists() {
    emit(PlaylistCreateState(playlistExists: true));
  }

  reserPlaylistExists() {
    emit(PlaylistCreateState(playlistExists: false));
  }
}
