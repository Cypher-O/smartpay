class VerifyEmailOtp {
  final bool status;
  final String message;
  final VerifyEmailOtpData data;

  VerifyEmailOtp({
    required this.status,
    required this.message,
    required this.data,
  });

  factory VerifyEmailOtp.fromJson(Map<String, dynamic> json) {
    return VerifyEmailOtp(
      status: json['status'],
      message: json['message'],
      data: VerifyEmailOtpData.fromJson(json['data']),
    );
  }
}

class VerifyEmailOtpData {
  final String email;
  // final String token;

  VerifyEmailOtpData({
    required this.email,
    // required this.token,
  });

  factory VerifyEmailOtpData.fromJson(Map<String, dynamic> json) {
    return VerifyEmailOtpData(
      email: json['email'],
      // token: json['token'],
    );
  }
}
