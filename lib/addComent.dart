// ignore: file_names
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:postapp/comment.dart';

late int post;
Future<comment> createAlbum(
    String body, String name, String email, int postId) async {
  postId = post;
  final response = await http.post(
    Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'name': name,
      //   title: new_title,
      'body': body,
      //'userId': userId
      'email': email,
      'postId': postId,
    }),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return comment.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create post');
  }
}

class AddComment extends StatefulWidget {
  // AddComment({Key? key}) : super(key: key);
  AddComment(int c) {
    post = c;
  }

  @override
  _AddCommentState createState() => _AddCommentState();
}

class _AddCommentState extends State<AddComment> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controlleriemail = TextEditingController();
  final TextEditingController _controllerbody = TextEditingController();

  Future<comment>? _futureAlbum;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Create Data Example',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Create Data Example'),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: (_futureAlbum == null) ? buildColumn() : buildFutureBuilder(),
        ),
      ),
    );
  }

  Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          controller: _controller,
          decoration: const InputDecoration(hintText: 'Enter Name'),
        ),
        TextField(
          controller: _controllerbody,
          decoration: const InputDecoration(hintText: 'Enter Body'),
        ),
        TextField(
          controller: _controlleriemail,
          decoration: const InputDecoration(hintText: 'Enter Email'),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                _futureAlbum = createAlbum(_controllerbody.text,
                    _controller.text, _controlleriemail.text, post);
              });
            },
            child: const Text('Create Data'),
          ),
        ),
      ],
    );
  }

  FutureBuilder<comment> buildFutureBuilder() {
    return FutureBuilder<comment>(
      future: _futureAlbum,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          comment? album = snapshot.data;
          final name = album!.name;
          return Column(
            children: [
              Text('User ID' + "  " + album.id.toString()),
              Text('Title' + '  ' + name),
              Text('body' + '  ' + album.body),
            ],
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
