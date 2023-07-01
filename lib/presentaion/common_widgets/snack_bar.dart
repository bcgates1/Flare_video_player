import 'package:flare_video_player/colors.dart';
import 'package:flutter/material.dart';

snackBarMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(SnackBar(
      // width: 240,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.only(bottom: 520),
      duration: const Duration(seconds: 5),
      content: Center(
        child: Text(
          message,
          style: TextStyle(
              color: Color(secondaryColor),
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Color(themeColor).withOpacity(0),
      // elevation: 5,
    ));
}
