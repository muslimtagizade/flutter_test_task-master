import 'package:flutter/material.dart';

class Buttonmy extends StatefulWidget {
  @override
  _ButtonmyState createState() => _ButtonmyState();
}

class _ButtonmyState extends State<Buttonmy> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      padding: EdgeInsets.all(4),
      child: FloatingActionButton.extended(
        backgroundColor: Colors.blueGrey,
        onPressed: () {
          null;
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        label: Text(
          'Press ME',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
