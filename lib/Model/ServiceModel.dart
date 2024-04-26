import 'package:get/get_rx/src/rx_types/rx_types.dart';

class ServiceModel {
  int? status;
  List<ServiceData>? data;

  ServiceModel({this.status, this.data});

  ServiceModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <ServiceData>[];
      json['data'].forEach((v) {
        data!.add(new ServiceData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ServiceData {
  int? id;
  String? name;
  String? serviceImage;
  RxBool? checkSelect=false.obs;

  ServiceData({this.id, this.name, this.serviceImage});

  ServiceData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    serviceImage = json['service_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['service_image'] = this.serviceImage;
    return data;
  }
}


