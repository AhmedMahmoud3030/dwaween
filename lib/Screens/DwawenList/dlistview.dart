import 'package:dwaween/Screens/DwawenList/DewanDetails/DewanTeserWsol.dart';
import 'package:dwaween/core/nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../core/constants.dart';
import '../Knanish/KasayedDetails/KasydaDetails.dart';

class Dwaweenlist extends StatefulWidget {
  const Dwaweenlist({super.key});

  @override
  State<Dwaweenlist> createState() => _DwaweenlistState();
}

final TextEditingController _searchController = TextEditingController();
String SearchValue = "";
var filtared;
var items;
var itemsKaseda;

final scaffoldKey = GlobalKey<ScaffoldState>();

int _selectedIndex = 0;

Future getData() async {
  var url = 'https://www.turathtijania.com/index.php';
  //var url = 'http://10.0.2.2/test/index.php';
  http.Response response = await http.get(Uri.parse(url));
  var data = jsonDecode(response.body);
  return data;
}

Future<List> readData() async {
  final String res = await rootBundle.loadString('assets/json/dewanlist.json');
  final loadedData = await json.decode(res);
  List _dawaweenList = loadedData['Dawawen'];
  return _dawaweenList;
}

class _DwaweenlistState extends State<Dwaweenlist> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      key: scaffoldKey,
      body: SingleChildScrollView(
        child: Container(
          color: Color.fromARGB(255, 250, 250, 234),
          child: Stack(
            children: [
              Stack(
                children: [
                  SvgPicture.asset(
                    "assets/img/img_heade_home.svg",
                    alignment: Alignment.topCenter,
                    width: MediaQuery.of(context).size.width * 4,
                    height: MediaQuery.of(context).size.height / 2,
                  ),
                  Column(
                    children: [
                      Container(
                        height: 210,
                      ),
                      Container(
                        height: 60,
                        color: Color.fromARGB(255, 250, 250, 234),
                        // Add padding around the search bar
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        // Use a Material design search bar
                        child: TextFormField(
                          controller: _searchController,
                          onChanged: (value) {
                            setState(() {
                              SearchValue = value;
                            });
                          },
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                            hintText: 'البحث فى الدواوين',
                            filled: true, //<-- SEE HERE
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 3, color: Colors.white),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            hintStyle: TextStyle(fontFamily: 'Cairo',),

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
                  )
                ],
              ),

              Column(
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
                          items = filtared.where((element) => element['name'].toString().contains(SearchValue)).toList();
                          itemsKaseda = filtared.where((element) => element['Kaseyda'].toString().contains(SearchValue)).toList();

                          return SearchValue.isEmpty?
                          ListView.builder(
                              itemCount: items.length,
                              itemBuilder: (BuildContext context, index) {
                                return InkWell(
                                  child: Visibility(
                                    visible: items[index]['count']!='0' || (items[index]['count']=='0' && SearchValue.isNotEmpty ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: width / 40),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          color: Colors.white,
                                        ),
                                        child: ListTile(
                                          trailing: SvgPicture.asset(
                                            "assets/ico/ic_ksaed.svg",
                                            height: width / 12,
                                            width: width / 12,
                                          ),
                                          title: Align(
                                            alignment: Alignment.centerRight,
                                            child:SearchValue.isNotEmpty?
                                                ColoredText(
                                                  text: items[index]['name'],
                                                  value: SearchValue,
                                                  context: context,
                                                ) : Text(
                                              items[index]['name'],
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: width / 25,
                                                  fontFamily: "Cairo"),
                                            ),
                                          ),
                                          subtitle: Row(
                                           mainAxisAlignment: MainAxisAlignment.end,
                                           children: [
                                             Text(" قصيده",
                                                style: TextStyle(
                                                  color: Colors.black87,fontFamily:
                                                "Cairo")),
                                            Visibility(
                                              visible: items[index]['count']!='0',
                                              child: Text(" " + items[index]['count'],
                                               style: TextStyle(color: Colors.black87,fontFamily: "Cairo")),
                                            )
                                          ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    // Get.to(() => const DewanDetails());
                                    if (int.parse("${items[index]['count']}") > 0) {

                                      Navigator.push(context, MaterialPageRoute(builder: (context) => DewanTeserWsol()));

                                    }else if(int.parse("${items[index]['count']}") == 0) {
                                      navigateTo(
                                          context,
                                          KasydaDetails(
                                            kasyeda: items[index]['Kaseyda'],
                                            kasyedaT: items[index]['KaseydaT'],
                                            kasyedaTRepeat: items[index]['KaseydaT'],
                                            KName: items[index]['name'],
                                            KNameT: items[index]['KnameT'],
                                            DName: "",
                                          ));
                                    } else {
                                      displayToastMessage("عفوا لا يوجد قصائد حاليا فى حذا الديوان");
                                    }
                                  },
                                );
                              }):
                          ListView.builder(
                              itemCount: itemsKaseda.length,
                              itemBuilder: (BuildContext context, index) {
                                return InkWell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      margin: EdgeInsets.symmetric(horizontal: width / 40),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        color: Colors.white,
                                      ),
                                      child: ListTile(
                                        trailing: SvgPicture.asset(
                                          "assets/ico/ic_ksaed.svg",
                                          height: width / 12,
                                          width: width / 12,
                                        ),
                                        title: Directionality(
                                          textDirection: TextDirection.rtl,
                                          child:Column(
                                            children: [
                                              ColoredText(
                                                text: itemsKaseda[index]['Kaseyda'],
                                                value: SearchValue,
                                                context: context,
                                              ),
                                              Row(
                                                children: [
                                                  Text("الديوان : ", style: TextStyle(color: Constants.primary,fontFamily: "Cairo",fontWeight: FontWeight.w500)),
                                                  Text('ديوان تيسير الوصول', style: TextStyle(color: Constants.primary,fontFamily: "Cairo")),
                                                ],
                                              ),
                                              Visibility(
                                                visible: false,
                                                child: Row(
                                                  children: [
                                                    Text("القصيدة : ", style: TextStyle(color: Constants.primary,fontFamily: "Cairo",fontWeight: FontWeight.w500)),
                                                    Expanded(child: Text(itemsKaseda[index]['KnameT'], style: TextStyle(color: Constants.primary,fontFamily: "Cairo"))),
                                                  ],
                                                ),
                                              ),


                                            ],
                                          )
                                        ),
                                        subtitle: Visibility(
                                          visible: false,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Text(" قصيده",
                                                  style: TextStyle(color: Colors.black87,fontFamily:
                                                  "Cairo")),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                      navigateTo(
                                          context,
                                          KasydaDetails(
                                            kasyeda: itemsKaseda[index]['Kaseyda'],
                                            kasyedaT: itemsKaseda[index]['KaseydaT'],
                                            kasyedaTRepeat: itemsKaseda[index]['KaseydaT'],
                                            KName: itemsKaseda[index]['name'],
                                            KNameT: itemsKaseda[index]['KnameT'],
                                            DName: "",
                                          ));

                                  },
                                );
                              });
                        } else {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            child: Center(child: SpinKitCircle(color: Constants.primary,)),
                          );
                        }
                      },
                    ),
                  ),

                ],
              )

            ],
          ),
        ),
      ),
    );
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
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: _buildTextSpans(),
      ),
    );
  }

  List<TextSpan> _buildTextSpans() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    int blackWordsCount=0;

    final List<TextSpan> spans = [];

    // Split the text by space to apply styling to individual words
    final List<String> words = text.split(' ');

    for (int i = 0; i < words.length; i++) {
      final String word = words[i];

      if (word.toLowerCase().contains(value)) {
        blackWordsCount=0;
        spans.add(
          TextSpan(
            text: '$word ',
            style: TextStyle(
                color: Colors.teal,
                fontSize: width / 30,
                fontFamily: "Cairo",
            ),
          ),
        );
      } else {
        if(blackWordsCount<4){
          spans.add(
            TextSpan(
              text: '$word ',
              style:  TextStyle(
                  color: Colors.black54,
                  fontSize: width / 30,
                  fontFamily: "Cairo"
              ),
            ),
          );
        }
        blackWordsCount++;

      }
    }

    return spans;
  }
}
