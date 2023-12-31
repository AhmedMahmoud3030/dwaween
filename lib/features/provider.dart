// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dwaween/core/dewan.dart';
import 'package:dwaween/features/About/about.dart';
import 'package:dwaween/features/Dwaween/view.dart';
import 'package:dwaween/features/Home/view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Kasaed/kasaed.dart';

class BaseProvider extends ChangeNotifier {
  //!-------------------------Base-----------------------------------------------
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
  }

  List<Dawawen> filterDawawenByName(String name) {
    var de = dewanBodyTemp;
    return de!.dawawen.where((d) {
      return d.name.toLowerCase().contains(name.toLowerCase());
    }).toList();
  }

  List<Dawawen> filterKaseydaByText(String text) {
    var de = dewanBodyTemp;
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

    notifyListeners();
  }

  //!----------------------------------------------------------------------------
  //!-----------------------HomeScreen-------------------------------------------
  TextEditingController homeController = TextEditingController();

  searchHomeMethod({
    required String searchValue,
  }) {
    restJson();
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
    }
    groupByPurpose(dewanBody!.dawawen);
    notifyListeners();
  }

  //!----------------------------------------------------------------------------
  //!-----------------------DewanScreen-------------------------------------------
  TextEditingController dewanController = TextEditingController();

  searchDewanMethod({
    required String searchValue,
  }) {
    restJson();
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
    restJson();
    if (searchValue.isNotEmpty) {
      String lowerCaseSearchValue = (searchValue).toLowerCase();

      List<Dawawen> filterKaseydaByTextList =
          filterKaseydaByText(lowerCaseSearchValue);
      if (filterKaseydaByTextList.length > 0) {
        dewanBody!.dawawen.clear();

        dewanBody!.dawawen = filterKaseydaByTextList;
      } else {
        dewanBody!.dawawen.clear();
      }
    } else {}
    groupByPurpose(dewanBody!.dawawen);
    notifyListeners();
  }
  //!----------------------------------------------------------------------------

  final scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController searchController = TextEditingController();
  String searchValue = "";

  List<groupByClass> groupedBy = [];

  DawawenBody? dewanBody;
  DawawenBody? dewanBodyTemp;

  List<groupByClass> tempGroupedBy = [];

  bool dewanBodyLoading = true;

  List<Widget> screens = [
    HomeScreen(),
    DwaweenScreen(),
    KasaedScreen(),
    AboutScreen()
  ];

  int selectedIndex = 0;

  List<String> _kafya = [];

  List<String> get kafya => _kafya;
  int? kafyaIndex;
  int? dewanIndex;

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

  setKafya(int index) {
    dewanIndex = index;
    _kafya.clear();
    for (var element in dewanBodyTemp!.dawawen[index].kasaed) {
      if (!_kafya.contains(element.letter)) {
        _kafya.add(element.letter);
      }
    }
    print('_kafya.length  ${_kafya.length}');

    notifyListeners();
  }

  void setSelectedIndex({required int index}) {
    selectedIndex = index;
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

  @override
  bool operator ==(covariant groupByClass other) {
    if (identical(this, other)) return true;

    return other.purpose == purpose && listEquals(other.kenshat, kenshat);
  }

  @override
  int get hashCode => purpose.hashCode ^ kenshat.hashCode;
}
