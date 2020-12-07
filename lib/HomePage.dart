import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
class HomePage extends StatelessWidget{
  final String apiUrl = "https://randomuser.me/api/?results=10";

  Future<List<dynamic>> fetchUsers() async {

    var result = await http.get(apiUrl);
    return json.decode(result.body)['results'];

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.purple,
        appBar: AppBar(title:Text("Awesome APP")),

  body: Container(child: FutureBuilder<List<dynamic>>(
    future: fetchUsers(),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
    if(snapshot.hasData){
    print(_age(snapshot.data[0]));
    return ListView.builder(
    padding: EdgeInsets.all(8),
      itemCount: snapshot.data.length,
    itemBuilder: (BuildContext context, int index){
    return
    Card(
    child: Column(
    children: <Widget>[
    ListTile(
      leading: CircleAvatar(
    radius: 30,
    backgroundImage: NetworkImage(snapshot.data[index]['picture']['large'])),
    title: Text(_name(snapshot.data[index])),
    subtitle: Text(_location(snapshot.data[index])),
       trailing: Text(_age(snapshot.data[index])),
    )
    ],
    ),
    );
    });
    }else {
    return Center(child: CircularProgressIndicator());
    }
    },


    ),),);




}

String _age(Map<dynamic,dynamic> user) {
return "Age:" + user['dob']['age'].toString();
}
}

String _location(dynamic user) {
  return user['location']['country'];
}

String _name(dynamic user) {
  return user['name']['title']+" "+user['name']['first']+" "+user['name']['last'];
}
