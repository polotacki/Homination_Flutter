import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpHelper {
  static Future<http.Response> postData({
    required String url,
    required Map<String, dynamic> data,
  }) async {
    print(json.encode(data));
    return await http.post(
      Uri.parse('https://homination.onrender.com/$url'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
  }

  static Future<http.Response> getData({required String url}) async {
    return await http.get(Uri.parse('https://homination.onrender.com/$url'));
  }
}
