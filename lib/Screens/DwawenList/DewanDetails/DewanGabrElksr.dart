import 'dart:convert';

import 'package:dwaween/core/nav.dart';
import 'package:dwaween/features/KasydaDetails/kasyda_details.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';


class DewanGabrElksr extends StatefulWidget {
  const DewanGabrElksr({super.key});

  @override
  State<DewanGabrElksr> createState() => _DewanGabrElksrState();
}

class _DewanGabrElksrState extends State<DewanGabrElksr> {
  TextEditingController _searchController = TextEditingController();

  String SearchValue = "";
  var filtared;
  var items;

//

  Future<List> readData2(String url) async {
    final String res = await rootBundle.loadString(url);
    final loadedData = await json.decode(res);
    List _dawaweenList = loadedData['Dawawen'];
    return _dawaweenList;
  }

  String selector = "";
  bool _first = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SvgPicture.asset(
              "assets/img/BG.svg",
              alignment: Alignment.topCenter,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            SvgPicture.asset(
              "assets/img/banner2.svg",
              alignment: Alignment.topCenter,
              width: MediaQuery.of(context).size.width * 4,
              height: MediaQuery.of(context).size.height / 2,
            ),
            Column(
              children: [
                const SizedBox(
                  height: 60,
                ),
                const SizedBox(
                  height: 58,
                  child: Text("ديوان جبر الكاسر",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: "Cairo",
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )),
                ),
                Container(
                  height: 20,
                ),
                Container(
                  height: 60,
                  color: Color.fromARGB(255, 253, 253, 234),
                  // Add padding around the search bar
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  // Use a Material design search bar
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() {
                        SearchValue = value;
                        selector = "";
                      });
                    },
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      hintText: 'البحث فى القصائد',
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3, color: Colors.white),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      hintStyle: TextStyle(
                        fontFamily: 'Cairo',
                      ),

