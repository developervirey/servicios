import 'package:flutter/foundation.dart';
import 'package:servicios/core/models/https_response.dart';
import 'package:servicios/core/models/rol.dart';
import 'package:servicios/core/models/user_status.dart';
import 'package:servicios/core/navigator/routes.dart';
import 'package:servicios/features/users/models/user.dart';
import 'package:servicios/features/users/services/users_https_service.dart';
import 'package:servicios/main.dart';

class UserProvider extends ChangeNotifier {
  bool isLoading = false;
  List<User> users = [];
  User? selectedUser;
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

  void updateActiveUser({required int idUser,required int idUserUpdated, required int idStatus, required Future<void> Function(bool,String) showDialog}) async {
    isLoading = true;
    notifyListeners();

    HttpsResponse response = await UsersHttpsService().updateActiveUser(
      idUser: idUser,
      idUserUpdated: idUserUpdated,
      idStatus: idStatus,
      showDialog: showDialog,
    );

    if(response.success) {
      // update the user status
      users = users.map((user) {
        if(user.idUser == idUserUpdated) {
          user.idStatus = idStatus;
        }
        return user;
      }).toList();
      notifyListeners();
    }

    isLoading = false;
    notifyListeners();
  }

  // this method is used to insert or update a user
  void insUser({required int idUser, required User user, required Future<void> Function(bool,String) showDialog}) async {
    isLoading = true;
    notifyListeners();

    try{
      HttpsResponse response = await UsersHttpsService().insUser(
        idUser: idUser,
        user: user,
        showDialog: showDialog,
      );

      if(response.success) {
        // if the user already exists, update it
        if(user.idUser != 0) {
          users = users.map((u) {
            if(u.idUser == user.idUser) {
              u = user;
            }
            return u;
          }).toList();
        } else {
          // if the user does not exist, add it
          users.add(user);
          notifyListeners();
        }
      }
    }catch(e){
      if(kDebugMode){
        print(e);
      }
    }
   
    isLoading = false;
    notifyListeners();
  }

  // this method is used to delete a user
  void delUser({required int idUser, required int idUserDeleted ,required Future<void> Function(bool,String) showDialog}) async {
    isLoading = true;
    notifyListeners();

    HttpsResponse response = await UsersHttpsService().delUser(
      idUser: idUser,
      idUserDeleted: idUserDeleted,
      showDialog: showDialog, 
    );

    if(response.success) {
      // remove the user from the list
      users.removeWhere((user) => user.idUser == idUser);
      notifyListeners();
    }

    isLoading = false;  
    notifyListeners();
  }
  void goToEditUser({required User user}) {
    selectedUser = user;
    notifyListeners();
    navigatorKey.currentState!.pushNamed(Routes.editUser);
  }

  // this method is used to change the password
  void goToChangePassword({required User user}) {
    selectedUser = user;
    notifyListeners();
    navigatorKey.currentState!.pushNamed(Routes.changePassword);
  }
}