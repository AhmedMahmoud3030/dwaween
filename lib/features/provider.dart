// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dwaween/Screens/About/about.dart';
import 'package:dwaween/Screens/Knanish/Knanish.dart';
import 'package:dwaween/core/dewan.dart';
import 'package:dwaween/features/Dwaween/view.dart';
import 'package:dwaween/features/Home/view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BaseProvider extends ChangeNotifier {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController searchController = TextEditingController();
  String searchValue = "";

  List<groupByClass> groupedBy = [];

  DawawenBody? dewanBody;

  List<groupByClass> tempGroupedBy = [];

  DawawenBody? tempDewanBody;

  bool dewanBodyLoading = true;

  List<Widget> screens = [HomeScreen(), DwaweenScreen(), Knanish(), about()];

  int selectedIndex = 0;

  Dawawen? dawawen;

  Dawawen? dawawenTemp;

  List<String> kafya = [];

  int? kafyaIndex;

  void setSelectedIndex({required int index}) {
    selectedIndex = index;
    notifyListeners();
  }

  void selectKafya({required int selectValue, required String letter}) {
    print(letter);
    kafyaIndex = selectValue;
    dawawenTemp = dawawen;

    if (letter.isNotEmpty) {
      // dawawenTemp!.kasaed!.clear();
      dawawenTemp!.kasaed!.addAll(
          dawawenTemp!.kasaed!.where((element) => element.letter == letter));
    }

    print(dawawenTemp?.kasaed?.length);

    notifyListeners();
  }

  void setSearchValue({required String value}) {
    searchValue = value;
    notifyListeners();
  }

  Future<void> readDwaweenData() async {
    dewanBodyLoading = true;
    notifyListeners();
    final String res =
        await rootBundle.loadString('assets/json/dewanlist.json');

    var loadedData = await json.decode(res);
    dewanBody = await dawawenBodyFromJson(loadedData);

    dewanBodyLoading = false;
    groupByPurpose(dewanBody!.dawawen!);
    notifyListeners();
  }

  void groupByPurpose(List<Dawawen> dawawenList) {
    Map<String, List<Kenashat>> grouped = {};

    for (var dawawen in dawawenList) {
      for (var kaseda in dawawen.kasaed!) {
        grouped.putIfAbsent(kaseda.purpose!, () => []);
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
