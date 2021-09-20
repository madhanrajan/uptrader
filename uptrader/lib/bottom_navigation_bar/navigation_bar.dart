// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:uptrader/social_page/social_page_view.dart';
import 'package:uptrader/user_page/user_page_view.dart';
import 'package:uptrader/prediction_page/prediction_view.dart';
import '../Theme.dart';

class NavigationBar extends StatefulWidget {
  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  int thisindex = 0;

  Color tab0Color = Colors.red;
  Color tab1Color = SocialColor().themeColor;
  Color tab2Color = FeedColor().themeColor;
  // Change according to tab0color
  Color navBarColor = Colors.red;

  Widget normalNavBar() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.online_prediction), label: "Predictions"),
        BottomNavigationBarItem(icon: Icon(Icons.groups), label: "Social"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
      ],
      elevation: 5,
      onTap: reloadView,
      currentIndex: thisindex,
      selectedItemColor: navBarColor,
    );
  }

  Widget bottomNavBar() {
    return normalNavBar();
  }

  void reloadView(int index) {
    if (index == 0) {
      navBarColor = tab0Color;
    } else if (index == 1) {
      navBarColor = tab1Color;
    } else if (index == 2) {
      navBarColor = tab2Color;
    }
    setState(() {
      thisindex = index;
    });
  }

  Widget contentView() {
    if (thisindex == 0) {
      return PredictionView(backgroundColor: tab0Color);
    } else if (thisindex == 1) {
      return SocialPageView();
    } else {
      return UserPageView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNavBar(),
      body: contentView(),
    );
  }
}
