class HttpsResponse {
  bool success;
  String message;
  dynamic data;

  HttpsResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory HttpsResponse.fromJson(Map<String, dynamic> json) {
    return HttpsResponse(
      success: json['success'],
      message: json['message'],
      data: json['data'],
    );
  }


}