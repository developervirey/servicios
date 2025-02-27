import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class HttpsServices {
  static const String baseUrl = "http://192.168.100.200/servicios/api.php";
  
  static const Map<String, String> defaultHeaders = {'Content-Type': 'application/x-www-form-urlencoded'};
  
  static Future<dynamic> post({required String body, Map<String, String> headers = defaultHeaders }) async {
    final url = Uri.parse(baseUrl);
    if (kDebugMode) {
      print(body);
    }
    final response = await http.post(url, body: body, headers: headers);
    return _handleResponse(response);
  }

  static dynamic _handleResponse(http.Response response) {
    if (kDebugMode) {
      print(response.body);
    }
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error: ${response.statusCode}, ${response.body}');
    }
  }

}