import 'package:flare_video_player/application/cubit/history_screen/cubit/history_screen_cubit.dart';
import 'package:flare_video_player/colors.dart';
import 'package:flare_video_player/presentaion/common_widgets/thumbnail_widget.dart';
import 'package:flare_video_player/presentaion/common_widgets/video_player_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final historyListBox = Hive.box('History');
    // final cubit = BlocProvider.of<HistoryScreenCubit>(context);

    // cubit.historyList(historyListBox.values.toList());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'History',
          style: TextStyle(color: Color(secondaryColor), fontSize: 25),
        ),
        iconTheme: IconThemeData(color: Color(secondaryColor)),
      ),
      body: BlocBuilder<HistoryScreenCubit, HistoryScreenState>(
        builder: (context, value) {
          return Hive.box('history').values.isNotEmpty
              ? GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 1.2,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  children: List.generate(
                    historyListBox.length,
                    (index) {
                      return InkWell(
                        onTap: () {
                          videoPathString = historyListBox.getAt(historyListBox.length - 1 - index);
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const VideoPlayer(),
                          ));

                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (_) =>
                          //         BlocProvider<HistoryScreenCubit>.value(
                          //       value: BlocProvider.of<HistoryScreenCubit>(
                          //           context),
                          //       child: VideoPlayer(),
                          //     ),
                          //   ),
                          // );
                        },
                        child: Column(
                          children: [
                            thumbnailWidget(
                                videoPath: historyListBox.getAt(historyListBox.length - 1 - index)),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0, top: 10),
                              child: Text(
                                historyListBox
                                    .getAt(historyListBox.length - 1 - index)
                                    .toString()
                                    .split('/')
                                    .last,
                                style: const TextStyle(fontSize: 16),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                )
              : Center(
                  child: Text('Empty'),
                );
        },
      ),
    );
  }
}
