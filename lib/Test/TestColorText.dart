import 'package:flutter/material.dart';



class TestColorText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Colored Text Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ColoredText(text: 'Mustafa nazir'),
            ColoredText(text: 'man please'),
            ColoredText(text: 'new dress'),
          ],
        ),
      ),
    );
  }
}

class ColoredText extends StatelessWidget {
  final String text;

  ColoredText({required this.text});

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

      if (word.toLowerCase() == 'man') {
        spans.add(
          TextSpan(
            text: '$word ',
            style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
          ),
        );
      } else {
        spans.add(
          TextSpan(
            text: '$word ',
            style: TextStyle(color: Colors.blue),
          ),
        );
      }
    }

    return spans;
  }
}
