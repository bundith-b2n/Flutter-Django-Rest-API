import 'package:flutter/material.dart';
import 'package:todolist/pages/todolist.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Computer Knowlege",
      // home: HomePage(),
      // home: AddPage(),
      home: Todolist(),
    );
  }
}
