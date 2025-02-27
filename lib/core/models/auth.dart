import 'package:servicios/core/models/catalogs.dart';
import 'package:servicios/core/models/permission.dart';

class Auth{
  int idUser;
  String name;
  String userName;
  String role;
  int idRole;
  List<Permission> permissions;
  Catalogs catalogs;


  Auth({required this.idUser, required this.name, required this.userName, required this.role, required this.idRole, required this.permissions, required this.catalogs});

  factory Auth.fromJson(Map<String, dynamic> json){
    return Auth(
      idUser: json['Id_Usuario'],
      name: json['Nombre_Completo'],
      userName: json['Usuario'],
      role: json['Rol'],
      idRole: json['Id_Rol'],
      permissions: List<Permission>.from(json['Permisos'].map((permission) => Permission.fromJson(permission)).toList()),
      catalogs: Catalogs.fromJson(json)
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'idUser': idUser,
      'name': name,
      'userName': userName,
      'role': role,
      'idRole': idRole
    };
  }

  factory Auth.fromJsonSql(Map<String, dynamic> json, List<Map<String, dynamic>> jsonRoles, List<Map<String, dynamic>> jsonStatuses){
    return Auth(
      idUser: json['idUser'],
      name: json['name'],
      userName: json['userName'],
      role: json['role'],
      idRole: json['idRole'],
      permissions: [],
      catalogs: Catalogs.fromJsonSql(jsonRoles, jsonStatuses)
    );
  }

}