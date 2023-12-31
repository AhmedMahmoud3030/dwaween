import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

  bool hasTextOverflow(String text, TextStyle style,
      {double minWidth = 0,
      double maxWidth = double.infinity,
      int maxLines = 2}) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: maxLines,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: minWidth, maxWidth: maxWidth);

    var x = textPainter.didExceedMaxLines;
    return x;
  }

  void displayToastMessage(var toastMessage) {
    Fluttertoast.showToast(
        msg: toastMessage.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  List<String> splitToGetFirstTwoWords(String text) {
    List<String> parts = text.split('.').take(2).toList();

    return parts;
  }
}
