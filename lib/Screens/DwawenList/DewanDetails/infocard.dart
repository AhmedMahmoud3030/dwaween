import 'package:flutter/material.dart';

class infocard extends StatefulWidget {
  const infocard({super.key});

  @override
  State<infocard> createState() => _infocardState();
}

class _infocardState extends State<infocard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
      padding: EdgeInsets.all(25),
      width: 360,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "Info",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "Data",
              style: TextStyle(fontSize: 17),
            ),
          )
        ],
      ),
    ));
  }
}
