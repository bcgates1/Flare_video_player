import 'package:flare_video_player/application/bloc/grid_bloc/grid_list_bloc.dart';
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

  await Hive.openBox('History');
  await Hive.openBox('likedList');
  await Hive.openBox('Playlist');
  runApp(const Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GridListBloc(),
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
