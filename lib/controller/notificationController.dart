import 'dart:convert';

import 'package:get/get.dart';
import 'package:user/constants/string_constant.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../pref/shared_preference.dart';

class NotificationController extends GetxController{
  WebSocketChannel? channelNotification;
  String? accessToken = SharedPreference.getString(ConstantString.accessToken);

  socketOnNotification(){
    final wsUrl = Uri.parse('ws://apis.1300cars.com/ws/ac/notification?token=$accessToken');
    channelNotification = WebSocketChannel.connect(wsUrl);
    channelNotification!.stream.listen((message) {
      final parsedData = json.decode(message);
      print("oooobje $parsedData");


    });
  }

  disconnect(){
    if (channelNotification != null && channelNotification!.sink != null) {
      channelNotification!.sink.close();
    }
  }
}