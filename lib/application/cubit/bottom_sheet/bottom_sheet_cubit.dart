import 'package:bloc/bloc.dart';

part 'bottom_sheet_state.dart';

class BottomSheetCubit extends Cubit<BottomSheetState> {
  BottomSheetCubit() : super(BottomSheetState(showCreatePlaylistOption: false));

  void showCreatePlaylistOption({required bool showCreatePlaylistOption}) {
    emit(BottomSheetState(showCreatePlaylistOption: showCreatePlaylistOption));
  }
}
