class ChatMessageModel {
  int? totalData;
  int? limit;
  int? totalPages;
  int? statusCode;
  List<ChatMessageData>? data;

  ChatMessageModel({this.totalData, this.limit, this.totalPages, this.statusCode,this.data});

  ChatMessageModel.fromJson(Map<String, dynamic> json) {
    totalData = json['total_data'];
    limit = json['limit'];
    totalPages = json['total_pages'];
    statusCode = json['status_code'];
    if (json['data'] != null) {
      data = <ChatMessageData>[];
      json['data'].forEach((v) {
        data!.add(new ChatMessageData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_data'] = this.totalData;
    data['limit'] = this.limit;
    data['total_pages'] = this.totalPages;
    data['status_code'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChatMessageData {
  int? id;
  String? content;
  bool? isRead;
  String? timestamp;
  String? messageType;
  String? user;
  int? room;
  int? userId;

  ChatMessageData(
      {this.id,
        this.content,
        this.isRead,
        this.timestamp,
        this.messageType,
        this.user,
        this.room,
        this.userId});

  ChatMessageData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    isRead = json['is_read'];
    timestamp = json['timestamp'];
    messageType = json['message_type'];
    user = json['user'];
    room = json['room'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['content'] = this.content;
    data['is_read'] = this.isRead;
    data['timestamp'] = this.timestamp;
    data['message_type'] = this.messageType;
    data['user'] = this.user;
    data['room'] = this.room;
    data['user_id'] = this.userId;
    return data;
  }
}