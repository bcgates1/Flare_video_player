import 'package:flare_video_player/application/bloc/grid_bloc/grid_list_bloc.dart';
import 'package:flare_video_player/colors.dart';
import 'package:flare_video_player/infrastructure/directory_fetch_fuction.dart';
import 'package:flare_video_player/infrastructure/fetched_directory_lists.dart';
import 'package:flare_video_player/presentaion/common_widgets/toast_view.dart';
import 'package:flare_video_player/presentaion/common_widgets/grid_view.dart';
import 'package:flare_video_player/presentaion/folder_screen/folder_screen.dart';
import 'package:flare_video_player/presentaion/history_screen/history_screen.dart';
import 'package:flare_video_player/presentaion/home_screen/home_screen_lists.dart';
import 'package:flare_video_player/presentaion/home_screen/widgets.dart';
import 'package:flare_video_player/presentaion/left_side_drawer_screen/drawer_screen.dart';
import 'package:flare_video_player/presentaion/liked_screen/liked_screen.dart';
import 'package:flare_video_player/presentaion/playlist_screen/playlist_screen.dart';
import 'package:flare_video_player/presentaion/search_screen/search_screen.dart';
import 'package:flare_video_player/presentaion/search_screen/search_screen_fuctions.dart';
import 'package:flare_video_player/presentaion/video_screen/video_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

int bottomNavIndex = 0;

class HomeScreen extends StatelessWidget {
  GlobalKey _bodyKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GridListBloc, GridListState>(
      builder: (context, state) {
        return Scaffold(
          drawer: Drawer(
            backgroundColor: Color(themeColor),
            child: Column(
              children: [
                Image.asset(
                  'assets/AppLogo.png',
                  fit: BoxFit.contain,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: drawerList.length,
                      itemBuilder: (BuildContext context, i) {
                        return drawerListView(index: i, context: context);
                      }),
                ),
              ],
            ),
          ),
          appBar: AppBar(
            title: Text(
              bottomNavLabel[bottomNavIndex],
              style: TextStyle(color: Color(secondaryColor), fontSize: 25),
            ),
            actions: [
              IconButton(
                  //change conditions for each screen!!!!!!!!
                  onPressed: () async {
                    toastMessage(message: 'Refreshing');
                    folderList.clear();
                    videoList.clear();
                    folderMapList.clear();
                    await videoFetch();
                    if (bottomNavIndex == 0 && flag == false) {
                      // gridListValueNotifier.value = gridViewList = folderList;
                      BlocProvider.of<GridListBloc>(context)
                          .add(GridListEvent(blocGridViewList: folderList));
                    }
                  },
                  icon: Icon(
                    Icons.refresh,
                    color: Color(secondaryColor),
                    size: 30,
                  )),
              iconButtonFunction(
                iconName: Icons.history,
                color: secondaryColor,
                context: context,
                screen: HistoryScreen(),
              )
            ],
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: const Icon(Icons.menu),
                  color: Color(secondaryColor),
                );
              },
            ),
          ),
          body: screenList[bottomNavIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: bottomNavIndex,
            backgroundColor: Color(themeColor),
            selectedItemColor: Color(secondaryColor),
            onTap: (value) {
              bottomNavIndex = value;
              flag = false;

              // Force a rebuild of the body widget
              // _bodyKey = GlobalKey();
              BlocProvider.of<GridListBloc>(context)
                  .add(GridListEvent(blocGridViewList: []));
            },
            items: List.generate(bottomNavIcon.length, (index) {
              return BottomNavigationBarItem(
                icon: Icon(
                  bottomNavIcon[index],
                  size: 35,
                ),
                label: bottomNavLabel[index],
              );
            }),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await nameInsert();
              if (!context.mounted) return;
              showSearch(
                  context: context,
                  // delegate to customize the search bar
                  delegate: CustomSearchDelegate());
            },
            backgroundColor: Color(themeColor),
            child: Icon(
              Icons.search,
              color: Color(secondaryColor),
            ),
          ),
        );
      },
    );
  }
}

List screenList = [
  FolderScreen(),
  VideoScreen(),
  LikedScreen(),
  PlaylistScreen(),
];
