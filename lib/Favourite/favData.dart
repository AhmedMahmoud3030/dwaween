import 'package:dwaween/Hive_Services/boxes.dart';
import 'package:dwaween/core/constants.dart';
import 'package:dwaween/core/nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../Screens/Knanish/KasayedDetails/KasydaDetails.dart';
import '../models/favourite.dart';

class favData extends StatefulWidget {
  const favData({super.key});

  @override
  State<favData> createState() => _favDataState();
}

final TextEditingController _searchController = TextEditingController();
String SearchValue = "";
var filtared;
var items;

final scaffoldKey = GlobalKey<ScaffoldState>();

int _selectedIndex = 0;

class _favDataState extends State<favData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Color.fromARGB(255, 250, 250, 234),
          child: Stack(
            children: [
              Stack(
                children: [
                  SvgPicture.asset(
                    "assets/images/paintings/img_head_home.svg",
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
                        child: TextField(
                          controller: _searchController,
                          onChanged: (value) {},
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                            hintText: 'البحث فى الديوان',
                            filled: true, //<-- SEE HERE
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 3, color: Colors.white),
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
                              onPressed: () => _searchController.clear(),
                            ),
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
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: boxFavourite.length,
                      itemBuilder: (BuildContext context, index) {
                        Favourite fa = boxFavourite.getAt(index);
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Container(
                              color: Colors.white,
                              child: ListTile(
                                onTap: () {
                                  navigateTo(
                                      context,
                                      KasydaDetails(
                                        DName: '',
                                        kasyeda: fa.Kname,
                                        KName: fa.Dname,
                                      ));
                                },
                                leading: Icon(
                                  Icons.book,
                                  color: Constants.primary,
                                ),
                                title: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    fa.Dname,
                                    style: TextStyle(
                                        color: Colors.teal,
                                        fontFamily: "Cairo"),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                                subtitle: Text(
                                  fa.Kname,
                                  style: TextStyle(
                                      color: Colors.teal, fontFamily: "Cairo"),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ),
                          ),
                        );
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
