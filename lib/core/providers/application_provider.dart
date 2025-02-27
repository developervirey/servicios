import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:servicios/core/navigator/routes.dart';
import 'package:servicios/main.dart';

import 'sesion.dart';

class ApplicationProvider extends ChangeNotifier{
  final Sesion sesion = Sesion();
  bool isLoading = false;

  Future<void> hasSesionController() async{
    isLoading = true;
    notifyListeners();
    sesion.hasSesion().then((value){
      isLoading = false;
      notifyListeners();
      navigatorKey.currentState!.pushReplacementNamed(
        value?Routes.home: Routes.sesion,
      );
    });

  }

 Future<void> handleLogin({required String userName, required String password}) async {
  isLoading = true;
  notifyListeners();

  try {
    bool isLoggedIn = await sesion.login(userName: userName, password: password);
    
    isLoading = false;
    notifyListeners();
    
    if (isLoggedIn) {
      navigatorKey.currentState!.pushReplacementNamed(Routes.home);
    }
  } catch (e) {
    isLoading = false;
    notifyListeners();
  }
}

  void logout() {}

}