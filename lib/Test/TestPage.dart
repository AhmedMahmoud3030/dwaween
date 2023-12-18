import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

void main() {
  runApp(MaterialApp(
    home: TestPage(),
  ));
}

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Page'),
      ),
      body: Screenshot(
        controller: screenshotController,
        child: Center(
          child: Container(
            color: Colors.blue,
            child: Text(
              'This is a test page for screenshots',
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
            padding: EdgeInsets.all(16.0),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Capture the screenshot
          Uint8List? imageBytes = await screenshotController.capture();

          // Save the screenshot to a file
          String imagePath = await _saveImage(imageBytes!);

          // Share the saved image file
          await Share.shareFiles([imagePath],
              text: 'Check out this screenshot!',
              subject: 'Screenshot Shared');

          },
        child: Icon(Icons.share),
      ),
    );
  }

  Future<String> _saveImage(Uint8List imageBytes) async {
    try {
      // Get the temporary directory
      final directory = await getTemporaryDirectory();

      // Create a unique filename
      String filePath = '${directory.path}/screenshot.png';

      // Write the image bytes to a file
      await File(filePath).writeAsBytes(imageBytes);

      return filePath;
    } catch (e) {
      print('Error saving image: $e');
      return '';
    }
  }
}
