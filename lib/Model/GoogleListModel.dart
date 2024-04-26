class GoogleListModel{
  int? statusCode;
  bool? isGoogle;
  List<GoogleData>? data;

  GoogleListModel({this.statusCode, this.isGoogle, this.data});

  GoogleListModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    isGoogle = json['is_google'];
    if (json['data'] != null) {
      data = <GoogleData>[];
      json['data'].forEach((v) {
        data!.add(new GoogleData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['is_google'] = this.isGoogle;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GoogleData {
  Geometry? geometry;
  String? name;
  String? placeId;
  List<String>? types;
  int? ratings;
  String? vicinity;

  GoogleData(
      {this.geometry,
        this.name,
        this.placeId,
        this.types,
        this.ratings,
        this.vicinity});

  GoogleData.fromJson(Map<String, dynamic> json) {
    geometry = json['geometry'] != null
        ? new Geometry.fromJson(json['geometry'])
        : null;
    name = json['name'];
    placeId = json['place_id'];
    types = json['types'].cast<String>();
    ratings = json['ratings'];
    vicinity = json['vicinity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.geometry != null) {
      data['geometry'] = this.geometry!.toJson();
    }
    data['name'] = this.name;
    data['place_id'] = this.placeId;
    data['types'] = this.types;
    data['ratings'] = this.ratings;
    data['vicinity'] = this.vicinity;
    return data;
  }
}

class Geometry {
  Location? location;
  Viewport? viewport;

  Geometry({this.location, this.viewport});

  Geometry.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    viewport = json['viewport'] != null
        ? new Viewport.fromJson(json['viewport'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    if (this.viewport != null) {
      data['viewport'] = this.viewport!.toJson();
    }
    return data;
  }
}

class Location {
  dynamic lat;
  dynamic lng;

  Location({this.lat, this.lng});

  Location.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}

class Viewport {
  Location? northeast;
  Location? southwest;

  Viewport({this.northeast, this.southwest});

  Viewport.fromJson(Map<String, dynamic> json) {
    northeast = json['northeast'] != null
        ? new Location.fromJson(json['northeast'])
        : null;
    southwest = json['southwest'] != null
        ? new Location.fromJson(json['southwest'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.northeast != null) {
      data['northeast'] = this.northeast!.toJson();
    }
    if (this.southwest != null) {
      data['southwest'] = this.southwest!.toJson();
    }
    return data;
  }
}