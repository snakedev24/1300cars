import 'package:get/get_rx/src/rx_types/rx_types.dart';


class CardRegisterModel {
  int? statusCode;
  String? message;
  CardRegisterData? data;

  CardRegisterModel({this.statusCode, this.message, this.data});

  CardRegisterModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? new CardRegisterData.fromJson(json['data']) : null;
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

class CardRegisterData {
  int? id;
  String? cardName;
  String? cardNumber;
  String? cardExpire;
  int? cvvNumber;
  bool? isDefault;
  int? user;
  RxBool isChecked = false.obs;

  CardRegisterData(
      {this.id,
        this.cardName,
        this.cardNumber,
        this.cardExpire,
        this.cvvNumber,
        this.isDefault,
        this.user});

  CardRegisterData.fromJson(Map<String, dynamic> json) {
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