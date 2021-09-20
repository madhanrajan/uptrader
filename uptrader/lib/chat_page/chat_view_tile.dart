import 'package:flutter/material.dart';
import 'Post.dart';
import 'package:http/http.dart' as http;
import '../login/authentication.dart';
import '../essentials.dart';

// ignore: must_be_immutable
class ChatViewTile extends StatefulWidget {
  ChatViewTile({required this.post});
  Post post;

  @override
  _ChatViewTileState createState() => _ChatViewTileState();
}

class _ChatViewTileState extends State<ChatViewTile> {
  Future<void> likeButtonClicked() async {
    Uri uri =
        Uri.parse("$hostUrl/social/post/${widget.post.id}/add_remove_like");

    await Authentication.instance.getIdToken().then((token) async {
      http.Response response = await http.get(uri, headers: {"token": token});

      Post post = postFromJson(utf8decode(response.body));

      setState(() {
        widget.post = post;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            IconButton(
                onPressed: likeButtonClicked,
                icon: Icon(Icons.thumb_up),
                color: Colors.grey),
            Text("${widget.post.numberOfLikes} likes"),
            Spacer(),
            Text(widget.post.text)
          ],
        ));
  }
}
