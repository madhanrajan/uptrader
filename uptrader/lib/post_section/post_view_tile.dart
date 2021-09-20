import 'package:flutter/material.dart';
import 'package:uptrader/post_section/PaginatedPost.dart';
import '../Theme.dart';

class PostViewTile extends StatelessWidget {
  PostViewTile({Key? key, required this.result, required this.baseColor});

  BaseColor baseColor;
  Result result;
  double width = 110;

  ButtonStyle getButtonStyle0() {
    return ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      )),
      backgroundColor: MaterialStateProperty.all<Color>(baseColor.upvoteColor),
      foregroundColor: MaterialStateProperty.all<Color>(baseColor.textColor),
    );
  }

  ButtonStyle getButtonStyle1() {
    return ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      )),
      backgroundColor: MaterialStateProperty.all<Color>(baseColor.commentColor),
      foregroundColor: MaterialStateProperty.all<Color>(baseColor.textColor),
    );
  }

  Widget getDateText() {
    return Text(
      "22 December",
      textAlign: TextAlign.end,
    );
  }

  ButtonStyle getButtonStyle2() {
    return ButtonStyle(
      elevation: MaterialStateProperty.all(0),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      )),
      backgroundColor: MaterialStateProperty.all<Color>(baseColor.themeColor),
      foregroundColor: MaterialStateProperty.all<Color>(baseColor.textColor),
    );
  }

  String getUpvoteText() {
    if (result.numberOfLikes == 0) {
      return "Upvote";
    } else if (result.numberOfLikes == 1) {
      return "1 like";
    } else {
      return "${result.numberOfLikes} likes";
    }
  }

  Widget getRow() {
    return Row(
      children: [
        SizedBox(
          width: width,
          child: ElevatedButton(
              style: getButtonStyle0(),
              onPressed: () {},
              child: Text(getUpvoteText())),
        ),
        Spacer(),
        SizedBox(
          width: width,
          child: ElevatedButton(
              style: getButtonStyle1(),
              onPressed: () {},
              child: Text("Comment")),
        ),
        Spacer(),
        SizedBox(
          width: width,
          child: ElevatedButton(
              style: getButtonStyle2(),
              onPressed: () {},
              child: Text("Visit group")),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
      child: InkWell(
        onTap: () {},
        child: Container(
            decoration: BoxDecoration(
                color: baseColor.postTileColor,
                borderRadius: BorderRadius.circular(20)),
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text(result.text,
                      style: TextStyle(color: baseColor.textColor)),
                ),
                getRow()
              ],
            )),
      ),
    );
  }
}
