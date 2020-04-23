import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

const baseUrl = "https:jsonplaceholder.typicode.com/users";

class API {
  static Future getUsers() {
    var url = baseUrl + "/users";
    return http.get(url);
  }
}
class User {
  int id;
  String name;
  String username;
  String email;
  String phoneNumber;

  User(int id, String name, String email, String phoneNumber) {
    this.id = id;
    this.name = name;
    this.username = username;
    this.email = email;
    this.phoneNumber = phoneNumber;
  }
  User.fromJson(Map json)
  : id = json['id'],
  name = json['name'],
  username = json['username'],
  email = json['email'],
  phoneNumber = json['phoneNumber'];

  Map toJson() {
    return {'id': id, 'name': name, 'username': username, 'email': email, 'phoneNumber': phoneNumber};
  }
}
void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  build(context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My http Task',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TheListScreen(),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return null;
  }
}

class TheListScreen extends StatefulWidget {
  @override
  createState() => _TheListScreenState();
}

class _TheListScreenState extends State {
  var users = new List<User> ();
  
  _getUsers(){
    API.getUsers().then((response){setState(() {
      Iterable list = json.decode(response.body);
    });
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUsers();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  
  @override
  build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User List"),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return ListTile(title: Text(users[index].name));
        },
      ),
    );
  }
}