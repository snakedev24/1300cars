class ChatRoomModel {
  int? statusCode;
  List<ChatRoomData>? data;

  ChatRoomModel({this.statusCode, this.data});

  ChatRoomModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    if (json['data'] != null) {
      data = <ChatRoomData>[];
      json['data'].forEach((v) {
        data!.add(new ChatRoomData.fromJson(v));
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

class ChatRoomData {
  int? id;
  String? name;
  String? roomName;
  String? roomImage;
  int? withChatId;
  String? lastMessage;
  String? timestamp;
  int? unreadCount;
  String? time;

  ChatRoomData(
      {this.id,
        this.name,
        this.roomName,
        this.roomImage,
        this.withChatId,
        this.lastMessage,
        this.timestamp,
        this.unreadCount});

  ChatRoomData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    roomName = json['room_name'];
    roomImage = json['room_image'];
    withChatId = json['with_chat_id'];
    lastMessage = json['last_message'];
    timestamp = json['timestamp'];
    unreadCount = json['unread_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['room_name'] = this.roomName;
    data['room_image'] = this.roomImage;
    data['with_chat_id'] = this.withChatId;
    data['last_message'] = this.lastMessage;
    data['timestamp'] = this.timestamp;
    data['unread_count'] = this.unreadCount;
    return data;
  }
}