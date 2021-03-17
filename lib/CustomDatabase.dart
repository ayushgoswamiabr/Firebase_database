import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class CustomDatabase extends StatefulWidget {
  CustomDatabase({this.app});
  final Firebase app;
  @override
  _CustomDatabaseState createState() => _CustomDatabaseState();
}

class _CustomDatabaseState extends State<CustomDatabase> {
  final referncedatabase = FirebaseDatabase.instance;
  final moviename = 'Movie Title';
  final moviecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final ref = referncedatabase.reference();
    return Scaffold(
      appBar: AppBar(title: Text("Realtime Database")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  Text(
                    moviename,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: moviecontroller,
                    textAlign: TextAlign.center,
                  ),
                  FlatButton(
                    onPressed: () {
                      ref
                          .child('Movies')
                          .push()
                          .child(moviename)
                          .set(moviecontroller.text)
                          .asStream();
                      moviecontroller.clear();
                    },
                    child: Text("Save Movie"),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
