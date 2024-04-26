class BookServiceModel {
  int? statusCode;
  Data? data;

  BookServiceModel({this.statusCode, this.data});

  BookServiceModel.fromJson(Map<String, dynamic> json) {
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
  String? id;
  String? name;
  String? phoneNumber;
  String? location;
  String? serviceDate;
  dynamic serviceTime;
  String? providerStatus;
  int? user;
  Provider? provider;
  List<Service>? service;
  dynamic totalPrice;
  String? paymentStatus;

  Data(
      {this.id,
        this.name,
        this.phoneNumber,
        this.location,
        this.serviceDate,
        this.serviceTime,
        this.providerStatus,
        this.user,
        this.provider,
        this.service,
        this.totalPrice,
        this.paymentStatus});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phoneNumber = json['phone_number'];
    location = json['location'];
    serviceDate = json['service_date'];
    serviceTime = json['service_time'];
    providerStatus = json['provider_status'];
    user = json['user'];
    provider = json['provider'] != null
        ? new Provider.fromJson(json['provider'])
        : null;
    if (json['service'] != null) {
      service = <Service>[];
      json['service'].forEach((v) {
        service!.add(new Service.fromJson(v));
      });
    }
    totalPrice = json['total_price'];
    paymentStatus = json['payment_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone_number'] = this.phoneNumber;
    data['location'] = this.location;
    data['service_date'] = this.serviceDate;
    data['service_time'] = this.serviceTime;
    data['provider_status'] = this.providerStatus;
    data['user'] = this.user;
    if (this.provider != null) {
      data['provider'] = this.provider!.toJson();
    }
    if (this.service != null) {
      data['service'] = this.service!.map((v) => v.toJson()).toList();
    }
    data['total_price'] = this.totalPrice;
    data['payment_status'] = this.paymentStatus;
    return data;
  }
}

class Provider {
  int? id;
  dynamic businessNo;
  String? businessName;
  String? startTime;
  String? endTime;
  String? location;
  List<AvailableDays>? availableDays;
  List<Service>? service;
  String? contactMobile;
  String? contactHotline;
  String? address;
  List<UploadImage>? uploadImage;
  String? name;
  bool? isVerify;
  bool? isProfileComplete;
  dynamic latitude;
  dynamic longitude;
  String? createdAt;
  int? user;
  List<ServicePrice>? servicePrice;

  Provider(
      {this.id,
        this.businessNo,
        this.businessName,
        this.startTime,
        this.endTime,
        this.location,
        this.availableDays,
        this.service,
        this.contactMobile,
        this.contactHotline,
        this.address,
        this.uploadImage,
        this.name,
        this.isVerify,
        this.isProfileComplete,
        this.latitude,
        this.longitude,
        this.createdAt,
        this.user,
        this.servicePrice});

  Provider.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    businessNo = json['business_no'];
    businessName = json['business_name'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    location = json['location'];
    if (json['available_days'] != null) {
      availableDays = <AvailableDays>[];
      json['available_days'].forEach((v) {
        availableDays!.add(new AvailableDays.fromJson(v));
      });
    }
    if (json['service'] != null) {
      service = <Service>[];
      json['service'].forEach((v) {
        service!.add(new Service.fromJson(v));
      });
    }
    contactMobile = json['contact_mobile'];
    contactHotline = json['contact_hotline'];
    address = json['address'];
    if (json['upload_image'] != null) {
      uploadImage = <UploadImage>[];
      json['upload_image'].forEach((v) {
        uploadImage!.add(new UploadImage.fromJson(v));
      });
    }
    name = json['name'];
    isVerify = json['is_verify'];
    isProfileComplete = json['is_profile_complete'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    createdAt = json['created_at'];
    user = json['user'];
    if (json['Service_price'] != null) {
      servicePrice = <ServicePrice>[];
      json['Service_price'].forEach((v) {
        servicePrice!.add(new ServicePrice.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['business_no'] = this.businessNo;
    data['business_name'] = this.businessName;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['location'] = this.location;
    if (this.availableDays != null) {
      data['available_days'] =
          this.availableDays!.map((v) => v.toJson()).toList();
    }
    if (this.service != null) {
      data['service'] = this.service!.map((v) => v.toJson()).toList();
    }
    data['contact_mobile'] = this.contactMobile;
    data['contact_hotline'] = this.contactHotline;
    data['address'] = this.address;
    if (this.uploadImage != null) {
      data['upload_image'] = this.uploadImage!.map((v) => v.toJson()).toList();
    }
    data['name'] = this.name;
    data['is_verify'] = this.isVerify;
    data['is_profile_complete'] = this.isProfileComplete;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['created_at'] = this.createdAt;
    data['user'] = this.user;
    if (this.servicePrice != null) {
      data['Service_price'] =
          this.servicePrice!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AvailableDays {
  int? id;
  String? day;

  AvailableDays({this.id, this.day});

  AvailableDays.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    day = json['day'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['day'] = this.day;
    return data;
  }
}

class Service {
  int? id;
  String? service;
  String? serviceImage;

  Service({this.id, this.service, this.serviceImage});

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    service = json['service'];
    serviceImage = json['service_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['service'] = this.service;
    data['service_image'] = this.serviceImage;
    return data;
  }
}

class UploadImage {
  int? id;
  String? image;

  UploadImage({this.id, this.image});

  UploadImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    return data;
  }
}

class ServicePrice {
  int? id;
  String? price;
  int? provider;
  String? service;
  int? serviceId;

  ServicePrice(
      {this.id, this.price, this.provider, this.service, this.serviceId});

  ServicePrice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    provider = json['provider'];
    service = json['service'];
    serviceId = json['service_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    data['provider'] = this.provider;
    data['service'] = this.service;
    data['service_id'] = this.serviceId;
    return data;
  }
}


