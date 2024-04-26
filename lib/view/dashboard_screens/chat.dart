import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:user/constants/color_constant.dart';
import 'package:user/constants/image_constant.dart';
import 'package:user/pref/shared_preference.dart';

import '../../constants/string_constant.dart';
import '../../controller/chat_controller.dart';
import '../../widget/app_text.dart';
import '../../widget/chatMediaPickerPopup.dart';
import '../../widget/image_zoom_chat.dart';

class Chat extends StatefulWidget {
  String? userId;
  String? chatId;
  String? namee;
  Chat({Key? key, this.userId,this.chatId, this.namee}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final chatController = Get.put(ChatController());

  @override
  void initState() {

    super.initState();
    chatController.socketOn(widget.userId);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      chatController.chatMessage(widget.chatId!);
      chatController.currentPage = 1;
      chatController.chatListScrollController.addListener(chatController.scrollListener);
    });
  }

  @override
  void dispose() {

    if (chatController.channelMessageSend != null) {
      chatController.channelMessageSend!.sink.close();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 1,
        title: AppText(
          text: widget.namee!.toString(),
          fontWeight: FontWeight.w700,
          fontSize: 0.022,
        ),
        centerTitle: true,
        leadingWidth: Get.width * 0.12,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: EdgeInsets.only(left: Get.width * 0.03),
            child: SvgPicture.asset(
              ConstantImage.back,
            ),
          ),
        ),
      ),
      body: Column(
        children: [


          Expanded(
            child: Stack(
              children: [
                Image.asset(
                  ConstantImage.backChatImage,
                  fit: BoxFit.fill,
                  width: Get.width,
                  height: Get.height,
                ),
                Obx(() => _buildList()),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Obx(() => AnimatedContainer(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(blurRadius: 5.0, color: Colors.grey),
                    ],
                  ),

                  duration: Duration(milliseconds: 200),
                  constraints: BoxConstraints(
                    minHeight: chatController.minTextFieldHeight.value,
                    maxHeight: chatController.maxTextFieldHeight.value,
                  ),
                  padding: EdgeInsets.only(
                      left: Get.width * 0.010,
                      bottom: Get.height * 0.010,
                      top: Get.height * 0.010),
                  width: double.infinity,
                  // color: ConstantColor.backGroundColor,
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: Get.width * 0.01,
                      ),
                      GestureDetector(
                        onTap: () {
                          passwordChangePopup((value) {
                            switch (value) {
                              case 0:
                                {
                                  chatController
                                      .pickAndSendImage(ImageSource.gallery);
                                }
                                break;
                              case 1:
                                {
                                  chatController
                                      .pickAndSendImage(ImageSource.camera);
                                }
                                break;
                            }
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.3),
                              shape: BoxShape.circle),
                          child: Icon(
                            Icons.image,
                            color: Colors.grey,
                            size: Get.height * 0.04,
                          ),
                        ),
                      ),

                      SizedBox(width: Get.width * 0.020,),


                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: Get.width * 0.03),
                          child: TextFormField(
                            style: TextStyle(fontSize: Get.height * 0.020),
                            onChanged: (text) {
                              final lines = text.split('\n').length;

                              chatController.minTextFieldHeight.value =
                                  60.0 + (lines - 1) * 20.0;
                              chatController.maxTextFieldHeight.value =
                                  150.0 + (lines - 1) * 20.0;
                            },
                            controller: chatController.messageSendController,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding:
                                  EdgeInsets.all(Get.height * 0.015),
                              hintStyle: TextStyle(color: Colors.black54),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1, color: Colors.grey),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(Get.height * 0.030)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1, color: Colors.grey),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(Get.height * 0.030)),
                              ),
                            ),
                            maxLines: null,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (chatController.messageSendController.text
                              .trim()
                              .isNotEmpty) {
                            chatController.sendMessage(
                                chatController.messageSendController.text,
                                "text");
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(Get.height * 0.012),
                          decoration: BoxDecoration(
                              color: ConstantColor.darkYellow,
                              shape: BoxShape.circle),
                          child: SvgPicture.asset(
                            ConstantImage.msgSendIcon,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: Get.width * 0.02,
                      ),
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }

  ListView _buildList() {
    return ListView.builder(
        reverse: true,
        itemCount: chatController.chatMessageList.length,
        controller: chatController.chatListScrollController,
        itemBuilder: (context, index) {
          return ChatMessageWidget(
            text: chatController.chatMessageList[index].content,
            sender: chatController.chatMessageList[index].userId.toString(),
            time: chatController.chatMessageList[index].timestamp.toString(),
            name: chatController.chatMessageList[index].user.toString(),
            type: chatController.chatMessageList[index].messageType.toString(),
            index: index,
          );
        });
  }
}

