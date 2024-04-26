class SendImageModel {
  int? statusCode;
  MyDataItem? data;

  SendImageModel({this.statusCode, this.data});

  SendImageModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    data = json['data'] != null ? new MyDataItem.fromJson(json['data']) : null;
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

class MyDataItem {
  int? id;
  String? file;
  String? name;

  MyDataItem({this.id, this.file, this.name});

  MyDataItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    file = json['file'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['file'] = this.file;
    data['name'] = this.name;
    return data;
  }
}