class AddDefaultModel {
  int? statusCode;
  AddDefaultData? data;

  AddDefaultModel({this.statusCode, this.data});

  AddDefaultModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    data = json['data'] != null ? new AddDefaultData.fromJson(json['data']) : null;
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

class AddDefaultData {
  int? id;
  String? name;
  String? phoneNumber;
  bool? isDefault;
  int? user;

  AddDefaultData({this.id, this.name, this.phoneNumber, this.isDefault, this.user});

  AddDefaultData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phoneNumber = json['phone_number'];
    isDefault = json['is_default'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone_number'] = this.phoneNumber;
    data['is_default'] = this.isDefault;
    data['user'] = this.user;
    return data;
  }
}