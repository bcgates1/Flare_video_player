import 'package:bloc/bloc.dart';

part 'search_like_state.dart';

class SearchLikeCubit extends Cubit<SearchLikeState> {
  SearchLikeCubit() : super(SearchLikeState(searchLikeList: []));

  void searchLikeList(List searchLikeList) {
    emit(SearchLikeState(searchLikeList: searchLikeList));
  }
}
