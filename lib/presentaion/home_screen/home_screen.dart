import 'package:flare_video_player/application/bloc/grid_bloc/grid_list_bloc.dart';
import 'package:flare_video_player/colors.dart';
import 'package:flare_video_player/infrastructure/common_fuction.dart';
import 'package:flare_video_player/infrastructure/directory_fetch_fuction.dart';
import 'package:flare_video_player/infrastructure/common_lists.dart';
import 'package:flare_video_player/presentaion/common_widgets/toast_view.dart';
import 'package:flare_video_player/presentaion/common_widgets/grid_view.dart';
import 'package:flare_video_player/presentaion/history_screen/history_screen.dart';
import 'package:flare_video_player/presentaion/home_screen/home_screen_lists.dart';
import 'package:flare_video_player/presentaion/home_screen/widgets.dart';
import 'package:flare_video_player/presentaion/left_side_drawer_screen/drawer_screen.dart';
import 'package:flare_video_player/presentaion/search_screen/search_screen.dart';
import 'package:flare_video_player/infrastructure/search_screen_fuctions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

int bottomNavIndex = 0;
DateTime? currentBackPressTime;

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GridListBloc, GridListState>(
      builder: (context, state) {
        return Scaffold(
          drawer: SafeArea(
            child: Drawer(
              backgroundColor: Color(themeColor).withOpacity(.9),
              width: MediaQuery.sizeOf(context).width * .6,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Image.asset(
                      'assets/AppLogo.png',
                      fit: BoxFit.contain,
                    ),
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
                      },
                    ),
                  ),
                ],
              ),
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
                    toastMessage(message: 'Refreshing...');
                    folderList.clear();
                    folderMapList.clear();
                    await fetchAllVideoAndroid();
                    if (bottomNavIndex == 0 && flag == false) {
                      BlocProvider.of<GridListBloc>(context)
                          .add(GridListEvent(blocGridViewList: folderList as List<String>));
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
          body: WillPopScope(child: screenList[bottomNavIndex], onWillPop: onWillPop),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: bottomNavIndex,
            backgroundColor: Color(themeColor),
            selectedItemColor: Color(secondaryColor),
            onTap: (value) {
              bottomNavIndex = value;
              flag = false;

              BlocProvider.of<GridListBloc>(context)
                  .add(GridListEvent(blocGridViewList: navbar_list_update(index: value)));
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
              await searchNameDurationInsert();
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

Future<bool> onWillPop() {
  DateTime now = DateTime.now();
  if (currentBackPressTime == null ||
      now.difference(currentBackPressTime!) > Duration(seconds: 2) ||
      flag == true) {
    currentBackPressTime = now;
    if (flag && (bottomNavIndex == 0 || bottomNavIndex == 3)) {
      if (bottomNavIndex == 0) {
        toastMessage(message: 'For going back press Folder icons');
      } else {
        toastMessage(message: 'For going back press Playlist icons');
      }
    } else {
      toastMessage(message: 'Press back again to exit');
    }

    return Future.value(false);
  }
  return Future.value(true);
}
