import 'package:bloc/bloc.dart';


part 'history_screen_state.dart';

class HistoryScreenCubit extends Cubit<HistoryScreenState> {
  HistoryScreenCubit() : super(HistoryScreenState(historyList: []));

  void historyList(List historyList) {
    emit(HistoryScreenState(historyList: historyList));
  }
}
