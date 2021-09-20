import 'package:flutter/material.dart';
import 'package:sliver_header_delegate/sliver_header_delegate.dart';
import 'add_prediction_view.dart';

class PredictionView extends StatelessWidget {
  final Color backgroundColor;

  PredictionView({required this.backgroundColor});

  late final BuildContext context;

  void addPrediction() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                AddPredictionView(backgroundColor: backgroundColor)));
  }

  Widget appBar() {
    return SliverPersistentHeader(
      pinned: true,
      delegate: FlexibleHeaderDelegate(
        expandedHeight: kToolbarHeight * 1.1,
        collapsedElevation: 0,
        backgroundColor: backgroundColor,
        actions: [
          IconButton(onPressed: addPrediction, icon: Icon(Icons.add_circle)),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          )
        ],
        children: [
          FlexibleTextItem(
            text: "Featured Predictors",
            expandedStyle: TextStyle(
                fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
            collapsedStyle: TextStyle(
                fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
            expandedAlignment: Alignment.bottomLeft,
            collapsedAlignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 12),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
          child: CustomScrollView(
        slivers: [
          appBar(),
        ],
      )),
    );
  }
}
