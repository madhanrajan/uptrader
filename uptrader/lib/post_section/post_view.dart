import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:uptrader/Theme.dart';
import 'package:uptrader/chat_page/Post.dart';
import 'package:uptrader/login/authentication.dart';
import 'package:uptrader/post_section/post_view_tile.dart';
import 'PaginatedPost.dart';
import 'package:http/http.dart' as http;
import '../essentials.dart';

class PostView extends StatefulWidget {
  BaseColor baseColor;
  List<String> str = [];
  String uri;
  String token;
  PostView({required this.uri, required this.token, required this.baseColor});

  @override
  _PostViewState createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  PagingController<int, Result> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });

    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    http.Response response =
        await http.get(Uri.parse(widget.uri), headers: {"token": widget.token});
    PaginatedPost post = paginatedPostFromJson(utf8decode(response.body));

    print("new item needed");

    try {
      if (post.next != null) {
        widget.uri = post.next!;
        _pagingController.appendPage(post.results, pageKey + 1);
      } else {
        _pagingController.appendLastPage(post.results);
      }
    } catch (error) {
      _pagingController.error = error;
      print(error);
    }
  }

  PagedChildBuilderDelegate<Result> delegate() {
    return PagedChildBuilderDelegate<Result>(
        itemBuilder: (context, item, index) {
      return PostViewTile(
        result: item,
        baseColor: widget.baseColor,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return PagedSliverList(
        pagingController: _pagingController, builderDelegate: delegate());
  }

  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
