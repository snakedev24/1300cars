class GetProfileModel {
  int? statusCode;
  Data? data;

  GetProfileModel({this.statusCode, this.data});

  GetProfileModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  String? name;
  String? address;
  String? phoneNumber;
  String? uploadImage;
  String? email;

  Data(
      {this.name,
        this.address,
        this.phoneNumber,
        this.uploadImage,
        this.email});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    address = json['address'];
    phoneNumber = json['phone_number'];
    uploadImage = json['upload_image'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['address'] = this.address;
    data['phone_number'] = this.phoneNumber;
    data['upload_image'] = this.uploadImage;
    data['email'] = this.email;
    return data;
  }
}


