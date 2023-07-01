import 'package:flare_video_player/colors.dart';
import 'package:flare_video_player/presentaion/left_side_drawer_screen/help_screen.dart';
import 'package:flare_video_player/presentaion/left_side_drawer_screen/settings_screen.dart';
import 'package:flutter/material.dart';

Widget drawerListView({required index, required context}) {
  return ListView(
    shrinkWrap: true,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        child: InkWell(
          onTap: () {
            if (index == 0) {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => const SettingsScreen()));
            }
            if (index == 1) {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => const HelpScreen()));
            }
          },
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Icon(
                  drawerList[index][0],
                  color: Color(secondaryColor),
                  size: 35,
                ),
              ),
              Text(
                drawerList[index][1],
                style: const TextStyle(fontSize: 22),
              ),
            ],
          ),
        ),
      )
    ],
  );
}

List drawerList = [
  [(Icons.settings), 'Settings'],
  [Icons.help, 'Help'],
  // [Icons.privacy_tip, 'Privacy Policy']
];

List drawerScreenList = [];
