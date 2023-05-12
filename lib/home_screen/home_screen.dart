// ignore_for_file: prefer_const_constructors

import 'package:flare_video_player/colors.dart';
import 'package:flare_video_player/common_widgets/toast_view.dart';
import 'package:flare_video_player/fetch_directory/directory_fetch_fuction.dart';
import 'package:flare_video_player/fetched_directory_lists.dart';
import 'package:flare_video_player/history_screen/history_screen.dart';
import 'package:flare_video_player/left_side_drawer_screen/drawer_screen.dart';
import 'package:flare_video_player/common_widgets/grid_view.dart';
import 'package:flare_video_player/folder_screen/folder_screen.dart';
import 'package:flare_video_player/home_screen/home_screen_lists.dart';
import 'package:flare_video_player/home_screen/widgets.dart';
import 'package:flare_video_player/liked_screen/liked_screen.dart';
import 'package:flare_video_player/playlist_screen/playlist_screen.dart';
import 'package:flare_video_player/search_screen/search_screen.dart';
import 'package:flare_video_player/search_screen/search_screen_fuctions.dart';
import 'package:flare_video_player/video_screen/video_screen.dart';
import 'package:flutter/material.dart';

int bottomNavIndex = 0;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey _bodyKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
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
                  gridListValueNotifier.value = gridViewList = folderList;
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
      body: KeyedSubtree(
        key: _bodyKey,
        child: screenList[bottomNavIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: bottomNavIndex,
        backgroundColor: Color(themeColor),
        selectedItemColor: Color(secondaryColor),
        onTap: (value) {
          setState(() {
            bottomNavIndex = value;
            // Force a rebuild of the body widget
            flag = false;
            _bodyKey = GlobalKey();
          });
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
  }
}

List screenList = [
  FolderScreen(),
  VideoScreen(),
  LikedScreen(),
  PlaylistScreen(),
];
