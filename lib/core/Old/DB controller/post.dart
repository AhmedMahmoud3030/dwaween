import 'dart:convert';
import 'package:http/http.dart' as http;

Future<http.Response> createAlbum(String title) {
  return http.post(
    Uri.parse('https://www.turathtijania.com/post.php'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'title': title,
    }),
  );
}
