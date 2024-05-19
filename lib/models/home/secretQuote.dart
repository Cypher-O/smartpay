class SecretQuoteModel {
  bool? status;
  String? message;
  SecretQuoteModelData? data;

  SecretQuoteModel({
    this.status,
    this.message,
    this.data,
  });

  factory SecretQuoteModel.fromJson(Map<String, dynamic> json) {
    return SecretQuoteModel(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? SecretQuoteModelData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class SecretQuoteModelData {
  String? secret;

  SecretQuoteModelData({
    this.secret,
  });

  factory SecretQuoteModelData.fromJson(Map<String, dynamic> json) {
    return SecretQuoteModelData(
      secret: json['secret'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['secret'] = this.secret;
    return data;
  }
}
