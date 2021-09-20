import 'package:flutter/material.dart';
import 'package:sliver_header_delegate/sliver_header_delegate.dart';
import 'package:uptrader/social_page/social_page_view.dart';
import './Network/Groups.dart';
import 'package:uptrader/login/authentication.dart';
import '../Theme.dart';
import 'dart:math';
import '../chat_page/chat_view.dart';

class UserPageView extends SocialPageView {
  @override
  Uri userUrl = Uri.parse("$hostUrl/social/group/list_user_groups");

  @override
  String postUri = "$hostUrl/social/user_paginated_post/";

  @override
  BaseColor baseColor = FeedColor();

  @override
  String getHeaderText() {
    // TODO: implement getHeaderText
    return "Username";
  }

  @override
  String groupHeader = "Groups";

  @override
  String postHeader = "Posts";
}
