import 'package:flutter/foundation.dart';
import 'package:servicios/core/models/auth.dart';
import 'package:servicios/core/services/sql_services.dart';
import 'package:sqflite/sqflite.dart';

class AuthSqlService{
  static Future<Auth?> hasSession()async{
    try{
       Database db = await SqlServices.opendb();
      List<Map<String, dynamic>> sesion = await db.query('Sesion');
      if(sesion.isNotEmpty){
        return Auth.fromJsonSql(sesion.first,[],[]);
      }
    }catch(e){
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }

  static Future<bool> saveSession(Auth auth)async{
    Database db = await SqlServices.opendb();
    await db.insert('Sesion', auth.toJson());
    return true;
  }


  static Future<bool> savePermissions(List<Map<String, dynamic>> permissions) async {
    Database db = await SqlServices.opendb();
    await db.delete('Permissions');
    for (var permission in permissions) {
      await db.insert('Permissions', permission);
    }
    return true;
  }
}