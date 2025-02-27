import 'package:servicios/core/models/auth.dart';
import 'package:servicios/core/services/sql_services.dart';
import 'package:servicios/features/sesion/services/auth_https_service.dart';
import 'package:servicios/features/sesion/services/auth_sql_service.dart';

class Sesion{
  Auth? auth;

  Future<bool> hasSesion()async{
    auth = await AuthSqlService.hasSession();
    if(auth != null){
      auth?.catalogs = await SqlServices.getCatalogs();
      return true;
    }
    return false;
  }
  
  //Login
  Future<bool> login({required String userName, required String password}) async {
  try {
    auth = await AuthHttpsService.login(userName: userName, password: password);
    if (auth != null) {
      await AuthSqlService.saveSession(auth!);
      await AuthSqlService.savePermissions(auth!.permissions.map((permission) => permission.toJson()).toList());
      await SqlServices.saveCatalogs(auth!.catalogs);
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}

  //logout
}