import 'package:flutter/material.dart';
import 'package:sliver_header_delegate/sliver_header_delegate.dart';
import '../user_page/Network/Groups.dart';
import 'package:uptrader/login/authentication.dart';
import 'dart:math';
import '../chat_page/chat_view.dart';
import '../post_section/post_view.dart';
import '../Theme.dart';

class SocialPageView extends StatelessWidget {
  BaseColor baseColor = SocialColor();

  SocialPageView({Key? key});
  Uri userUrl = Uri.parse("$hostUrl/social/group");
  String postUri = "$hostUrl/social/paginated_post/";

  String groupHeader = "Featured Chat Groups";
  String postHeader = "Featured Posts";

  String getHeaderText() {
    return "Social";
  }

  Widget groupTile({required Group group, required BuildContext context}) {
    return Container(
        padding: EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
              color: baseColor.themeColor,
              borderRadius: BorderRadius.circular(25)),
          child: ListTile(
            title: Text(group.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: baseColor.textColor,
                )),
            subtitle: Text("${group.id} id",
                style: TextStyle(
                  color: baseColor.textColor,
                )),
            trailing: Icon(
              Icons.arrow_right_sharp,
              color: baseColor.textColor,
              size: 40,
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PreChatView(group: group)));
            },
          ),
        ));
  }

  Widget groupView(
      {required List<Group> groupList, required BuildContext context}) {
    return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
      return groupTile(group: groupList[index], context: context);
    }, childCount: min(3, groupList.length)));
  }

  Widget appBar() {
    return SliverPersistentHeader(
      pinned: true,
      delegate: FlexibleHeaderDelegate(
        expandedHeight: kToolbarHeight * 1.05,
        collapsedElevation: 1,
        backgroundColor: baseColor.background,
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          )
        ],
        children: [
          FlexibleTextItem(
            text: getHeaderText(),
            expandedStyle: TextStyle(
                fontSize: 30,
                color: baseColor.textColor,
                fontWeight: FontWeight.bold),
            collapsedStyle: TextStyle(
                fontSize: 18,
                color: baseColor.textColor,
                fontWeight: FontWeight.bold),
            expandedAlignment: Alignment.bottomLeft,
            collapsedAlignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 12),
          ),
        ],
      ),
    );
  }

  Widget groupTitle() {
    return SliverToBoxAdapter(
        child: Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
            child: Text(groupHeader,
                style: TextStyle(
                    color: baseColor.textColor,
                    fontSize: TextSize.get.subtitleSize,
                    fontWeight: FontWeight.bold))));
  }

  Widget postTitle() {
    return SliverToBoxAdapter(
        child: Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
            child: Text(postHeader,
                style: TextStyle(
                    color: baseColor.textColor,
                    fontSize: TextSize.get.subtitleSize,
                    fontWeight: FontWeight.bold))));
  }

  Widget getPostView() {
    return FutureBuilder<String>(
        future: Authentication.instance.getIdToken(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return PostView(
              uri: postUri,
              token: snapshot.data!,
              baseColor: baseColor,
            );
          } else {
            return SliverToBoxAdapter(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }

  // ignore: non_constant_identifier_names
  Widget customScrollView(
      {required List<Group> groupList, required BuildContext context}) {
    return CustomScrollView(
      slivers: [
        appBar(),
        groupTitle(),
        groupView(groupList: groupList, context: context),
        postTitle(),
        getPostView()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: baseColor.background,
      child: SafeArea(
          child: AuthenticatedFutureBuilder(userUrl, (context, snapshot) {
        if (snapshot.hasData) {
          List<Group> groupList = groupFromJson(snapshot.data!.body);
          return customScrollView(groupList: groupList, context: context);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      })),
    ));
  }
}
