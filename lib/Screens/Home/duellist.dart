import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class DuelList extends StatelessWidget {
  const DuelList({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Card(
                    child: InkWell(
                      child: Container(
                        height: 75,
                        width: 175,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                        ),
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text("قصائد فى مديح نبوى",
                                        style: TextStyle(
                                            color: Colors.teal,
                                            fontFamily: "Amiri Regular")),
                                    SvgPicture.asset(
                                      "assets/ico/ic_ksaed.svg",
                                      height: 25,
                                      width: 25,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 22),
                                  child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "٠ قصيده",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontFamily: "Amiri Regular"),
                                      )),
                                ),
                              ],
                            )),
                      ),
                      onTap: () {

                      },
                    ),
                  ),
                  Card(
                    child: InkWell(
                      child: Container(
                        height: 75,
                        width: 175,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                        ),
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text("إجلال الله وتعظيم حبيبه ﷺ",
                                        style: TextStyle(
                                            color: Colors.teal,
                                            fontFamily: "Amiri Regular")),
                                    SvgPicture.asset(
                                      "assets/ico/ic_ksaed.svg",
                                      height: 25,
                                      width: 25,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 22),
                                  child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "٠ قصيده",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontFamily: "Amiri Regular"),
                                      )),
                                ),
                              ],
                            )),
                      ),
                      onTap: () {
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Card(
                    child: InkWell(
                      child: Container(
                        height: 75,
                        width: 175,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                        ),
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text("مدح الشيخ أحمد",
                                        style: TextStyle(
                                            color: Colors.teal,
                                            fontFamily: "Amiri Regular")),
                                    SvgPicture.asset(
                                      "assets/ico/ic_ksaed.svg",
                                      height: 25,
                                      width: 25,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 22),
                                  child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "٠ قصيده",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontFamily: "Amiri Regular"),
                                      )),
                                ),
                              ],
                            )),
                      ),
                      onTap: () {

                      },
                    ),
                  ),
                  Card(
                    child: InkWell(
                      child: Container(
                        height: 75,
                        width: 175,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                        ),                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text("مدح لبعض العلماء والسادة",
                                        style: TextStyle(
                                            color: Colors.teal,
                                            fontFamily: "Amiri Regular")),
                                    SvgPicture.asset(
                                      "assets/ico/ic_ksaed.svg",
                                      height: 25,
                                      width: 25,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 22),
                                  child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "٠ قصيده",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontFamily: "Amiri Regular"),
                                      )),
                                ),
                              ],
                            )),
                      ),
                      onTap: () {
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
