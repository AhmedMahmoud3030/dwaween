import 'dart:convert';

import 'package:dwaween/Screens/Knanish/KasayedDetails/KasydaDetails.dart';
import 'package:dwaween/core/nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Knanish extends StatefulWidget {
  const Knanish({super.key});

  @override
  State<Knanish> createState() => _KnanishState();
}

class _KnanishState extends State<Knanish> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readData();
  }
  final TextEditingController _searchController = TextEditingController();
  String SearchValue = "";
  var filtared;
  var items;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: 1000,
                color: Color.fromARGB(255, 253, 253, 234),
              ),
              SvgPicture.asset(
                "assets/img/BG.svg",
                alignment: Alignment.topCenter,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
              SafeArea(
                child: Stack(
                  children: [
                    SvgPicture.asset(
                      "assets/img/banner2.svg",
                      alignment: Alignment.topCenter,
                      width: MediaQuery.of(context).size.width * 4,
                      height: MediaQuery.of(context).size.height / 2,
                    ),
                    Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Text("الكناش",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Cairo",
                                      color: Colors.white)),
                              Text("",
                                  style: TextStyle(
                                      fontFamily: "Cairo",
                                      fontSize: 20, color: Colors.white)),
                            ],
                          ),
                        ),
                        Container(
                          height: 25,
                        ),
                        Container(
                          height: 60,
                          color: Color.fromARGB(255, 253, 253, 234),
                          // Add padding around the search bar
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          // Use a Material design search bar
                          child: TextField(
                            onChanged: (value) {
                              setState(() {
                                SearchValue = value;
                              });
                            },
                            controller: _searchController,
                            textAlign: TextAlign.right,
                            decoration: InputDecoration(
                              hintText: 'البحث فى القصائد',
                              hintStyle: TextStyle(
                                fontFamily: 'Cairo'
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 3, color: Colors.white),
                                borderRadius: BorderRadius.circular(20.0),
                              ),

                              // Add a clear button to the search bar
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.search),
                                onPressed: () {},
                              ),
                              // Add a search icon or button to the search bar
                              prefixIcon: IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  _searchController.clear();
                                  setState(() {});
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),

              Padding(
                padding:EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    SizedBox(
                      height: 250,
                    ),
                    Container(
                      height: height/1.55,
                      width: width,
                      child: FutureBuilder(
                        future: readData(),
                        builder: (contect, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            filtared = snapshot.data;
                            items = filtared
                                .where((element) => element['Kname'].toString().toLowerCase().contains(SearchValue.toLowerCase())).toList();

                            return GridView.builder(
                                shrinkWrap: true,
                                gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: height / 100,
                                  crossAxisSpacing: width / 50,
                                  childAspectRatio: 1.9,
                                ),
                                itemCount: items.length,
                                itemBuilder: (BuildContext context, index) {
                                  return Card(
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
                                                    SvgPicture.asset(
                                                      "assets/ico/ic_ksaed.svg",
                                                      height: 40,
                                                      width: 40,
                                                    ),
                                                    Container(
                                                      width: width/3.2,
                                                      alignment: Alignment.topRight,
                                                      child: SearchValue.isNotEmpty?
                                                          ColoredText(
                                                            text: items[index]['Kname'],
                                                            value: SearchValue,
                                                            context: context,
                                                          )
                                                          : Text(items[index]['Kname'],
                                                        textDirection: TextDirection.rtl,
                                                        style: TextStyle(
                                                          overflow: TextOverflow.ellipsis,

                                                          color: Colors.black87,fontSize: 12,fontFamily: "Cairo",
                                                        ),
                                                        overflow: TextOverflow.ellipsis,

                                                      ),
                                                    ),

                                                  ],
                                                ),
                                                // SizedBox(
                                                //   height: 2,
                                                // ),
                                                // Align(
                                                //     alignment: Alignment.centerRight,
                                                //     child: Padding(
                                                //       padding: EdgeInsets.only(right: 25),
                                                //       child: Text(
                                                //         "٠ قصيده",
                                                //         style: TextStyle(color: Colors.grey,fontFamily: "Cairo"),
                                                //       ),
                                                //     )),
                                              ],
                                            )),
                                      ),
                                      onTap: () {
                                        navigateTo(
                                            context,
                                            KasydaDetails(
                                              kasyeda: items[index]['Kaseyda'],
                                              kasyedaT: items[index]['KaseydaT'],
                                              kasyedaTRepeat: items[index]['KaseydaT'],

                                              KName: items[index]['Kname'],
                                              KNameT: items[index]['KnameT'],
                                              DName: "",
                                            ));

                                      },
                                    ),
                                  );
                                });
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 300,
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
  Future<List> readData() async {
    final String res = await rootBundle.loadString('assets/json/knansh.json');
    final loadedData = await json.decode(res);
    List _dawaweenList = loadedData['Knanesh'];
    print("object ${_dawaweenList.length}");
    return _dawaweenList;
  }

}


class ColoredText extends StatelessWidget {
  String text;
  String value;
  BuildContext context;

  ColoredText({required this.text,required this.value,required this.context});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: _buildTextSpans(),
      ),
    );
  }

  List<TextSpan> _buildTextSpans() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final List<TextSpan> spans = [];

    // Split the text by space to apply styling to individual words
    final List<String> words = text.split(' ');

    for (int i = 0; i < words.length; i++) {
      final String word = words[i];

      if (word.toLowerCase().contains(value)) {
        spans.add(
          TextSpan(
            text: '$word ',
            style: TextStyle(
                color: Colors.teal,
                fontSize: 12,
                fontFamily: "Cairo"
            ),
          ),
        );
      } else {
        spans.add(
          TextSpan(
            text: '$word ',
            style:  TextStyle(
                color: Colors.black87,
                fontSize: 12,
                fontFamily: "Cairo"
            ),
          ),
        );
      }
    }

    return spans;
  }
}
