// ignore: file_names
// ignore: file_names
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:postapp/detialpost.dart';
import './post.dart';

bool isExpanded = false;
Future<List<post>>? postList;
Future<List<post>> fetchPosts() async {
  final response = await http.get(
    Uri.parse('https://jsonplaceholder.typicode.com/posts'),
  );

  if (response.statusCode == 200) {
    Iterable postMap = jsonDecode(response.body);
    return List<post>.from(postMap.map((e) => post.fromJson(e)));
    //List<post>.from(postMap.map((e) => post.fromJson(e));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class PostsScreen extends StatefulWidget {
  PostsScreen({Key? key}) : super(key: key);

  @override
  _PostsScreenState createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  edit(BuildContext ctx, int index, int userId) {
    Navigator.of(ctx).pushNamed(DetialPost.routeName, arguments: {
      'index': index,
      'userId': userId,
    });
  }

//@override
  // _ExpandableTextState createState() => new _ExpandableTextState();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    postList = fetchPosts() as Future<List<post>>?;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
      ),
      body: Container(
        child: Center(
          child: FutureBuilder<List<post>>(
            future: postList,
            //  initialData: InitialData,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  var postss = snapshot.data;
                  return ListView.builder(
                    itemCount: postss!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            child: InkWell(
                              onTap: () => edit(context, postss[index].id,
                                  postss[index].userId),
                              child: Container(
                                  // color: Colors.blueAccent,

                                  height: 60,
                                  width: 300,
                                  decoration: BoxDecoration(
                                    color: Colors.blueAccent,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    border: Border.all(
                                      width: 3,
                                      color: Colors.amber,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                  child: Text(
                                    postss[index].body.toString(),
                                    style: TextStyle(fontSize: 15),
                                  )),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
              }

              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
