import 'package:servicios/core/services/sql_services.dart';
import 'package:sqflite/sqflite.dart';

class SesionSqlService{
  Future<bool> hasSession()async{
    Database db = await SqlServices.opendb();
    return (await db.query('sesion')).isNotEmpty;
  }
}