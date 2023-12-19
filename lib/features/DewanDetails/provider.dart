// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dwaween/core/dewan.dart';
import 'package:flutter/material.dart';

class DewanDetailsProvider extends ChangeNotifier {
  final TextEditingController searchController = TextEditingController();
  int selectedIndex = 0;
  String searchValue = "";
  Dawawen? dawawen;
  Dawawen? dawawenTemp;

  List<String> kafya = [];

  int? kafyaIndex;

  void selectKafya({required int selectValue, required String letter}) {
    print(letter);
    print(dawawen!.kasaed!.length);
    kafyaIndex = selectValue;
    dawawenTemp = dawawen;
    dawawen!.kasaed!.clear();
    if (letter.isNotEmpty) {
      dawawen!.kasaed!.addAll(
          dawawenTemp!.kasaed!.where((element) => element.letter == letter));
    }

    print(
        (dawawen!.kasaed!.where((element) => element.letter == letter)).length);
    print(dawawen!.kasaed!.length);

    notifyListeners();
  }

  void setSearchValue({required String value}) {
    searchValue = value;
    notifyListeners();
  }
}
