import 'package:flutter/material.dart';
import 'package:servicios/features/home/pages/home_page.dart';
import 'package:servicios/features/sesion/pages/sesion_page.dart';
import 'package:servicios/features/splash/pages/splash_page.dart';
import 'package:servicios/features/users/pages/change_password_page.dart';
import 'package:servicios/features/users/pages/edit_user_page.dart';

class Routes {
  static const String splash = '/splash';
  static const String sesion = '/sesion';
  static const String home = '/home';
  static const String changePassword = '/changePassword';
  static const String editUser = '/editUser';
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (builder) => SplashPage());
      case sesion:
        return MaterialPageRoute(builder: (builder) => SesionPage());
      case home:
        return MaterialPageRoute(builder: (builder) => HomePage());
      case changePassword:
         return MaterialPageRoute(builder: (builder) => ChangePasswordPage());
         case editUser:
          return MaterialPageRoute(builder: (builder) => EditUserPage());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text('Error')),
          body: const Center(child: Text('Ruta no encontrada')),
        );
      },
    );
  }
}
