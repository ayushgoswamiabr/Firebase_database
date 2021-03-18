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
  List lists;
  final referncedatabase = FirebaseDatabase.instance;
  final moviename = 'Movie Title';
  final moviecontroller = TextEditingController();
  String movieName;
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: moviecontroller,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Column(
                    children: [
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
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      FlatButton(
                        onPressed: () {
                          ref.once().then((DataSnapshot snapshot) {
                            Map<dynamic, dynamic> values = snapshot.value;
                            print(values);
                          });
                        },
                        child: Text("Read data"),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
