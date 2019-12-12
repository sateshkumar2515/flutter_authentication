import 'package:flutter/material.dart';
class SecondActivity extends StatefulWidget {
  @override
  _SecondActivityState createState() => _SecondActivityState();
}

class _SecondActivityState extends State<SecondActivity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(child: Text("Welcome to the second screen",style: TextStyle(fontSize: 20.0,color: Colors.black),)),
          ),
        ],
      ),

    );
  }
}
