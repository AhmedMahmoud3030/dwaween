import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class kasyedaArea extends StatefulWidget {
  kasyedaArea(
      {super.key,
      required this.kasyeda,
      required this.textcolor,
      required this.size,
      required this.value});
  String value;
  String kasyeda;
  Color textcolor;
  double size;
  @override
  State<kasyedaArea> createState() => _kasyedaAreaState();
}

Future getkasyed() async {
  var url = 'https://www.turathtijania.com/index2.php';
  //var url = 'http://10.0.2.2/test/index2.php';
  http.Response response = await http.get(Uri.parse(url));
  var data = jsonDecode(response.body);
  return data;
}

var a = ["0"];
var b = ["0"];

class _kasyedaAreaState extends State<kasyedaArea> {
  @override
  Widget build(BuildContext context) {
    var k = widget.kasyeda.toString().split(".");
    return SafeArea(
      child: Align(
        alignment: Alignment.center,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width * 2,
          child: ListView.builder(
            itemCount: k.length,
            itemBuilder: (context, index) {
              return Container(
                child: index % 2 == 0
                    ? Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: ListTile(
                          title: Align(
                            alignment: Alignment.centerRight,
                            child: widget.value.isNotEmpty
                                ? ColoredText(
                                    text: k[index],
                                    value: widget.value,
                                    context: context,
                                    textcolor: Colors.black87,
                                    size: widget.size,
                                  )
                                : Text(
                                    k[index],
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontFamily: "Amiri Regular",
                                        fontSize: widget.size),
                                    textAlign: TextAlign.right,
                                  ),
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: ListTile(
                          title: Text(
                            k[index],
                            style: TextStyle(
                                color: Colors.black87,
                                fontFamily: "Amiri Regular",
                                fontSize: widget.size),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class ColoredText extends StatelessWidget {
  String text;
  String value;
  BuildContext context;
  Color textcolor;
  double size;

  ColoredText({
    required this.text,
    required this.value,
    required this.context,
    required this.textcolor,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: _buildTextSpans(),
      ),
    );
  }

  List<TextSpan> _buildTextSpans() {
    final List<TextSpan> spans = [];

    // Split the text by space to apply styling to individual words
    final List<String> words = text.split(' ');

    for (int i = 0; i < words.length; i++) {
      final String word = words[i];

      if (word.toLowerCase().contains(value)) {
        spans.add(
          TextSpan(
            text: '$word ',
            style: TextStyle(
                color: textcolor, fontFamily: "Amiri Regular", fontSize: size),
          ),
        );
      } else {
        spans.add(
          TextSpan(
            text: '$word ',
            style: TextStyle(
                color: Colors.teal,
                fontFamily: "Amiri Regular",
                fontSize: size),
          ),
        );
      }
    }

    return spans;
  }
}
