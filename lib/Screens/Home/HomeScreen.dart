import 'dart:convert';
import 'package:dwaween/Screens/DwawenList/DewanDetails/DewanGabrElksr.dart';
import 'package:dwaween/Screens/DwawenList/dlistview.dart';
import 'package:dwaween/Screens/Home/duellist.dart';

import 'package:dwaween/core/constants.dart';
import 'package:dwaween/core/nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../DwawenList/DewanDetails/DewanTeserWsol.dart';
import '../Knanish/KasayedDetails/AudioPlayer/audio_card.dart';
import '../Knanish/Knanish.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}



class _HomescreenState extends State<Homescreen> {
  final TextEditingController _searchController = TextEditingController();
  int _selectedIndex = 0;
  String SearchValue = "";
  var filtared;
  var items;

  // String dName1= "جبر الكسر";
  // String dName2= "الكبريت الأحمر";
  String dName3= "تيسير الوصول";
  // String dName4= "إكسير السعادة";

  @override
  void initState() {
    super.initState();
    // _audioPlayer = AudioPlayer()..setAsset('assets/tone10.mp3');
  }

  Future<void> dispose() async {
    super.dispose();
    //  _audioPlayer.stop();
  }

  //var isScrollLocked = false;
  @override
  Widget build(BuildContext context1) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 250, 250, 234),
        child: Stack(
          children: [
            SvgPicture.asset(
              "assets/img/img_heade_home.svg",
              alignment: Alignment.topCenter,
              width: width,
              height: height / 2,
            ),
            Column(
              children: [
                Container(
                  color: Colors.transparent,
                  height: height / 4,
                ),
                Container(
                  height: 60,
                  color: Colors.transparent,
                  // Add padding around the search bar
                  padding:  EdgeInsets.symmetric(horizontal: width/20),
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
                        borderSide: BorderSide(width: 3, color: Colors.white),
                        borderRadius: BorderRadius.circular(20.0),
                      ),

                      hintStyle: TextStyle(fontFamily: 'Cairo',),
                      // Add a clear button to the search bar
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          setState(() {
                            print("object");
                          });
                        },
                      ),

                      // Add a search icon or button to the search bar
                      prefixIcon:
                           Visibility(
                             visible: _searchController.text.length > 0,
                             child: IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  _searchController.clear();
                                  setState(() {
                                    SearchValue = "";
                                  });
                                },
                              ),
                           )

                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        //المشغل
                        AudioCard(),
                        SizedBox(height: 10,),
                        //عرض الكل والدواوين
                        SizedBox(
                          height:35,
                          child: Align(
                            alignment: Alignment.center,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(width: width/25,),
                                InkWell(
                                  onTap: () {
                                    // Dwaweenlist
                                    navigateTo(context, Dwaweenlist());
                                  },
                                  child: Text(
                                    "عرض الكل ",
                                    style: TextStyle(
                                        color: Colors.teal,
                                        fontSize: width / 25,
                                        fontFamily: "Cairo",
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Spacer(),
                                SizedBox(
                                  width: width / 2.1,
                                  child: Divider(
                                    color: Colors.teal,
                                    thickness: 1.5,
                                  ),
                                ),
                                Spacer(),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "دواوين ",
                                    style: TextStyle(
                                        color: Colors.teal,
                                        fontSize: width / 25,
                                        fontFamily: "Cairo",
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SvgPicture.asset(
                                  "assets/ico/ic_ksaed.svg",
                                  height: width / 12,
                                  width: width / 12,
                                ),
                                SizedBox(width: width/25,),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        //قائمة الدواوين
                        Container(
                          width: width,
                          margin: EdgeInsets.symmetric(horizontal: width / 30),
                          child: Column(
                            children: [

                              Visibility(
                                  visible: SearchValue.isNotEmpty&&(dName3.contains(SearchValue)==false),
                                  child: Center(child: Text("عفوا لا توجد نتائج بحث مطابقة",style: TextStyle(fontFamily: "Cairo",color: Constants.primary,fontSize: 15),),)),

                              Visibility(
                                visible: SearchValue.isNotEmpty&&dName3.contains(SearchValue)||SearchValue.isEmpty,
                                child: InkWell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        color: Colors.white,
                                      ),
                                      child: ListTile(
                                        trailing: SvgPicture.asset(
                                          "assets/ico/ic_ksaed.svg",
                                          height: 25,
                                          width: 25,
                                        ),
                                        title: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(dName3,
                                            style: TextStyle(color: Colors.teal, fontFamily: "Cairo"),
                                          ),
                                        ),
                                        subtitle: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.end,
                                          children: [
                                            Text(" قصيده", style: TextStyle(color: Colors.teal)),
                                            Text(
                                                "28",
                                                style: TextStyle(color: Colors.teal, fontFamily: "Cairo"))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    navigateTo(context, DewanTeserWsol());
                                  },
                                ),
                              ),

                              /*
                              Visibility(
                                visible: SearchValue.isNotEmpty&&dName4.contains(SearchValue)||SearchValue.isEmpty,
                                child: InkWell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        color: Colors.white,
                                      ),
                                      child: ListTile(
                                        trailing: SvgPicture.asset(
                                          "assets/ico/ic_ksaed.svg",
                                          height: 25,
                                          width: 25,
                                        ),
                                        title: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(dName4,
                                            style: TextStyle(color: Colors.teal, fontFamily: "Cairo"),
                                          ),
                                        ),
                                        subtitle: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.end,
                                          children: [
                                            Text(" قصيده", style: TextStyle(color: Colors.teal)),
                                            Text(
                                                " 0",
                                                style: TextStyle(color: Colors.teal, fontFamily: "Cairo"))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    navigateTo(context, DewanGabrElksr());
                                  },
                                ),
                              ),
                            */
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        //عرض الكل والقصائد
                        SizedBox(
                          height: 35,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(width: width/25,),
                                InkWell(
                                  onTap: () {
                                    // Dwaweenlist
                                    navigateTo(context, Knanish());
                                  },
                                  child: Text(
                                    "عرض الكل ",
                                    style: TextStyle(
                                        color: Colors.teal,
                                        fontSize: width / 25,
                                        fontFamily: "Cairo",
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Spacer(),
                                SizedBox(
                                  width: width / 2.1,
                                  child: Divider(
                                    color: Colors.teal,
                                    thickness: 1.5,
                                  ),
                                ),
                                Spacer(),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "القصائد ",
                                    style: TextStyle(
                                        color: Colors.teal,
                                        fontSize: width / 25,
                                        fontFamily: "Cairo",
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SvgPicture.asset(
                                  "assets/ico/ic_ksaed.svg",
                                  height: width / 12,
                                  width: width / 12,
                                ),
                                SizedBox(width: width/25,),
                              ],
                            ),
                          ),
                        ),
                        DuelList(),
                      ],
                    ),
                  ),
                ),
                // CardsListview(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<List> readData() async {
    final String res = await rootBundle.loadString('assets/json/dewanlist.json');
    final loadedData = await json.decode(res);
    List _dawaweenList = loadedData['Dawawen'];
    return _dawaweenList;
  }
}

// Widget bar() {
//   return Column(
//     children: <Widget>[
//       const Center(
//         child: Text(
//           "Home",
//           style: TextStyle(
//               fontSize: 25.0,
//               fontWeight: FontWeight.w600,
//               color: Color.fromARGB(255, 246, 246, 147)),
//         ),
//       ),
//       Positioned(
//         // To take AppBar Size only
//         child: Container(
//           color: Colors.white,
//           // Add padding around the search bar
//           padding: const EdgeInsets.symmetric(horizontal: 12.0),
//           // Use a Material design search bar
//           child: TextField(
//             controller: _searchController,
//             decoration: InputDecoration(
//               hintText: 'Search...',
//               // Add a clear button to the search bar
//               suffixIcon: IconButton(
//                 icon: const Icon(Icons.clear),
//                 onPressed: () => _searchController.clear(),
//               ),
//               // Add a search icon or button to the search bar
//               prefixIcon: IconButton(
//                 icon: const Icon(Icons.search),
//                 onPressed: () {
//                   // Perform the search here
//                 },
//               ),
//               border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(20.0),
//                   borderSide: const BorderSide(color: Colors.white)),
//             ),
//           ),
//         ),
//       )
//     ],
//   );
// }
