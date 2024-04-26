class LoginModel {
  int? statusCode;
  String? message;
  Data? data;

  LoginModel({this.statusCode, this.message, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? access;
  String? refresh;
  int? userId;
  String? email;
  String? name;
  bool? isEmailVerify;
  String? role;
  bool? card;
  String? image;
  bool? socialLogin;
  String? isEmergency;

  Data(
      {this.access,
        this.refresh,
        this.userId,
        this.email,
        this.name,
        this.isEmailVerify,
        this.role,
        this.card,
        this.image,
        this.socialLogin,
        this.isEmergency});

  Data.fromJson(Map<String, dynamic> json) {
    access = json['access'];
    refresh = json['refresh'];
    userId = json['user_id'];
    email = json['email'];
    name = json['name'];
    isEmailVerify = json['is_email_verify'];
    role = json['role'];
    card = json['card'];
    image = json['image'];
    socialLogin = json['social_login'];
    isEmergency = json['is_emergency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access'] = this.access;
    data['refresh'] = this.refresh;
    data['user_id'] = this.userId;
    data['email'] = this.email;
    data['name'] = this.name;
    data['is_email_verify'] = this.isEmailVerify;
    data['role'] = this.role;
    data['card'] = this.card;
    data['image'] = this.image;
    data['social_login'] = this.socialLogin;
    data['is_emergency'] = this.isEmergency;
    return data;
  }
}