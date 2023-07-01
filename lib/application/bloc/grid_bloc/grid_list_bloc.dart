import 'package:flutter_bloc/flutter_bloc.dart';

part 'grid_list_event.dart';
part 'grid_list_state.dart';

class GridListBloc extends Bloc<GridListEvent, GridListState> {
  GridListBloc() : super(GridListState(gridViewList: [])) {
    on<GridListEvent>((event, emit) {
      emit(GridListState(gridViewList: event.blocGridViewList));
    });
  }
}
