import 'package:flutter/material.dart';
import 'package:uptrader/user_page/Network/Groups.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'Post.dart';
import '../login/authentication.dart';
import 'package:http/http.dart' as http;
import 'chat_view_tile.dart';
import '../essentials.dart';

// ignore: must_be_immutable
class PreChatView extends StatelessWidget {
  Group group;

  PreChatView({required this.group});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Authentication.instance.getIdToken(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ChatView(
              group: this.group,
              token: snapshot.data.toString(),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

class ChatView extends StatefulWidget {
  ChatView({required this.group, required this.token});

  final Group group;
  final String token;

  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final controller = TextEditingController();

  final focusNode = FocusNode();
  late final WebSocketChannel channel;

  List<Post> list = [];

  @override
  void initState() {
    channel = WebSocketChannel.connect(
        Uri.parse('$hostUrlWebsocket/ws/chat/${widget.group.id}/'),
        protocols: {widget.token});
    focusNode.requestFocus();
    super.initState();
  }

  Widget listView() {
    return StreamBuilder(
        stream: channel.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data.toString());
            Post post = postFromJson(snapshot.data.toString());
            list.add(post);
          }

          if (list.isEmpty) {
            return Center(
                child: Text(
                    "Chat is empty, type a message to start a conversation!"));
          }

          return ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                return ChatViewTile(post: list[index]);
              });
        });
  }

  Future sendMessage(String txt) async {
    if (controller.text.isNotEmpty) {
      Post post = Post(group: "${widget.group.id}", text: txt);
      focusNode.requestFocus();

      Uri postUri = Uri.parse("$hostUrl/social/post/");
      final http.Response response = await http
          .post(postUri, body: post.toJson(), headers: {"token": widget.token});
      String decoded = utf8decode(response.body.toString());
      channel.sink.add(decoded);
      controller.clear();
    }
  }

  Widget retrieveList() {
    return FutureBuilder<http.Response>(
        future: http.get(
            Uri.parse("$hostUrl/social/group/${widget.group.id}/list_posts/"),
            headers: {"token": widget.token}),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Post> ls = listPostFromJson(utf8decode(snapshot.data!.body));
            list += ls;
            print(ls.length);

            return listView();
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.group.title)),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: retrieveList()),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  focusNode: focusNode,
                  controller: controller,
                  onSubmitted: sendMessage,
                ))
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }
}
