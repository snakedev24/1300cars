class ChangeCardStatusModel {
  int? statusCode;
  ChangeCardStatusData? data;

  ChangeCardStatusModel({this.statusCode, this.data});

  ChangeCardStatusModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    data = json['data'] != null ? new ChangeCardStatusData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ChangeCardStatusData {
  int? id;
  String? cardName;
  String? cardNumber;
  String? cardExpire;
  int? cvvNumber;
  bool? isDefault;
  int? user;

  ChangeCardStatusData(
      {this.id,
        this.cardName,
        this.cardNumber,
        this.cardExpire,
        this.cvvNumber,
        this.isDefault,
        this.user});

  ChangeCardStatusData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cardName = json['card_name'];
    cardNumber = json['card_number'];
    cardExpire = json['card_expire'];
    cvvNumber = json['cvv_number'];
    isDefault = json['is_default'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['card_name'] = this.cardName;
    data['card_number'] = this.cardNumber;
    data['card_expire'] = this.cardExpire;
    data['cvv_number'] = this.cvvNumber;
    data['is_default'] = this.isDefault;
    data['user'] = this.user;
    return data;
  }
}