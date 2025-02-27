import 'package:servicios/core/models/catalogs.dart';
import 'package:servicios/core/models/rol.dart';
import 'package:servicios/core/models/user_status.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlServices{
  static Future<Database> opendb() async {
    final conn = openDatabase(
        join(await getDatabasesPath(), 'data.db'),
        onCreate: (db, version) async {
           await db.execute(
          '''CREATE TABLE Sesion(
                idUser INTEGER PRIMARY KEY NOT NULL,
                name TEXT,
                userName  TEXT,
                role TEXT,
                idRole INTEGER)
          ''',
        );
        await db.execute(
          '''CREATE TABLE Permissions(
                idPermission INTEGER PRIMARY KEY NOT NULL,
                permission TEXT)
          ''',
        );
        await db.execute(
          '''CREATE TABLE User_Statuses(
                idStatus INTEGER PRIMARY KEY NOT NULL,
                status TEXT)
          ''',
        );
        await db.execute(
          '''CREATE TABLE Roles(
                idRole INTEGER PRIMARY KEY NOT NULL,
                role TEXT)
          ''',
        );

    
      },
      onUpgrade: (db, oldVersion, newVersion) async {
       
      },
      version: 1,
    );
    return conn;
  }

  static Future<void> closeDb() async {
    final db = await opendb();
    await db.close();
  }

  static saveCatalogs(Catalogs catalogs) async {
    final db = await opendb();
    await db.transaction((txn) async {
      for (var role in catalogs.roles) {
        await txn.insert('Roles', role.toJson());
      }
      for (var status in catalogs.userStatuses) {
        await txn.insert('User_Statuses', status.toJson());
      }
    });
  }

  static Future<Catalogs> getCatalogs() async {
    final db = await opendb();
    return Catalogs(
      roles: List<Rol>.from((await db.query('Roles')).map((value) => Rol.fromJsonSql(value))),
      userStatuses: List<UserStatus>.from((await db.query('User_Statuses')).map((value)=> UserStatus.fromJsonSql(value))),
    );
  }



}