import 'package:altor_assignment/services/kUrls.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class RestApi{

  KUrls kUrl = KUrls();

  Future<http.Response> getData() async {
    try {
      final response = await http.get(
        Uri.parse(kUrl.apiUrls),
        headers: <String, String>{
          'content-type': "application/json",
        },
      );
      if (kDebugMode) {
        print(response.body);
      }
      return response;
    } catch (e) {
      rethrow;
    }
  }
}