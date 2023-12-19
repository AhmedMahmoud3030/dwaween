import 'dart:convert';

import 'package:dwaween/core/dewan.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeProvider extends ChangeNotifier {
  final TextEditingController searchController = TextEditingController();
  int selectedIndex = 0;
  String searchValue = "";

  void setSearchValue({required String value}) {
    searchValue = value;
    notifyListeners();
  }

  List<groupByClass> groupedBy = [];
  DawawenBody? dewanBody;

  // void searchTextFormField({required String query}) {}

  List<groupByClass> tempGroupedBy = [];
  DawawenBody? tempDewanBody;

  bool dewanBodyLoading = true;

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
