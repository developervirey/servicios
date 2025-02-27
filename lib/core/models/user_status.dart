class UserStatus {
  int idStatus;
  String status;

  UserStatus({required this.idStatus, required this.status});

  factory UserStatus.fromJson(Map<String, dynamic> json) {
    return UserStatus(
      idStatus: json['Id_Estado'],
      status: json['Nombre_Estado'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idStatus': idStatus,
      'status': status,
    };
  }

  factory UserStatus.fromJsonSql(Map<String, dynamic> json) {
    return UserStatus(
      idStatus: json['idStatus'],
      status: json['status'],
    );
  }

}