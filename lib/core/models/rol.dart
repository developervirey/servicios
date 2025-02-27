class Rol{
  int idRole;
  String role;

  Rol({required this.idRole, required this.role});

  factory Rol.fromJson(Map<String, dynamic> json){
    return Rol(
      idRole: json['Id_Rol'],
      role: json['Rol'],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'idRole': idRole,
      'role': role,
    };
  }

  factory Rol.fromJsonSql(Map<String, dynamic> json){
    return Rol(
      idRole: json['idRole'],
      role: json['role'],
    );
  }
}