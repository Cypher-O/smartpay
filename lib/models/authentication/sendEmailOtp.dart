class EmailOtp {
  final bool status;
  final String message;
  final Data data;

  EmailOtp({
    required this.status,
    required this.message,
    required this.data,
  });

  factory EmailOtp.fromJson(Map<String, dynamic> json) {
    return EmailOtp(
      status: json['status'],
      message: json['message'],
      data: Data.fromJson(json['data']),
    );
  }
}

class Data {
  final String token;

  Data({
    required this.token,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      token: json['token'],
    );
  }
}
