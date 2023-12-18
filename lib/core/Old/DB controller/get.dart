import 'dart:convert';
import 'package:http/http.dart' as http;

Future getData() async {
  //var url = 'https://www.turathtijania.com/get.php';
  var url = 'http://localhost/test/index.php';
  http.Response response = await http.get(Uri.parse(url));
  var data = jsonDecode(response.body);
  return data;
  //print(data.toString());
}


