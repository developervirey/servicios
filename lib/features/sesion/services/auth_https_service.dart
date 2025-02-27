import 'dart:convert';

import 'package:servicios/core/models/auth.dart';
import 'package:servicios/core/services/https_services.dart';

class AuthHttpsService {
  static Future<Auth?> login({required String userName, required String password}) async {
    final response = await HttpsServices.post(
      body: jsonEncode({
        'funcion': 1,
        'parametros': {
          'usuario': userName,
          'password': password
        }
      })
    );
    return response['Success'] ? Auth.fromJson(response['Sesion']) : null;
  }


}