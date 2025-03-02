import 'dart:convert';

import 'package:servicios/core/models/https_response.dart';
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

  Future<HttpsResponse> updateActiveUser({required int idUser, required int idUserUpdated, required int idStatus, required Future<void> Function(bool,String) showDialog}) async {
    try {
      final response = await HttpsServices.post(
        body: jsonEncode({
          'funcion': 10,
          'parametros': {
            'id_usuario_actualiza': idUser,
            'id_usuario': idUserUpdated,
            'estado':idStatus
          }
        })
      );
      showDialog(response['Success'], response['Mensaje']);
      return HttpsResponse.fromJson(response);
    } catch (e) {
      showDialog(false, 'Error actualizando usuario');
      throw Exception('Error downloading users');
    }
  }

  Future<HttpsResponse> insUser({required int idUser, required User user, required Future<void> Function(bool,String) showDialog}) async {
    try {
      final response = await HttpsServices.post(
        body: jsonEncode({
          'funcion': 10,
          'parametros': {
            'id_usuario_crea': idUser,
            'id_usuario': user.idUser,
            'nombre_completo': user.name,
            'usuario': user.user,
            'contraseña': user.password,
            'rol': user.role,
            'estado': user.idStatus
          }
        })
      );
      showDialog(response['Success'], response['Mensaje']);
      return HttpsResponse.fromJson(response);
    } catch (e) {
      showDialog(false, 'Error insertando usuario');
      throw Exception('Error downloading users');
    }
  }

  Future<HttpsResponse> delUser({required int idUser, required int idUserDeleted, required Future<void> Function(bool,String) showDialog}) async {
    try {
      final response = await HttpsServices.post(
        body: jsonEncode({
          'funcion': 10,
          'parametros': {
            'id_usuario_elimina': idUser,
            'id_usuario': idUserDeleted
          }
        })
      );
      showDialog(response['Success'], response['Mensaje']);
      return HttpsResponse.fromJson(response);
    } catch (e) {
      showDialog(false, 'Error eliminando usuario');
      throw Exception('Error downloading users');
    }
  }

}