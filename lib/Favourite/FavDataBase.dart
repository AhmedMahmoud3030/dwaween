import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:dwaween/Models/FavModel.dart';
import 'package:dwaween/core/constants.dart';
import 'package:dwaween/core/help/database_helper_fav.dart';
import 'package:dwaween/core/nav.dart';

import '../Screens/Knanish/KasayedDetails/KasydaDetails.dart';

class FavDataBase extends StatefulWidget {
  const FavDataBase({super.key});

  @override
  State<FavDataBase> createState() => _FavDataBaseState();
}

String SearchValue = "";
var filtared;
var items;

final scaffoldKey = GlobalKey<ScaffoldState>();

int _selectedIndex = 0;

TextEditingController controllerTitle = TextEditingController();
TextEditingController controllerDesc = TextEditingController();

class _FavDataBaseState extends State<FavDataBase> {
  DatabaseHelperFavourite dbFav = new DatabaseHelperFavourite();
  List<FavModel> allFav = <FavModel>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllData();
  }

  getAllData() async {
    allFav = <FavModel>[];
    await dbFav.getAllFav().then((duaaModels) {
      setState(() {
        duaaModels.forEach((duaaModel) {
          allFav.add(FavModel.fromMap(duaaModel));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
                        width: width,
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.grey, spreadRadius: 0.3),
                          ],
                        ),
                        child: Text(
                          'قائمة المفضلة',
                          style: TextStyle(
                              fontFamily: "Cairo", fontSize: width / 25),
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
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: allFav.length,
                      itemBuilder: (BuildContext context, index) {
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
                                        KName: allFav[index].kName,
                                        kasyeda: allFav[index].kText,
                                        KNameT: allFav[index].kNameT,
                                        kasyedaTRepeat: allFav[index].kTextT,
                                      ));
                                },
                                leading: Icon(
                                  Icons.book,
                                  color: Constants.primary,
                                ),
                                title: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    allFav[index].kName,
                                    style: TextStyle(
                                        color: Colors.teal,
                                        fontFamily: "Cairo"),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                                subtitle: Text(
                                  allFav[index].kNameT,
                                  style: TextStyle(
                                      color: Colors.teal, fontFamily: "Cairo"),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                trailing: SizedBox(
                                  width: width / 6,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            deleteFav(allFav[index]);
                                          },
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          )),
                                    ],
                                  ),
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

  void deleteFav(FavModel currentNote) async {
    await dbFav.deleteFav(currentNote.id);
    displayToastMessage("تم الحذف");
    getAllData();
  }
}

/*
  @override
  Widget build(BuildContext context) {
    print("${boxFavourite.length}");
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
                          onChanged: (value) {

                          },
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
                        Notes note = boxNotes.getAt(index);
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Container(
                              color: Colors.white,
                              child: ListTile(
                                onTap: (){
                                  navigateTo(context,KasydaDetails(
                                    DName: '',KName :  note.kName, kasyeda: note.kText,
                                  ));
                                },
                                leading: Icon(Icons.book,color: Constants.primary,),
                                title: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    note.title,
                                    style: TextStyle(
                                        color: Colors.teal,
                                        fontFamily: "Cairo"
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                                subtitle:  Text(
                                  note.body,
                                  style: TextStyle(color: Colors.teal,
                                      fontFamily: "Cairo"
                                  ),
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
 */