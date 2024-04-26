import 'package:get/get_rx/src/rx_types/rx_types.dart';

class CardListModel {
  int? statusCode;
  List<Data>? data;

  CardListModel({this.statusCode, this.data});

  CardListModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? cardName;
  String? cardNumber;
  String? cardExpire;
  int? cvvNumber;
  bool? isDefault;
  int? user;
  RxBool isChecked = false.obs;

  Data(
      {this.id,
        this.cardName,
        this.cardNumber,
        this.cardExpire,
        this.cvvNumber,
        this.isDefault,
        this.user});

  Data.fromJson(Map<String, dynamic> json) {
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


