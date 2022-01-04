import 'package:flutter/material.dart';
import 'package:postapp/commentsScreen.dart';
import 'package:postapp/posterScreen.dart';

class DetialPost extends StatefulWidget {
  DetialPost({Key? key}) : super(key: key);
  static const routeName = '/DetailPost';
  @override
  _DetialPostState createState() => _DetialPostState();
}

class _DetialPostState extends State<DetialPost> {
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final id = routeArgs['index'];
    final userId = routeArgs['userId'];
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("post Details"),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(
                  Icons.person,
                ),
                text: 'Poster',
              ),
              Tab(
                icon: Icon(
                  Icons.comment,
                ),
                text: 'CommentS',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            PosterScreen(userId),
            CommentsScreen(id),
          ],
        ),
      ),
    );
  }
}
