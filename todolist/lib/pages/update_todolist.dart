import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

class UpdateTodolist extends StatefulWidget {
  final v1, v2, v3;
  const UpdateTodolist(this.v1, this.v2, this.v3);

  @override
  _UpdateTodolistState createState() => _UpdateTodolistState();
}

class _UpdateTodolistState extends State<UpdateTodolist> {
  var _v1, _v2, _v3;

  TextEditingController todo_title = TextEditingController();
  TextEditingController todo_detail = TextEditingController();
  @override
  void initState() {
    super.initState();
    _v1 = widget.v1;
    _v2 = widget.v2;
    _v3 = widget.v3;

    todo_title.text = _v2;
    todo_detail.text = _v3;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Data'),
        actions: [
          IconButton(
            onPressed: () {
              deletetodo();
              Navigator.pop(context, 'deleted');
            },
            icon: Icon(Icons.delete),
          ),
        ],
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
                  updatetodo();
                  final snackBar = SnackBar(
                    content: const Text(
                      "Updated",
                      textAlign: TextAlign.center,
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: Text("Edit"),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue[500]),
                  padding: MaterialStateProperty.all(
                    EdgeInsets.fromLTRB(30, 0, 30, 0),
                  ),
                  textStyle: MaterialStateProperty.all(
                    TextStyle(fontSize: 30),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future updatetodo() async {
    // var url = Uri.https('6e5a-115-84-92-192.ngrok.io', '/api/post-todolist');
    var url = Uri.http('192.168.0.199:8000', '/api/put-todolist/$_v1');
    Map<String, String> header = {"Content-type": "application/json"};
    String jsondata =
        '{"title":"${todo_title.text}","detail":"${todo_detail.text}"}';
    var response = await http.put(url, headers: header, body: jsondata);
    print("<<<<<<<<<<>>>>>>>>>>${response.body}");
  }

  Future deletetodo() async {
    var url = Uri.http('192.168.0.199:8000', '/api/delete-todolist/$_v1');
    Map<String, String> header = {"Content-type": "application/json"};
    var response = await http.delete(url, headers: header);
    print("<<<<<<<<<<>>>>>>>>>>${response.body}");
  }
}
