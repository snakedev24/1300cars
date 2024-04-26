import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:user/pref/shared_preference.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../Model/ChatMessageModel.dart';
import '../Model/SendImageModel.dart';
import '../constants/image_constant.dart';
import '../constants/string_constant.dart';
import '../network/api_provider.dart';

class ChatController extends GetxController {

  RxDouble minTextFieldHeight = 60.0.obs;
  RxDouble maxTextFieldHeight = 150.0.obs;
  RxInt changeStartUpdate = 1.obs;
  RxBool? openTopCon = false.obs;
  TextEditingController messageSendController = TextEditingController();
  WebSocketChannel? channelMessageSend;
  String? accessToken = SharedPreference.getString(ConstantString.accessToken);
  final ScrollController chatListScrollController = ScrollController();

  socketOn(String? userId){
    final wsUrl = Uri.parse('${"ws://apis.1300cars.com/ws/ac/"}$userId/?token=$accessToken');
    channelMessageSend = WebSocketChannel.connect(wsUrl);
    channelMessageSend!.stream.listen((message) {
      final parsedData = json.decode(message);
      print("oooobje $parsedData");

      chatMessageList.insert(0,ChatMessageData(
          messageType: parsedData["data"]["msg_type"],
          content:parsedData["data"]["message"],
          userId:parsedData["sender_id"],
          timestamp:parsedData["timestamp"]
      ));
    });
  }

  int currentPage = 1;
  int? totalPages;


  RxList<ChatMessageData> chatMessageList=<ChatMessageData>[].obs;
  chatMessage(String id) async {
    usID=id;
    try {
    //  chatMessageList.clear();
      var response = await ApiProvider().chatMessage(id,currentPage.toString());
      if ((response as ChatMessageModel).statusCode == 200) {
        totalPages=response.totalPages;
        currentPage++;
        chatMessageList.addAll(response.data!);
      }
    }
    catch(e){

    }
    finally {}
  }
  String? usID;
  void scrollListener() {
    double maxScroll = chatListScrollController.position.maxScrollExtent;
    double currentScroll = chatListScrollController.position.pixels;
    if (maxScroll == currentScroll) {
      if(currentPage<=totalPages!){
        chatMessage(usID!);
      }
    }
  }
  sendMessage(value,type,{int? imageId}){
    if(type=="text"){
      final message = {
       "message":messageSendController.text,"msg_type":"text"
      };
      final jsonMessage = json.encode(message);
      channelMessageSend!.sink.add(jsonMessage);
      messageSendController.clear();
      var userId=SharedPreference.getString(
        ConstantString.userId,
      );
      chatMessageList.insert(0,ChatMessageData(
          messageType: "text",
          content:value,
        userId:int.parse( userId.toString()),
          timestamp:DateTime.now().toString()


      ));
    }
    else if(type=="image"){
      final message = {
        "message":value,"msg_type":"image"
      };
      final jsonMessage = json.encode(message);
      channelMessageSend!.sink.add(jsonMessage);

    }
  }
  final picker = ImagePicker();
  Future<void> pickAndSendImage(ImageSource imageType) async {
    final pickedFile = await picker.pickImage(source:imageType);
    if (pickedFile != null) {
      // imageSend!.value=true;
      var userId=SharedPreference.getString(
        ConstantString.userId,
      );
      Get.back();
      chatMessageList.insert(0,ChatMessageData(
          messageType: "image",
          content:pickedFile.path,
          userId:int.parse( userId.toString()),
          timestamp:DateTime.now().toString()

      ));

      final imageUrl = await ApiProvider().uploadImage(pickedFile.path);
      if ((imageUrl as SendImageModel).data != null){

        sendMessage(imageUrl.data!.file, "image",imageId: imageUrl.data!.id);
      }
    }
  }



  // RxList<ChatModel> chatMsgData = <ChatModel>[
  //   ChatModel(
  //       sender: "receiver",
  //       type: "text",
  //       msg: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent sed diam ligula.",
  //       profileIcon: ConstantImage.star,
  //       name: "aaa.."),
  //
  //   ChatModel(
  //       sender: "sender",
  //       type: "text",
  //       msg: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent sed diam ligula.",
  //       profileIcon: ConstantImage.star,
  //       name: "skk.."),
  //
  //   ChatModel(
  //       sender: "receiver",
  //       type: "text",
  //       msg: "Oh! Cool Send me photo)",
  //       profileIcon: ConstantImage.star,
  //       name: "aaa.."),
  // ].obs;

}
//
// class ChatModel {
//   String? sender;
//   String? msg;
//   String? type;
//   String? profileIcon;
//   String? name;
//   ChatModel({this.sender, this.msg, this.profileIcon, this.name, this.type});
// }
