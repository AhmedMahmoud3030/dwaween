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
  //!-----------------------HomeScreen-------------------------------------------
  TextEditingController homeController = TextEditingController();

  searchHomeMethod({
    required String searchValue,
  }) {
    Map<String, dynamic> json = jsonDecode(jsonEncode(dewanBodyTemp));
    dewanBody = DawawenBody.fromJson(json);

    if (searchValue.isNotEmpty) {
      dewanBody = searchByNameOrKaseyda(searchValue);
    }

    groupByPurpose(dewanBody!.dawawen);

    notifyListeners();
  }

  DawawenBody searchByNameOrKaseyda(String searchTerm) {
    // Filter Dawawen objects based on the provided search term
    List<Dawawen> filteredDawawen = dewanBodyTemp!.dawawen.where((dawawen) {
      // Check if Dawawen Name or any Kaseyda matches the search term
      bool nameMatch =
          dawawen.name.toLowerCase().contains(searchTerm.toLowerCase());
      bool kaseydaMatch = dawawen.kasaed.every((kenashat) =>
          kenashat.kaseyda.toLowerCase().contains(searchTerm.toLowerCase()));

      // Return true if either condition is met
      return nameMatch || kaseydaMatch;
    }).toList();

    // Return a new DawawenBody instance with the filtered Dawawen objects
    return DawawenBody(dawawen: filteredDawawen);
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

  Future<void> searchMethod({
    int? selectIndex,
    String? searchValue,
  }) async {
    Map<String, dynamic> json = jsonDecode(jsonEncode(dewanBodyTemp));
    dewanBody = DawawenBody.fromJson(json);

    if (selectIndex != null) {
      // Search by Dawawen name
      String lowerCaseSearchValue = (searchValue ?? '').toLowerCase();
      dewanBody!.dawawen[dewanIndex!].kasaed.clear();

      dewanBody!.dawawen[dewanIndex!].kasaed.addAll(
        dewanBodyTemp!.dawawen[dewanIndex!].kasaed.where(
          (element) =>
              element.letter == _kafya[selectIndex] &&
              (element.name.toLowerCase().contains(lowerCaseSearchValue) ||
                  element.kaseyda.toLowerCase().contains(lowerCaseSearchValue)),
        ),
      );

      kafyaIndex = selectIndex;
    } else {
      // Reset to the original state

      // Search by Dawawen name
      String lowerCaseSearchValue = (searchValue ?? '').toLowerCase();
      dewanBody!.dawawen[dewanIndex!].kasaed.clear();

      dewanBody!.dawawen[dewanIndex!].kasaed.addAll(
        dewanBodyTemp!.dawawen[dewanIndex!].kasaed.where(
          (element) =>
              element.name.toLowerCase().contains(lowerCaseSearchValue),
        ),
      );
      kafyaIndex = null;
      // dewanBody = dewanBodyTemp;
    }

    groupByPurpose(dewanBody!.dawawen);

    notifyListeners();
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
