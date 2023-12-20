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

  Dawawen? _dawawen;

  Dawawen? get dawawen => _dawawen;

  void setDawawen(Dawawen? value) {
    _dawawen = value;
    notifyListeners();
  }

  Dawawen? dawawenTemp;

  List<String> _kafya = [];

  List<String> get kafya => _kafya;
  int? kafyaIndex;

  setKafya(int index) {
    _kafya.clear();
    for (var element in dewanBody!.dawawen![index].kasaed!) {
      if (!_kafya.contains(element.letter)) {
        _kafya.add(element.letter!);
      }
    }
    print('_kafya.length');

    print(_kafya.length);

    notifyListeners();
  }

  void setSelectedIndex({required int index}) {
    selectedIndex = index;
    notifyListeners();
  }

  void selectKafya({required int selectValue}) {
    dawawenTemp = dawawen;

    if (selectValue!=kafyaIndex||kafyaIndex==null) {
      dawawen!.kasaed!.addAll(
        dawawen!.kasaed!.where(
          (element) => element.letter == _kafya[selectValue],
        ),
      );
      kafyaIndex = selectValue;
    } 


    if (kafyaIndex == selectValue) {
      

      setDawawen(dawawenTemp);
      kafyaIndex = null;
    } 

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
