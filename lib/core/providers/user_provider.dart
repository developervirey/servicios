import 'package:flutter/foundation.dart';
import 'package:servicios/core/models/rol.dart';
import 'package:servicios/core/models/user_status.dart';
import 'package:servicios/features/users/models/user.dart';
import 'package:servicios/features/users/services/users_https_service.dart';

class UserProvider extends ChangeNotifier {
  List<User> users = [];
  User? user;
  Rol? selectedRolFilter;
  UserStatus? selectedUserStatusFilter;
  int countTechnicians = 0;
  int countAdministrators = 0;

  // this method is used to download users
  void downloadingUsers({required int idUser, String name = ''}) async {
    try {
      users = await UsersHttpsService().downloadUsers(idUser: idUser, name: '', active: selectedUserStatusFilter?.idStatus ?? 1);
      countTechnicians = users.where((element) => element.role == 'Técnico').length;
      countAdministrators = users.where((element) => element.role == 'Administrador').length;
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  // this method is used to select a user status
  setUserStatus(UserStatus? userStatus) {
    selectedUserStatusFilter = userStatus;
    notifyListeners();
  }

  // this method is used to select a user role
  setUserRol(Rol? rol) {
    selectedRolFilter = rol;
    notifyListeners();
  }
}