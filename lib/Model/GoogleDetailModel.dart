class GoogleDetailModel {
  int? statusCode;
  List<Data>? googleDetailData;

  GoogleDetailModel({this.statusCode, this.googleDetailData});

  GoogleDetailModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    if (json['data'] != null) {
      googleDetailData = <Data>[];
      json['data'].forEach((v) {
        googleDetailData!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    if (this.googleDetailData != null) {
      data['data'] = this.googleDetailData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {

  Result? result;
  // String? status;
  // List<String>? destinationAddresses;
  // List<String>? originAddresses;
  List<Rows>? rows;

  Data(
      {

        this.result,
        this.rows});

  Data.fromJson(Map<String, dynamic> json) {

    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
    if (json['rows'] != null) {
      rows = <Rows>[];
      json['rows'].forEach((v) {
        rows!.add(new Rows.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    if (this.rows != null) {
      data['rows'] = this.rows!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  CurrentOpeningHours? currentOpeningHours;
  String? formattedPhoneNumber;
  CurrentOpeningHours? openingHours;
  dynamic rating;
  String? reference;
  dynamic userRatingsTotal;

  Result(
      {
        this.formattedPhoneNumber,
        this.openingHours,
        this.rating,
        this.reference,
        this.userRatingsTotal,
      });

  Result.fromJson(Map<String, dynamic> json) {
    formattedPhoneNumber = json['formatted_phone_number'];
    openingHours = json['opening_hours'] != null
        ? new CurrentOpeningHours.fromJson(json['opening_hours'])
        : null;
    rating = json['rating'];
    reference = json['reference'];
    userRatingsTotal = json['user_ratings_total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['formatted_phone_number'] = this.formattedPhoneNumber;
    if (this.openingHours != null) {
      data['opening_hours'] = this.openingHours!.toJson();
    }
    data['rating'] = this.rating;
    data['reference'] = this.reference;
    data['user_ratings_total'] = this.userRatingsTotal;
    return data;
  }
}


class CurrentOpeningHours {
  bool? openNow;
  List<Periods>? periods;
  List<String>? weekdayText;

  CurrentOpeningHours({this.openNow, this.periods, this.weekdayText});

  CurrentOpeningHours.fromJson(Map<String, dynamic> json) {
    openNow = json['open_now'];
    if (json['periods'] != null) {
      periods = <Periods>[];
      json['periods'].forEach((v) {
        periods!.add(new Periods.fromJson(v));
      });
    }
    weekdayText = json['weekday_text'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['open_now'] = this.openNow;
    if (this.periods != null) {
      data['periods'] = this.periods!.map((v) => v.toJson()).toList();
    }
    data['weekday_text'] = this.weekdayText;
    return data;
  }
}

class Periods {
  Close? close;
  Close? open;

  Periods({this.close, this.open});

  Periods.fromJson(Map<String, dynamic> json) {
    close = json['close'] != null ? new Close.fromJson(json['close']) : null;
    open = json['open'] != null ? new Close.fromJson(json['open']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.close != null) {
      data['close'] = this.close!.toJson();
    }
    if (this.open != null) {
      data['open'] = this.open!.toJson();
    }
    return data;
  }
}

class Close {
  String? date;
  int? day;
  String? time;
  bool? truncated;

  Close({this.date, this.day, this.time, this.truncated});

  Close.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    day = json['day'];
    time = json['time'];
    truncated = json['truncated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['day'] = this.day;
    data['time'] = this.time;
    data['truncated'] = this.truncated;
    return data;
  }
}


class Periodss {
  Close? open;

  Periodss({this.open});

  Periodss.fromJson(Map<String, dynamic> json) {
    open = json['open'] != null ? new Close.fromJson(json['open']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.open != null) {
      data['open'] = this.open!.toJson();
    }
    return data;
  }
}

class Open {
  int? day;
  String? time;

  Open({this.day, this.time});

  Open.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['time'] = this.time;
    return data;
  }
}

class Rows {
  List<Elements>? elements;

  Rows({this.elements});

  Rows.fromJson(Map<String, dynamic> json) {
    if (json['elements'] != null) {
      elements = <Elements>[];
      json['elements'].forEach((v) {
        elements!.add(new Elements.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.elements != null) {
      data['elements'] = this.elements!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Elements {
  Distance? distance;
  Distance? duration;
  String? status;

  Elements({this.distance, this.duration, this.status});

  Elements.fromJson(Map<String, dynamic> json) {
    distance = json['distance'] != null
        ? new Distance.fromJson(json['distance'])
        : null;
    duration = json['duration'] != null
        ? new Distance.fromJson(json['duration'])
        : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.distance != null) {
      data['distance'] = this.distance!.toJson();
    }
    if (this.duration != null) {
      data['duration'] = this.duration!.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class Distance {
  String? text;
  int? value;

  Distance({this.text, this.value});

  Distance.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['value'] = this.value;
    return data;
  }
}
