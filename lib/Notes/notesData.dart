import 'package:dwaween/Screens/Comment/Comment.dart';
import 'package:dwaween/core/constants.dart';
import 'package:dwaween/core/help/database_helper_notification.dart';
import 'package:dwaween/core/nav.dart';
import 'package:dwaween/models/NoteModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../Screens/Knanish/KasayedDetails/KasydaDetails.dart';

class noteData extends StatefulWidget {
  const noteData({super.key});

  @override
  State<noteData> createState() => _noteDataState();
}

final TextEditingController _searchController = TextEditingController();
String SearchValue = "";
var filtared;
var items;

final scaffoldKey = GlobalKey<ScaffoldState>();

int _selectedIndex = 0;

TextEditingController controllerTitle = TextEditingController();
TextEditingController controllerDesc = TextEditingController();

class _noteDataState extends State<noteData> {
  DatabaseHelperNotificarion dbNotify = new DatabaseHelperNotificarion();
  List<NoteModel> allNotes = <NoteModel>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllData();
  }

  getAllData() async {
    allNotes = <NoteModel>[];
    await dbNotify.getAllDuaa().then((duaaModels) {
      setState(() {
        duaaModels.forEach((duaaModel) {
          allNotes.add(NoteModel.fromMap(duaaModel));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
                          'قائمة ملاحظاتى',
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
                      itemCount: allNotes.length,
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
                                        KName: allNotes[index].kName,
                                        kasyeda: allNotes[index].kText,
                                        KNameT: allNotes[index].kNameT,
                                        kasyedaTRepeat: allNotes[index].kTextT,
                                      ));
                                },
                                leading: Icon(
                                  Icons.book,
                                  color: Constants.primary,
                                ),
                                title: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    allNotes[index].title,
                                    style: TextStyle(
                                        color: Colors.teal,
                                        fontFamily: "Cairo"),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                                subtitle: Text(
                                  allNotes[index].body,
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
                                            controllerTitle.text =
                                                allNotes[index].title;
                                            controllerDesc.text =
                                                allNotes[index].body;
                                            setState(() {});
                                            showDialogEditNote(
                                                context, allNotes[index]);
                                          },
                                          child: Icon(
                                            Icons.edit_calendar_rounded,
                                            color: Constants.primary,
                                          )),
                                      InkWell(
                                          onTap: () {
                                            deleteFav(allNotes[index]);
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

  showDialogEditNote(BuildContext context, NoteModel note) async {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    /////
    showDialog(
        context: context,
        builder: (_) => Directionality(
              textDirection: TextDirection.rtl,
              child: Theme(
                data: ThemeData(dialogBackgroundColor: Colors.white),
                child: Builder(builder: (context) {
                  return AlertDialog(
                    backgroundColor: Colors.white,
                    contentPadding: const EdgeInsets.all(16.0),
                    content: Container(
                      height: height / 7,
                      color: Colors.white,
                      child: Column(
                        children: [
                          new Row(
                            children: <Widget>[
                              new Expanded(
                                child: new TextField(
                                  autofocus: true,
                                  controller: controllerTitle,
                                  decoration: new InputDecoration(
                                      // hintText: 'eg. John Smith',
                                      ),
                                ),
                              )
                            ],
                          ),
                          new Row(
                            children: <Widget>[
                              new Expanded(
                                child: new TextField(
                                  controller: controllerDesc,
                                  decoration: new InputDecoration(
                                      // hintText: 'eg. John Smith',
                                      ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: new DefaultElevatedButton(
                          height: height / 20,
                          width: width / 2,
                          onPressed: () {
                            EditZikr(context, note);
                          },
                          title: 'حفظ',
                          titleSize: width / 27,
                          color: Constants.primary,
                          borderRadius: 10,
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ));
  }

  void EditZikr(BuildContext context, NoteModel note) {
    if (controllerTitle.text.trim().isEmpty) {
      displayToastMessage("من فضلك ادخل العنوان");
      return;
    } else if (controllerDesc.text.trim().isEmpty) {
      displayToastMessage("من فضلك ادخل الوصف");
      return;
    }

    //اضافة للفيو
    note.title = controllerTitle.text;
    note.body = controllerDesc.text;
    setState(() {});
    //اضافة للفيو
    dbNotify
        .updateDuaa(NoteModel.fromMap({
      'id': note.id,
      'title': controllerTitle.text,
      'body': controllerDesc.text,
      'kName': note.kName,
      'kText': note.kText,
      'kNameT': note.kNameT,
      'kTextT': note.kTextT,
    }))
        .then((_) {
      Navigator.pop(context);
      displayToastMessage("تم التعديل");
    });
  }

  void deleteFav(NoteModel currentNote) async {
    await dbNotify.deleteDuaa(currentNote.id);
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