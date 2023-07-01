import 'package:flutter/material.dart';

iconButtonFunction(
    {required iconName,
    required color,
    required Widget screen,
    required context}) {
  return IconButton(
    onPressed: () {
      Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => screen));
    },
    icon: Icon(
      iconName,
      color: Color(color),
      size: 35,
    ),
  );
}
