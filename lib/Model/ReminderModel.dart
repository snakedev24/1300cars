class ReminderModel {
  int? statusCode;
  ReminderData? data;

  ReminderModel({this.statusCode, this.data});

  ReminderModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    data = json['data'] != null ? new ReminderData.fromJson(json['data']) : null;
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

class ReminderData {
  int? id;
  dynamic isReminder;
  int? user;

  ReminderData({this.id, this.isReminder, this.user});

  ReminderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isReminder = json['is_reminder'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['is_reminder'] = this.isReminder;
    data['user'] = this.user;
    return data;
  }
}


