class Permission {
  int idPermission;
  String permission;

  Permission({required this.idPermission, required this.permission});

  factory Permission.fromJson(Map<String, dynamic> json){
    return Permission(
      idPermission: json['Id_Permiso'],
      permission: json['Permiso']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'idPermission': idPermission,
      'permission': permission
    };
  }

   factory Permission.fromJsonSql(Map<String, dynamic> json){
    return Permission(
      idPermission: json['id_permission'],
      permission: json['permission']
    );
  }
}