import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController todo_title = TextEditingController();
  TextEditingController todo_detail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add DATA'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: todo_title,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Title',
              ),
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              minLines: 2,
              maxLines: 4,
              controller: todo_detail,
              decoration: InputDecoration(
                labelText: 'Detail',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              margin: EdgeInsets.all(15),
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  postTodo();
                  setState(() {
                    todo_title.clear();
                    todo_detail.clear();
                  });
                },
                child: Text("Submit"),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.blue[500]),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.fromLTRB(30, 0, 30, 0)),
                    textStyle:
                        MaterialStateProperty.all(TextStyle(fontSize: 30))),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future postTodo() async {
    // var url = Uri.https('6e5a-115-84-92-192.ngrok.io', '/api/post-todolist');
    var url = Uri.http('192.168.0.199:8000', '/api/post-todolist');
    Map<String, String> header = {"Content-type": "application/json"};
    String jsondata =
        '{"title":"${todo_title.text}","detail":"${todo_detail.text}"}';
    var response = await http.post(url, headers: header, body: jsondata);
  }
}
