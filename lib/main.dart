import 'package:flare_video_player/application/bloc/grid_bloc/grid_list_bloc.dart';
import 'package:flare_video_player/application/cubit/bottom_sheet/bottom_sheet_cubit.dart';
import 'package:flare_video_player/application/cubit/history_screen/cubit/history_screen_cubit.dart';
import 'package:flare_video_player/application/cubit/playlistcreate/cubit/playlist_create_cubit.dart';
import 'package:flare_video_player/application/cubit/search_screen/search_like_cubit.dart';
import 'package:flare_video_player/application/cubit/video_player/cubit/video_screen_cubit.dart';
import 'package:flare_video_player/colors.dart';
import 'package:flare_video_player/domain/db/db_model.dart/model.dart';
import 'package:flare_video_player/presentaion/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main(List<String> args) async {
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  final appDocDir = await getApplicationDocumentsDirectory();

  Hive
    ..init(appDocDir.path)
    ..registerAdapter(LikedListAdapter())
    ..registerAdapter(PlaylistAdapter())
    ..registerAdapter(HistoryListAdapter());

  await Hive
    ..openBox('History')
    ..openBox('likedList')
    ..openBox('Playlist');
  runApp(const Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GridListBloc()),
        BlocProvider(create: (context) => BottomSheetCubit()),
        BlocProvider(create: (context) => SearchLikeCubit()),
        BlocProvider(create: (context) => HistoryScreenCubit()),
        BlocProvider(create: (context) => VideoScreenCubit()),
        BlocProvider(create: (context) => PlaylistCreateCubit()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          appBarTheme: AppBarTheme(backgroundColor: Color(themeColor)),
        ),
        title: 'Flare Video Player',
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
