import 'dart:async';

import 'package:dwaween/features/Base/view.dart';
import 'package:dwaween/features/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Future(() =>
        Provider.of<BaseProvider>(context, listen: false).readDwaweenData());

    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BaseScreen(),
        ),
      );
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: Container(
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: mediaQuery.size.height * .13,
            ),
            Container(
              height: mediaQuery.size.width * .8,
              width: mediaQuery.size.width * .8,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/paintings/splash.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(height: mediaQuery.size.height * .03),
            Text(
              "proceed".tr(),
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 8, 238, 246),
                  fontFamily: "Amiri Regular"),
            ),
            SizedBox(height: mediaQuery.size.height * .01),
            Text(
              "Al_Faydah_Tijaniya_Heritage_Network".tr(),
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: "Amiri Regular"),
            ),
            SizedBox(height: mediaQuery.size.height * .01),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                height: mediaQuery.size.height * .3,
                width: mediaQuery.size.height * .3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/img/books.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