                      // Add a clear button to the search bar
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {},
                      ),
                      // Add a search icon or button to the search bar
                      prefixIcon: _searchController.text.length > 0
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                setState(() {
                                  SearchValue = "";
                                });
                              },
                            )
                          : null,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 230,
                ),
                Card(
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
                          child: Container(
                            child: Text(
                              " نبذة عن ديوان جبر الكسر",
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Cairo"),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: SingleChildScrollView(
                              child: ExpandableText(
                                "يحتوي هذا الديوان على مجموعة من المدائح كما يحتوي على قصيدة طويلة في السيرة النبوية عنوانها: نور البصر في مدح سيد البشر",
                                trimLines: 2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Visibility(
                        visible: selector != "",
                        child: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            setState(() {
                              selector = "";
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: selector != "" ? 230 : 260,
                        child: Divider(
                          color: Colors.teal,
                          thickness: 1.5,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("القوافى ",
                          style: TextStyle(
                              color: Colors.teal,
                              fontFamily: "Cairo",
                              fontWeight: FontWeight.bold)),
                      SvgPicture.asset(
                        "assets/images/icons/ic_ksaed.svg",
                        height: 25,
                        width: 25,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                // القوافى
                Container(
                  width: 350,
                  height: 180,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            child: Container(
                              height: 30,
                              width: 55,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                color: Color.fromARGB(255, 213, 211, 211),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text("ء",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.teal,
                                        fontFamily: "Cairo")),
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                selector = "ء";
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              height: 30,
                              width: 55,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                color: const Color.fromARGB(255, 213, 211, 211),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text("ب",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.teal,
                                        fontFamily: "Cairo")),
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                selector = "ب";
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              height: 30,
                              width: 55,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                color: const Color.fromARGB(255, 213, 211, 211),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text("ت",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.teal,
                                        fontFamily: "Cairo")),
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                selector = "ت";
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              height: 30,
                              width: 55,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                color: const Color.fromARGB(255, 213, 211, 211),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text("ث",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.teal,
                                        fontFamily: "Cairo")),
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                selector = "ث";
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              height: 30,
                              width: 55,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                color: const Color.fromARGB(255, 213, 211, 211),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text("ج",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.teal,
                                        fontFamily: "Cairo")),
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                selector = "ج";
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              height: 30,
                              width: 55,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                color: const Color.fromARGB(255, 213, 211, 211),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text("ح",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.teal,
                                        fontFamily: "Cairo")),
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                selector = "ح";
                              });
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            child: Container(
                              height: 30,
                              width: 55,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                color: const Color.fromARGB(255, 213, 211, 211),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text("خ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.teal,
                                        fontFamily: "Cairo")),
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                selector = "خ";
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              height: 30,
                              width: 55,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                color: const Color.fromARGB(255, 213, 211, 211),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text("د",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.teal,
                                        fontFamily: "Cairo")),
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                selector = "د";
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              height: 30,
                              width: 55,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                color: const Color.fromARGB(255, 213, 211, 211),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text("ذ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.teal,
                                        fontFamily: "Cairo")),
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                selector = "ذ";
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              height: 30,
                              width: 55,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                color: const Color.fromARGB(255, 213, 211, 211),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text("ر",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.teal,
                                        fontFamily: "Cairo")),
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                selector = "ر";
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              height: 30,
                              width: 55,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                color: const Color.fromARGB(255, 213, 211, 211),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text("ز",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.teal,
                                        fontFamily: "Cairo")),
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                selector = "ز";
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              height: 30,
                              width: 55,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                color: const Color.fromARGB(255, 213, 211, 211),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text("س",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.teal,
                                        fontFamily: "Cairo")),
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                selector = "س";
                              });
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            child: Container(
                              height: 30,
                              width: 55,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                color: const Color.fromARGB(255, 213, 211, 211),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text("ش",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.teal,
                                        fontFamily: "Cairo")),
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                selector = "ش";
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              height: 30,
                              width: 55,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                color: const Color.fromARGB(255, 213, 211, 211),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text("ص",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.teal,
                                        fontFamily: "Cairo")),
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                selector = "ص";
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              height: 30,
                              width: 55,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                color: const Color.fromARGB(255, 213, 211, 211),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text("ض",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.teal,
                                        fontFamily: "Cairo")),
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                selector = "ض";
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              height: 30,
                              width: 55,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                color: const Color.fromARGB(255, 213, 211, 211),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text("ط",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.teal,
                                        fontFamily: "Cairo")),
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                selector = "ط";
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              height: 30,
                              width: 55,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                color: const Color.fromARGB(255, 213, 211, 211),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text("ظ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.teal,
                                        fontFamily: "Cairo")),
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                selector = "ظ";
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              height: 30,
                              width: 55,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                color: const Color.fromARGB(255, 213, 211, 211),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text("ع",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.teal,
                                        fontFamily: "Cairo")),
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                selector = "ع";
                              });
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            child: Container(
                              height: 30,
                              width: 55,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                color: const Color.fromARGB(255, 213, 211, 211),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text("غ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.teal,
                                        fontFamily: "Cairo")),
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                selector = "غ";
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              height: 30,
                              width: 55,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                color: const Color.fromARGB(255, 213, 211, 211),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text("ف",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.teal,
                                        fontFamily: "Cairo")),
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                selector = "ف";
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              height: 30,
                              width: 55,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                color: const Color.fromARGB(255, 213, 211, 211),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text("ق",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.teal,
                                        fontFamily: "Cairo")),
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                setState(() {
                                  selector = "ق";
                                });
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              height: 30,
                              width: 55,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                color: const Color.fromARGB(255, 213, 211, 211),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text("ك",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.teal,
                                        fontFamily: "Cairo")),
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                selector = "ك";
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              height: 30,
                              width: 55,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                color: const Color.fromARGB(255, 213, 211, 211),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text("ل",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.teal,
                                        fontFamily: "Cairo")),
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                selector = "ل";
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              height: 30,
                              width: 55,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                color: const Color.fromARGB(255, 213, 211, 211),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text("ن",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.teal,
                                        fontFamily: "Cairo")),
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                selector = "ن";
                              });
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            child: Container(
                              height: 30,
                              width: 55,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                color: const Color.fromARGB(255, 213, 211, 211),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text("ي",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.teal,
                                        fontFamily: "Cairo")),
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                selector = "ي";
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                //Alphacard(),
                SizedBox(
                  height: 5,
                ),
                // القصائد
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 260,
                        child: Divider(
                          color: Colors.teal,
                          thickness: 1.5,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("القصائد ",
                          style: TextStyle(
                              color: Colors.teal,
                              fontFamily: "Cairo",
                              fontWeight: FontWeight.bold)),
                      SvgPicture.asset(
                        "assets/images/icons/ic_ksaed.svg",
                        height: 25,
                        width: 25,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                ),

                Container(
                  width: 375,
                  child: FutureBuilder(
                    future: readData2("assets/json/dewanGabrElkaser.json"),
                    builder: (contect, snapshot) {
                      if (snapshot.hasData) {
                        filtared = snapshot.data;
                        print("${filtared.length} S");
                        if (selector == "" && SearchValue != "") {
                          items = filtared
                              .where((element) => element['Kname']
                                  .toString()
                                  .toLowerCase()
                                  .contains(SearchValue.toLowerCase()))
                              .toList();
                        } else if (selector != "" && SearchValue == "") {
                          items = filtared
                              .where((element) => element['letter']
                                  .toString()
                                  .toLowerCase()
                                  .contains(selector.toLowerCase()))
                              .toList();
                        } else {
                          items = filtared;
                          // items = filtared
                          //     .where((element) => element['Kname']
                          //         .toString()
                          //         .toLowerCase()
                          //         .contains(SearchValue.toLowerCase()))
                          //     .toList();
                        }
                        return ListView.builder(
                            itemCount: items.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.only(top: 10),
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, index) {
                              return InkWell(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Container(
                                        color: Colors.white,
                                        child: ListTile(
                                          trailing: SvgPicture.asset(
                                            "assets/images/icons/ic_ksaed.svg",
                                            height: 25,
                                            width: 25,
                                          ),
                                          title: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              SizedBox(
                                                width: 280,
                                                child: Text(
                                                  items[index]['Kname'],
                                                  textAlign: TextAlign.right,
                                                  softWrap: true,
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                      color: Colors.teal,
                                                      fontFamily: "Cairo"),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                        visible: (items.length - 1) == index,
                                        child: SizedBox(
                                          height: 10,
                                        ))
                                  ],
                                ),
                                onTap: () {
                                  navigateTo(
                                      context,
                                      KasydaDetails(
                                        kasyeda: items[index]['Kaseyda'],
                                        KName: items[index]['Kname'],
                                        DName: "",
                                      ));
                                },
                              );
                            });
                      } else {
                        return Container(
                          height: 45,
                          width: 45,
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
              ],
            )
            //
          ],
        ),
      ),
    );
  }
}

