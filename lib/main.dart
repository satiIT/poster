import 'package:flutter/material.dart';
import 'package:postapp/detialpost.dart';
import './Posts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        fontFamily: 'Raleway',
      ),
      initialRoute: '/',
      routes: {
        '/': (ctx) => PostsScreen(),
        DetialPost.routeName: (ctx) => DetialPost()
      },
    );
  }
}