class ChatMessageWidget extends StatelessWidget {
  final String? text;
  final String? sender;
  final String? time;
  final String? name;
  final String? type;
  final int? index;

  ChatMessageWidget(
      {Key? key,
      this.text,
      this.sender,
      this.time,
      this.name,
      this.type,
      this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Get.height * 0.005),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(
                    left: Get.width * 0.015,
                    right: Get.width * 0.015,
                    top: Get.height * 0.01,
                    bottom: Get.height * 0.01),
                child: Align(
                  alignment: (sender !=
                          SharedPreference.getString(
                            ConstantString.userId,
                          )
                      ? Alignment.topLeft
                      : Alignment.topRight),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: (sender !=
                            SharedPreference.getString(
                              ConstantString.userId,
                            ))
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: (sender !=
                                SharedPreference.getString(
                                  ConstantString.userId,
                                ))
                            ? CrossAxisAlignment.start
                            : CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: (type == "text")
                                ? (type == "text" && text!.length > 24)
                                    ? Get.width * 0.65 // Use a fixed width
                                    : null
                                : Get.width * 0.6,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(35),
                                  topRight: Radius.circular(35),
                                  bottomLeft: Radius.circular((sender !=
                                          SharedPreference.getString(
                                            ConstantString.userId,
                                          ))
                                      ? 10
                                      : 35),
                                  bottomRight: Radius.circular((sender !=
                                          SharedPreference.getString(
                                            ConstantString.userId,
                                          ))
                                      ? 35
                                      : 10),
                                ),
                                color: (sender !=
                                        SharedPreference.getString(
                                          ConstantString.userId,
                                        ))
                                    ? ConstantColor.green_color
                                    : ConstantColor.msgGreyColor),
                            padding: EdgeInsets.all(16),
                            child: (type == "text")
                                ? AppText(
                                    text: text!,
                                    fontSize: 0.018,
                                    fontWeight: FontWeight.w500,
                                    textColor: (sender !=
                                            SharedPreference.getString(
                                              ConstantString.userId,
                                            ))
                                        ? Colors.white
                                        : Colors.black)

                                : text!.contains("http")

                                    ? GestureDetector(
                              onTap: (){
                                Get.to(ChatImageZoom(image: text!,checkImage:0));
                              },

                                      child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              Get.height * 0.010),
                                          child: CachedNetworkImage(
                                              height: Get.height * 0.2,
                                              fit: BoxFit.fill,
                                              imageUrl: text!,
                                              placeholder: (context, url) => Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                              errorWidget: (context, url,
                                                      error) =>
                                                  Image.asset(
                                                      ConstantImage.errorImage)),
                                        ),
                                    )


                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            Get.height * 0.010),
                                        child: Image.file(
                                          File(text!),
                                          fit: BoxFit.fill,
                                          height: Get.height * 0.2,
                                        ),
                                      ),
                          ),
                        ],
                      ),
                      (sender == SharedPreference.getString(ConstantString.userId,))
                          ? SizedBox(width: Get.width * 0.01,)
                          : Container(),
                    ],
                  ),
                ),
              )
            ],
          ))
        ],
      ),
    );
  }
}