class ExpandableText extends StatefulWidget {
  const ExpandableText(
    this.text, {
    Key? key,
    this.trimLines = 2,
  }) : super(key: key);

  final String text;
  final int trimLines;

  @override
  ExpandableTextState createState() => ExpandableTextState();
}

class ExpandableTextState extends State<ExpandableText> {
  bool _readMore = true;
  void _onTapLink() {
    setState(() => _readMore = !_readMore);
  }

  @override
  Widget build(BuildContext context) {
    final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);
    final colorClickableText = Colors.blue;
    final widgetColor = Colors.black;
    TextSpan link = TextSpan(
        text: _readMore ? "... اقرأ المزيد" : "  اقرأ أقل",
        style: TextStyle(color: colorClickableText, fontFamily: "Cairo"),
        recognizer: TapGestureRecognizer()..onTap = _onTapLink);
    Widget result = LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        assert(constraints.hasBoundedWidth);
        final double maxWidth = constraints.maxWidth;
        // Create a TextSpan with data
        final text = TextSpan(
          text: widget.text,
        );
        // Layout and measure link
        TextPainter textPainter = TextPainter(
          text: link,
          textDirection: TextDirection
              .rtl, //better to pass this from master widget if ltr and rtl both supported
          maxLines: widget.trimLines,
          ellipsis: '...',
        );
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final linkSize = textPainter.size;
        // Layout and measure text
        textPainter.text = text;
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final textSize = textPainter.size;
        // Get the endIndex of data
        int endIndex;
        final pos = textPainter.getPositionForOffset(Offset(
          textSize.width - linkSize.width,
          textSize.height,
        ));
        endIndex = textPainter.getOffsetBefore(pos.offset)!;
        var textSpan;
        if (textPainter.didExceedMaxLines) {
          textSpan = TextSpan(
            text: _readMore ? widget.text.substring(0, endIndex) : widget.text,
            style: TextStyle(color: widgetColor, fontFamily: "Cairo"),
            children: <TextSpan>[link],
          );
        } else {
          textSpan = TextSpan(
            text: widget.text,
          );
        }
        return RichText(
          softWrap: true,
          overflow: TextOverflow.clip,
          text: textSpan,
          textAlign: TextAlign.right,
        );
      },
    );
    return result;
  }
}
