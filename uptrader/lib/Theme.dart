import 'package:flutter/material.dart';

// ED2651

class SocialColor implements BaseColor {
  Color background = Colors.black;
  Color textColor = Colors.white;
  Color themeColor = Color(0xffff8e03);
  Color upvotedColor = Color(0xff61DA5B);
  Color postTileColor = Color(0xff212121);
  Color commentColor = Colors.grey[850]!;
  Color upvoteColor = Colors.blue;
}

class FeedColor implements BaseColor {
  Color background = Colors.black;
  Color textColor = Colors.white;
  Color themeColor = Color(0xff982CA0);
  Color upvotedColor = Color(0xff61DA5B);
  Color postTileColor = Color(0xff212121);
  Color commentColor = Colors.grey[850]!;
  Color upvoteColor = Colors.blue;
}

class TextSize {
  TextSize._private();
  static final TextSize get = TextSize._private();
  double subtitleSize = 20;
}

abstract class BaseColor {
  Color background = Color(0xff982CA0);
  Color textColor = Colors.white;
  Color themeColor = Colors.purple;
  Color upvotedColor = Color(0xff61DA5B);
  Color postTileColor = Color(0xff6A0771);
  Color commentColor = Colors.grey[850]!;
  Color upvoteColor = Colors.blue;
}
