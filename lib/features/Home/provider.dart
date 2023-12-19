import 'dart:convert';

import 'package:dwaween/core/dewan.dart';
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

  
}
