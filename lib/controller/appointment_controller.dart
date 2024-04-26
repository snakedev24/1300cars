
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:user/pref/shared_preference.dart';
import 'package:user/view/dashboard_screens/chat_screen.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:user/pref/shared_preference.dart';
import 'package:user/view/dashboard_screens/chat.dart';
import 'package:user/view/dashboard_screens/chat_screen.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../Model/AppointmentListModel.dart';
import '../Model/CancelRequestModel.dart';
import '../constants/string_constant.dart';
import '../network/api_provider.dart';
import '../widget/no_internet_screen.dart';

class AppointmentController extends GetxController{

  // TextEditingController searchTextController = TextEditingController();

  RxList<Data> appointmentList = <Data>[].obs;
  WebSocketChannel? channel;
  String? accessToken = SharedPreference.getString(ConstantString.accessToken);
  void onInit() {
    super.onInit();
  }

  RxBool? loading=false.obs;
  RxBool? checkSearchField=false.obs;

  socketOn(userId, String? roomName, String? name){
    print("accccc $accessToken");
    final wsUrl = Uri.parse('${"ws://apis.1300cars.com/ws/ac/"}$userId/?token=$accessToken');
    channel = WebSocketChannel.connect(wsUrl);
    final message = {
      "message":"hii","msg_type":"text"
    };
    channel!.sink.add(message);
    channel!.sink.close();

    if(roomName == null){
      Get.to(Chat(userId: userId.toString(),namee:name));
    }else{
      Get.to(Chat(userId: userId.toString(),chatId: roomName.toString(),namee :name));
    }

  }
  String search="";

  appointment() async {

    final connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      return {
        Get.to(InternetLoss())
      };
    }

    loading!.value=true;
    try {
      appointmentList.clear();
      var response = await ApiProvider().appointmentList(search);
      if ((response as AppointmentListModel).statusCode == 200) {
        appointmentList.clear();
        appointmentList.addAll(response.data!);
        loading!.value=false;
      }
    } finally {}
  }

  cancelRequest(String id) async {
    final connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      return {
        Get.to(InternetLoss())
      };
    }


    try {
      var response = await ApiProvider().cancelRequest(id);
      if ((response as CancelRequestModel).statusCode == 200){
        appointment();

      }
    } catch (e) {
      print('Error : $e');
    }
  }


}