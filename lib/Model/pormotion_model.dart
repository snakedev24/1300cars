class PromotionModel {
  int? statusCode;
  List<Data>? data;

  PromotionModel({this.statusCode, this.data});

  PromotionModel.fromJson(Map<String, dynamic> json) {
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
  String? title;
  String? extension;
  String? file;

  Data({this.id, this.title, this.extension, this.file});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    extension = json['extension'];
    file = json['file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['extension'] = this.extension;
    data['file'] = this.file;
    return data;
  }
}

