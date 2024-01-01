import 'package:flutter/material.dart';

class PoemView extends StatelessWidget {
  final List<String> poems;

  PoemView({required this.poems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Poem Viewer'),
      ),
      body: ListView.builder(
        itemCount: poems.length,
        itemBuilder: (context, index) {
          // Check if the index is even or odd to determine alignment
          bool isEvenIndex = index % 2 == 0;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment:
                  isEvenIndex ? MainAxisAlignment.start : MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    color: isEvenIndex ? Colors.grey[300] : Colors.grey[200],
                    child: Text(
                      poems[index],
                      textAlign: isEvenIndex
                          ? TextAlign.start
                          : TextAlign.end, // Adjust text alignment
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
