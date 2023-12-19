import 'package:flutter/material.dart';

class Utils {

  String convertToArabicNumber(String number) {
  String res = '';

  final arabics = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
  number.characters.forEach((element) {
     res += arabics[int.parse(element)];
  });

/*   final latins = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']; */
  return res;
}
}
