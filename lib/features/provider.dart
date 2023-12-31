// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dwaween/core/dewan.dart';
import 'package:dwaween/features/About/about.dart';
import 'package:dwaween/features/Dwaween/view.dart';
import 'package:dwaween/features/Home/view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Kasaed/kasaed.dart';

class BaseProvider extends ChangeNotifier {
  //!-------------------------Base-----------------------------------------------
  int selectedIndex = 0;

  List<String> _kafya = [];

  List<String> get kafya => _kafya;
  int? kafyaIndex;
  int? dewanIndex;
  clearTextEditingController(bool x) {
    kasayedController.clear();
    homeController.clear();
    aboutController.clear();
    x ? dewanController.clear() : null;
    groupByPurpose(dewanBody!.dawawen);
  }

  Future<void> readDwaweenData() async {
    dewanBodyLoading = true;
    notifyListeners();
    final String res =
        await rootBundle.loadString('assets/json/dewanlist.json');

    var loadedData = await json.decode(res);

    dewanBody = await DawawenBody.fromJson(loadedData);
    dewanBodyTemp = await DawawenBody.fromJson(loadedData);

    dewanBodyLoading = false;
    groupByPurpose(dewanBody!.dawawen);
    notifyListeners();
  }

  restJson() {
    Map<String, dynamic> json = jsonDecode(jsonEncode(dewanBodyTemp));
    dewanBody = DawawenBody.fromJson(json);
    groupByPurpose(dewanBody!.dawawen);
  }

  List<Dawawen> filterDawawenByName(String name) {
    Map<String, dynamic> json = jsonDecode(jsonEncode(dewanBodyTemp));
    var de = DawawenBody.fromJson(json);
    return de!.dawawen.where((d) {
      return d.name.toLowerCase().contains(name.toLowerCase());
    }).toList();
  }

  List<Dawawen> filterKaseydaByText(String text) {
    Map<String, dynamic> json = jsonDecode(jsonEncode(dewanBodyTemp));
    var de = DawawenBody.fromJson(json);
    de!.dawawen.forEach((dawawen) {
      dawawen.kasaed = dawawen.kasaed
          .where((kenashat) =>
              kenashat.kaseyda.toLowerCase().contains(text.toLowerCase()))
          .toList();
    });

    return de.dawawen;
  }

  void groupByPurpose(List<Dawawen> dawawenList) {
    Map<String, List<Kenashat>> grouped = {};

    for (var dawawen in dawawenList) {
      for (var kaseda in dawawen.kasaed) {
        grouped.putIfAbsent(kaseda.purpose, () => []);
        grouped[kaseda.purpose]!.add(kaseda);
      }
    }

    groupedBy = grouped.entries.map((entry) {
      return groupByClass(
        purpose: entry.key,
        kenshat: entry.value,
      );
    }).toList();
    groupedByTemp = grouped.entries.map((entry) {
      return groupByClass(
        purpose: entry.key,
        kenshat: entry.value,
      );
    }).toList();

    notifyListeners();
  }

  //!----------------------------------------------------------------------------
  //!-----------------------HomeScreen-------------------------------------------
  TextEditingController homeController = TextEditingController();

  searchHomeMethod({
    required String searchValue,
  }) {
    if (searchValue.isNotEmpty) {
      String lowerCaseSearchValue = (searchValue).toLowerCase();
      List<Dawawen> filterDawawenByNameList =
          filterDawawenByName(lowerCaseSearchValue);
      if (filterDawawenByNameList.length > 0) {
        dewanBody!.dawawen.clear();
        dewanBody!.dawawen = filterDawawenByNameList;
      } else {
        List<Dawawen> filterKaseydaByTextList =
            filterKaseydaByText(lowerCaseSearchValue);
        dewanBody!.dawawen.clear();
        dewanBody!.dawawen = filterKaseydaByTextList;
      }
    } else {
      restJson();
    }
    groupByPurpose(dewanBody!.dawawen);
    notifyListeners();
  }

//!----------------------------------------------------------------------------
  //!-----------------------AboutScreen-------------------------------------------
  TextEditingController aboutController = TextEditingController();

  //!----------------------------------------------------------------------------
  //!-----------------------DewanScreen-------------------------------------------
  TextEditingController dewanController = TextEditingController();

  searchDewanMethod({
    required String searchValue,
  }) {
    if (searchValue.isNotEmpty) {
      String lowerCaseSearchValue = (searchValue).toLowerCase();
      List<Dawawen> filterDawawenByNameList =
          filterDawawenByName(lowerCaseSearchValue);
      if (filterDawawenByNameList.length > 0) {
        dewanBody!.dawawen.clear();
        dewanBody!.dawawen = filterDawawenByNameList;
      } else {
        dewanBody!.dawawen.clear();
      }
    } else {
      restJson();
    }
    groupByPurpose(dewanBody!.dawawen);
    notifyListeners();
  }

  //!----------------------------------------------------------------------------
  //!-----------------------KasayedScreen-------------------------------------------
  TextEditingController kasayedController = TextEditingController();

  searchKasayedMethod({
    required String searchValue,
  }) {
    if (searchValue.isNotEmpty) {
      String lowerCaseSearchValue = (searchValue).toLowerCase();

      List<Dawawen> filterKaseydaByTextOrPurposeList =
          filterKaseydaByTextOrPurpose(lowerCaseSearchValue);
      if (filterKaseydaByTextOrPurposeList.length > 0) {
        dewanBody!.dawawen.clear();

        dewanBody!.dawawen = filterKaseydaByTextOrPurposeList;
      } else {
        dewanBody!.dawawen.clear();
      }
    } else {
      restJson();
    }
    groupByPurpose(dewanBody!.dawawen);
    notifyListeners();
  }

