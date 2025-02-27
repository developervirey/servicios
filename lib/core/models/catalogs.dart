import 'package:servicios/core/models/rol.dart';
import 'package:servicios/core/models/user_status.dart';

class Catalogs {
  List<Rol> roles;
  List<UserStatus> userStatuses;

  Catalogs({required this.roles, required this.userStatuses});

  factory Catalogs.fromJson(Map<String, dynamic> json){
    return Catalogs(
      roles: List<Rol>.from(json['Roles'].map((role) => Rol.fromJson(role)).toList()),
      userStatuses: List<UserStatus>.from(json['Estados'].map((userStatus) => UserStatus.fromJson(userStatus)).toList())
    );
  }

  Map<String, dynamic> toJsonRoles(){
    return {
      'roles': roles.map((role) => role.toJson()).toList()
    };
  }

    Map<String, dynamic> toJsonUserStatuses(){
    return {
      'userStatuses': userStatuses.map((userStatus) => userStatus.toJson()).toList()
    };
  }

  factory Catalogs.fromJsonSql(List<Map<String, dynamic>> jsonRole, List<Map<String, dynamic>> jsonUserStatus){
    return Catalogs(
      roles: List<Rol>.from(jsonRole.map((role) => Rol.fromJsonSql(role)).toList()),
      userStatuses: List<UserStatus>.from(jsonUserStatus.map((userStatus) => UserStatus.fromJsonSql(userStatus)).toList())
    );
  }

}