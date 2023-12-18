import 'package:dwaween/Screens/Home/Home.dart';
import 'package:dwaween/core/nav.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class splash extends StatefulWidget {
  const splash({super.key});

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      navigateReplacementTo(context, Home(value: 0));
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (context) => Home(value: 0)));
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        //color: Colors.red,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromARGB(255, 27, 164, 134),
              Color.fromARGB(255, 28, 126, 137),
            ],
          ),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              Container(
                height: 100,
              ),
              Container(
                height: 320.0,
                width: 320.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/img/splash.png'),
                    fit: BoxFit.fill,
                  ),
                  shape: BoxShape.circle,
                ),
              ),
              Container(
                height: 100,
                //width: 100,
                child: Column(
                  children: [
                    Text("إنتاج",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 8, 238, 246),
                            fontFamily: "Amiri Regular")),
                    Text(
                      " شبكة تراث الفيضة التجانية",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: "Amiri Regular"),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  height: 220.0,
                  width: 220.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/img/books.png'),
                      fit: BoxFit.fill,
                    ),
                    //shape: BoxShape.rectangle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
