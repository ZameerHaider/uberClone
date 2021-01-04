import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MainPage"),
        centerTitle: true,
      ),
      body: Center(
        child: MaterialButton(
          child: Text("Db Test"),
          height: 50,
          minWidth: 300,
          color: Colors.green,
          onPressed: () {
            DatabaseReference dbref =
                FirebaseDatabase.instance.reference().child('Test');
            dbref.set('IsConnected');
          },
        ),
      ),
    );
  }
}
