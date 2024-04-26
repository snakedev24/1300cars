class DeleteAccount {
  int? successCode;
  String? message;

  DeleteAccount({this.successCode, this.message});

  DeleteAccount.fromJson(Map<String, dynamic> json) {
    successCode = json['success_code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success_code'] = this.successCode;
    data['message'] = this.message;
    return data;
  }
}