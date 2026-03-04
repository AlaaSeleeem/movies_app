class RegisterResponseModel {
  final String? message;
  final String? token;

  RegisterResponseModel({this.message, this.token});

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    String? extractedToken;

    if (json['token'] is String) {
      extractedToken = json['token'];
    } else if (json['data'] is Map<String, dynamic>) {
      extractedToken = json['data']['token'];
    }

    return RegisterResponseModel(
      message: json['message'] as String?,
      token: extractedToken,
    );
  }}