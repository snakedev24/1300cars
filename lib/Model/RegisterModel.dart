class RegisterModel {
  int? statusCode;
  String? message;
  Data? data;

  RegisterModel({this.statusCode, this.message, this.data});

  RegisterModel.fromJson(Map<String, dynamic> json) {
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
  bool? isEmailVerify;
  int? userId;
  String? email;
  String? name;
  String? role;
  bool? isVerify;

  Data(
      {this.access,
        this.refresh,
        this.isEmailVerify,
        this.userId,
        this.email,
        this.name,
        this.role,
        this.isVerify});

  Data.fromJson(Map<String, dynamic> json) {
    access = json['access'];
    refresh = json['refresh'];
    isEmailVerify = json['is_email_verify'];
    userId = json['user_id'];
    email = json['email'];
    name = json['name'];
    role = json['role'];
    isVerify = json['is_verify'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access'] = this.access;
    data['refresh'] = this.refresh;
    data['is_email_verify'] = this.isEmailVerify;
    data['user_id'] = this.userId;
    data['email'] = this.email;
    data['name'] = this.name;
    data['role'] = this.role;
    data['is_verify'] = this.isVerify;
    return data;
  }
}


