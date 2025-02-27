class User {
  int idUser;
  String user;
  String password;
  String name;
  int idStatus;
  String role;
  int idRole;


  User({ required this.idUser, required this.user, required this.password, required this.name, required this.idStatus, required this.role, required this.idRole});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      idUser: json['Id_Usuario'],
      user: json['Usuario'],
      password: '',
      name: json['Nombre_Completo'],
      idStatus: json['Activo'],
      role: json['Rol'],
      idRole: json['Id_Rol'],
    );
  }

  String getInitials() {
    return  name.substring(0, 1).toUpperCase();
  }

}