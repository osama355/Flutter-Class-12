import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Api extends StatefulWidget {
  const Api({Key? key}) : super(key: key);

  @override
  _ApiState createState() => _ApiState();
}

class _ApiState extends State<Api> {
  getuser() async {
    var users = [];
    var response =
        await http.get(Uri.https('jsonplaceholder.typicode.com', 'users'));
    var jsonData = jsonDecode(response.body);
    // print(jsonData);

    for (var i in jsonData) {
      UserModel user = UserModel(i['name'], i['username'], i['email']);
      users.add(user);
    }
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getuser(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Container(
              child: Text("Nothing in the APi"),
            );
          } else {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, i) {
                  return ListTile(
                    title: Text(snapshot.data[i].name),
                  );
                });
          }
        },
      ),
    );
  }
}

class UserModel {
  var name;
  var username;
  var email;
  UserModel(this.name, this.username, this.email);
}
