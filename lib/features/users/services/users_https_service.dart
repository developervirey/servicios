
import 'dart:convert';

import 'package:servicios/features/users/models/user.dart';

import '../../../core/services/https_services.dart';

class UsersHttpsService {
  
  Future<List<User>> downloadUsers({required int idUser, required String name, required int active}) async {
    try {
      final response = await HttpsServices.post(
        body: jsonEncode({
          'funcion': 10,
          'parametros': {
            'id_usuario_consulta': idUser,
            'nombre': name,
            'activo':active
          }
        })
      );
      return response['Success'] ? (response['Usuarios'] as List).map((user) => User.fromJson(user)).toList() : [];
    } catch (e) {
      throw Exception('Error downloading users');
    }
  
  }

  Future<void> createUser() async {
    // Create user
  }

  Future<void> updateUser() async {
    // Update user
  }

  Future<void> deleteUser() async {
    // Delete user
  }
}