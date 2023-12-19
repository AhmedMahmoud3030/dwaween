
import 'package:flutter/material.dart';

class DwaweenProvider extends ChangeNotifier {
  final TextEditingController searchController = TextEditingController();
  int selectedIndex = 0;
  String searchValue = "";

  void setSearchValue({required String value}) {
    searchValue = value;
    notifyListeners();
  }


  final scaffoldKey = GlobalKey<ScaffoldState>();


  
}