  List<Dawawen> filterKaseydaByTextOrPurpose(String text) {
    Map<String, dynamic> json = jsonDecode(jsonEncode(dewanBodyTemp));
    var de = DawawenBody.fromJson(json);
    de!.dawawen.forEach((dawawen) {
      dawawen.kasaed = dawawen.kasaed
          .where((kenashat) =>
              (kenashat.kaseyda.toLowerCase().contains(text.toLowerCase())) ||
              kenashat.purpose.toLowerCase().contains(text.toLowerCase()))
          .toList();
    });

    return de.dawawen;
  }

  TextEditingController kasayedByGategoryController = TextEditingController();

  searchKasayedByGategoryMethod({
    required String? searchValue,
  }) {
    restJson();
    String lowerCaseSearchValue = (searchValue ?? '').toLowerCase();
    if (lowerCaseSearchValue.isNotEmpty) {
      groupedBy[groupByPurposeIndex].kenshat =
          groupedByTemp[groupByPurposeIndex]
              .kenshat
              .where((element) =>
                  element.purpose.toLowerCase().contains(lowerCaseSearchValue))
              .toList();
    } else {
      groupedBy[groupByPurposeIndex].kenshat =
          groupedByTemp[groupByPurposeIndex].kenshat;
    }
    notifyListeners();
  }

  int groupByPurposeIndex = 0;
  setGroupedByIndex({required int index}) {
    groupByPurposeIndex = index;
    notifyListeners();
  }

  //!----------------------------------------------------------------------------

  final scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController searchController = TextEditingController();
  String searchValue = "";

  List<groupByClass> groupedBy = [];
  List<groupByClass> groupedByTemp = [];

  DawawenBody? dewanBody;
  DawawenBody? dewanBodyTemp;

  bool dewanBodyLoading = true;

  List<Widget> screens = [
    HomeScreen(),
    DwaweenScreen(),
    KasaedScreen(),
    AboutScreen()
  ];

  void changeLang({required BuildContext context}) {
    print('changeLang');
    print(context.locale.languageCode);
    if (context.locale.languageCode == 'ar') {
      EasyLocalization.of(context)!.setLocale(Locale('en'));
    } else {
      EasyLocalization.of(context)!.setLocale(Locale('ar'));
    }
    notifyListeners();
  }

  seDewanIndex(int index) {
    dewanIndex = index;
    notifyListeners();
  }

  setKafya(int index) {
    _kafya.clear();
    for (var element in dewanBodyTemp!.dawawen[index].kasaed) {
      if (!_kafya.contains(element.letter)) {
        _kafya.add(element.letter);
      }
    }
    print('_kafya.length  ${_kafya.length}');

    notifyListeners();
  }

  setKafyaIndex(int? index) {
    if (index != null) {
      kafyaIndex = index;
    } else {
      kafyaIndex = null;
    }
    print("kafyaIndex $kafyaIndex");
    notifyListeners();
  }

  TextEditingController kafyaController = TextEditingController();

  String _kasydaScreenText = "";

  String get kasydaScreenText => _kasydaScreenText;

  setkasydaScreenText(String value) {
    _kasydaScreenText = value;
    notifyListeners();
  }

  filterByKasyda() {
    String lowerCaseSearchValue = (_kasydaScreenText ?? '').toLowerCase();

    if ((lowerCaseSearchValue.isEmpty) && kafyaIndex == null) {
      restJson();
    }
    if ((lowerCaseSearchValue.isNotEmpty) || kafyaIndex != null) {
      List<Dawawen> filterKaseydaByLetterOrTextList =
          filterKaseydaByLetterOrText(
              text: lowerCaseSearchValue, index: kafyaIndex);
      if (filterKaseydaByLetterOrTextList.length > 0) {
        dewanBody!.dawawen.clear();

        dewanBody!.dawawen = filterKaseydaByLetterOrTextList;
      } else {
        dewanBody!.dawawen.clear();
      }
    }
    notifyListeners();
  }

  List<Dawawen> filterKaseydaByLetterOrText({String? text, int? index}) {
    Map<String, dynamic> json = jsonDecode(jsonEncode(dewanBodyTemp));
    var de = DawawenBody.fromJson(json);

    if (text != null) {
      de.dawawen[dewanIndex!].kasaed = de.dawawen[dewanIndex!].kasaed
          .where((kenashat) => (kenashat.kaseyda.toLowerCase().contains(text)))
          .toList();
    }

    if (index != null) {
      de.dawawen[dewanIndex!].kasaed = de.dawawen[dewanIndex!].kasaed
          .where((kenashat) => (kenashat.letter
              .toLowerCase()
              .contains(kafya[index].toLowerCase())))
          .toList();
    }
    // Use 1 as the index to access the first element in the list

    return de.dawawen;
  }

  void setSelectedIndex({required int index, required bool x}) {
    selectedIndex = index;
    clearTextEditingController(x);
    restJson();
    notifyListeners();
  }
}

class groupByClass {
  String purpose;
  List<Kenashat> kenshat;
  groupByClass({
    required this.purpose,
    required this.kenshat,
  });
}
