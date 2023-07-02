import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpHelper {
  static Future<http.Response> postData({
    required String url,
    required Map<String, dynamic> data,required headers
  }) async {
    print(json.encode(data));
    return await http.post(
      Uri.parse('https://homination.onrender.com/$url'),
      headers: headers,
      body: json.encode(data),
    );
  }

  static Future<http.Response> getData({required String url,headers}) async {

    return await http.get(Uri.parse('https://homination.onrender.com/$url'),headers: headers);
  }
}
