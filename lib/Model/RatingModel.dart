class RatingModel {
  int? statusCode;
  String? message;
  Data? data;

  RatingModel({this.statusCode, this.data});

  RatingModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  int? ratings;
  String? comment;
  int? user;
  int? provider;

  Data({this.id, this.ratings, this.comment, this.user, this.provider});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ratings = json['ratings'];
    comment = json['comment'];
    user = json['user'];
    provider = json['provider'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ratings'] = this.ratings;
    data['comment'] = this.comment;
    data['user'] = this.user;
    data['provider'] = this.provider;
    return data;
  }
}