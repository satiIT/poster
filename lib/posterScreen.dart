import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:postapp/poster.dart';
import 'package:http/http.dart' as http;

late int id;
Future<Poster> fetchPoster() async {
  final response = await http.get(
    Uri.parse('https://jsonplaceholder.typicode.com/users/${id}'),
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Poster.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class PosterScreen extends StatefulWidget {
//  PosterScreen({Key? key}) : super(key: key);
  PosterScreen(int c) {
    id = c;
  }
  @override
  _PosterScreenState createState() => _PosterScreenState();
}

class _PosterScreenState extends State<PosterScreen> {
  Future<Poster>? s = fetchPoster();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        child: FutureBuilder(
          future: s,
          // initialData: InitialData,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Text(snapshot.data.name),
                    Text(snapshot.data.email),
                    Text(snapshot.data.phone),
                  ],
                );
              }
            }
            if (snapshot.hasError) {
              Text(snapshot.hasError.toString());
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    ));
  }
}
