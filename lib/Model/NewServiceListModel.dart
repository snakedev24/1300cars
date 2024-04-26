import 'package:get/get_rx/src/rx_types/rx_types.dart';

class ServiceListModel {
  int? statusCode;
  int? currentPage;
  String? next;
  dynamic previous;
  int? totalGoogleData;
  int? totalDbData;
  int? totalData;
  int? totalPages;
  List<Data>? data;

  ServiceListModel({this.statusCode,
    this.currentPage,
    this.next,
    this.previous,
    this.totalGoogleData,
    this.totalDbData,
    this.totalData,
    this.totalPages,
    this.data});

  ServiceListModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    currentPage = json['current_page'];
    next = json['next'];
    previous = json['previous'];
    totalGoogleData = json['total_google_data'];
    totalDbData = json['total_db_data'];
    totalData = json['total_data'];
    totalPages = json['total_pages'];
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
    data['current_page'] = this.currentPage;
    data['next'] = this.next;
    data['previous'] = this.previous;
    data['total_google_data'] = this.totalGoogleData;
    data['total_db_data'] = this.totalDbData;
    data['total_data'] = this.totalData;
    data['total_pages'] = this.totalPages;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class Data {
  int? id;
  String? businessName;
  dynamic startTime;
  dynamic endTime;
  String? location;
  dynamic contactMobile;
  dynamic image;
  String? name;
  double? latitude;
  double? longitude;
  int? user;
  dynamic isFav;
  dynamic ratings;
  bool? isGoogle;
  String? placeId;
  MemberShipInfo? memberShipInfo;
  List<DiscountCoupons>? discountCoupons;
  List<ServicePrice>? servicePrice;
  List<String>? types;
  RxBool? heartClick=false.obs;

  Data(
      {this.id,

        this.businessName,
        this.startTime,
        this.endTime,
        this.location,
        this.contactMobile,
        this.image,
        this.name,
        this.latitude,
        this.longitude,
        this.user,
        this.isFav,
        this.ratings,
        this.isGoogle,
        this.placeId,
        this.memberShipInfo,
        this.discountCoupons,
        this.servicePrice,
        this.types
      });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    // businessNo = json['business_no'];
    businessName = json['business_name'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    location = json['location'];
    contactMobile = json['contact_mobile'];
    // contactHotline = json['contact_hotline'];
    image = json['image'];
    name = json['name'];
    // isVerify = json['is_verify'];
    // isProfileComplete = json['is_profile_complete'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    // createdAt = json['created_at'];
    placeId = json['place_id'];
    user = json['user'];
    isFav = json['is_fav'];
    ratings = json['ratings'];
    isGoogle = json['is_google'];



    memberShipInfo = json['memberShipInfo'] != null
        ? new MemberShipInfo.fromJson(json['memberShipInfo'])
        : null;




    if (json['discount_coupons'] != null) {
      discountCoupons = <DiscountCoupons>[];
      json['discount_coupons'].forEach((v) {
        discountCoupons!.add(new DiscountCoupons.fromJson(v));
      });
    }


    if (json['Service_price'] != null) {
      servicePrice = (json['Service_price'] as List)
          .map((item) => ServicePrice.fromJson(item))
          .toList();
    } else {
      servicePrice = []; // Set it as an empty list if it's missing.
    }
    if (json.containsKey('types')) {
      types = (json['types'] as List)?.cast<String>();
    } else {
      types = []; // Set it as an empty list if it's missing.
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['business_name'] = this.businessName;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['location'] = this.location;
    data['contact_mobile'] = this.contactMobile;
    data['image'] = this.image;
    data['name'] = this.name;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['user'] = this.user;
    data['is_fav'] = this.isFav;
    data['ratings'] = this.ratings;
    data['is_google'] = this.isGoogle;
    if (this.discountCoupons != null) {
      data['discount_coupons'] =
          this.discountCoupons!.map((v) => v.toJson()).toList();
    }
    if (this.memberShipInfo != null) {
      data['memberShipInfo'] = this.memberShipInfo!.toJson();
    }
    if (this.servicePrice != null) {
      data['Service_price'] =
          this.servicePrice!.map((v) => v.toJson()).toList();
    }
    data['place_id'] = this.placeId;
    data['types'] = this.types;
    return data;
  }
}
class DiscountCoupons {
  String? discountToken;
  String? couponName;
  int? discount;
  int? maximumDiscount;
  String? startDate;
  String? expiryDate;
  int? provider;
  RxBool isChecked = false.obs;

  DiscountCoupons(
      {this.discountToken,
        this.couponName,
        this.discount,
        this.maximumDiscount,
        this.startDate,
        this.expiryDate,
        this.provider});

  DiscountCoupons.fromJson(Map<String, dynamic> json) {
    discountToken = json['discount_token'];
    couponName = json['coupon_name'];
    discount = json['discount'];
    maximumDiscount = json['maximum_discount'];
    startDate = json['start_date'];
    expiryDate = json['expiry_date'];
    provider = json['provider'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['discount_token'] = this.discountToken;
    data['coupon_name'] = this.couponName;
    data['discount'] = this.discount;
    data['maximum_discount'] = this.maximumDiscount;
    data['start_date'] = this.startDate;
    data['expiry_date'] = this.expiryDate;
    data['provider'] = this.provider;
    return data;
  }
}



// class DiscountCoupons {
//   String? discountToken;
//   String? couponName;
//   dynamic discount;
//   String? startDate;
//   String? expiryDate;
//   int? provider;
//
//
//   DiscountCoupons(
//       {this.discountToken,
//         this.couponName,
//         this.discount,
//         this.startDate,
//         this.expiryDate,
//         this.provider});
//
//   DiscountCoupons.fromJson(Map<String, dynamic> json) {
//     discountToken = json['discount_token'];
//     couponName = json['coupon_name'];
//     discount = json['discount'];
//     startDate = json['start_date'];
//     expiryDate = json['expiry_date'];
//     provider = json['provider'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['discount_token'] = this.discountToken;
//     data['coupon_name'] = this.couponName;
//     data['discount'] = this.discount;
//     data['start_date'] = this.startDate;
//     data['expiry_date'] = this.expiryDate;
//     data['provider'] = this.provider;
//     return data;
//   }
// }



class ServicePrice {
  int? id;
  dynamic? price;
  int? provider;
  String? service;
  int? serviceId;
  RxBool isChecked = false.obs;

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

class MemberShipInfo {
  int? id;
  String? subcriptionType;
  String? membershipStart;
  String? membershipEnd;
  String? planAmount;
  String? planMenu;
  String? createdAt;
  int? provider;
  String? providerName;

  MemberShipInfo(
      {this.id,
        this.subcriptionType,
        this.membershipStart,
        this.membershipEnd,
        this.planAmount,
        this.planMenu,
        this.createdAt,
        this.provider,
        this.providerName});

  MemberShipInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subcriptionType = json['subcription_type'];
    membershipStart = json['membership_start'];
    membershipEnd = json['membership_end'];
    planAmount = json['plan_amount'];
    planMenu = json['plan_menu'];
    createdAt = json['created_at'];
    provider = json['provider'];
    providerName = json['provider_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['subcription_type'] = this.subcriptionType;
    data['membership_start'] = this.membershipStart;
    data['membership_end'] = this.membershipEnd;
    data['plan_amount'] = this.planAmount;
    data['plan_menu'] = this.planMenu;
    data['created_at'] = this.createdAt;
    data['provider'] = this.provider;
    data['provider_name'] = this.providerName;
    return data;
  }
}
