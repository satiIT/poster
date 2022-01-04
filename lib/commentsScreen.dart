import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:postapp/addComent.dart';
import 'package:postapp/comment.dart';

late int postd;

Future<List<comment>>? comments;
Future<List<comment>> fetchComments() async {
  final response = await http.get(
    Uri.parse('https://jsonplaceholder.typicode.com/comments'),
  );

  if (response.statusCode == 200) {
    Iterable postMap = jsonDecode(response.body);
    return List<comment>.from(postMap.map((e) => comment.fromJson(e)));
    //List<post>.from(postMap.map((e) => post.fromJson(e));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class CommentsScreen extends StatefulWidget {
  //CommentsScreen({Key? key}) : super(key: key);
  CommentsScreen(int postid) {
    postd = postid;
  }

  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  @override
  void initState() {
    // TODO: implement initState

    comments = fetchComments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Container(
            child: FutureBuilder<List<comment>>(
              future: comments,
              //  initialData: InitialData,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    List<comment> postss = snapshot.data;

                    postss.removeWhere((item) => item.postId != postd);

                    return ListView.builder(
                      itemCount: postss.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              child: InkWell(
                                child: Container(
                                    // color: Colors.blueAccent,

                                    //   height: 150,
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
                                    child: Column(
                                      children: [
                                        Text("Name : " + postss[index].name),
                                        Text('email : ' + postss[index].email),
                                        Text(
                                          'body : ' +
                                              postss[index].body.toString(),
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ],
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
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddComment(postd)));
            },
            //  tooltip: 'Increment',
            child: const Icon(Icons.add)));
  }
}
