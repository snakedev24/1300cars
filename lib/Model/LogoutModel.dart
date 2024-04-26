class LogoutModel {
  int? statusCode;
  String? message;

  LogoutModel({this.statusCode, this.message});

  LogoutModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    return data;
  }
}