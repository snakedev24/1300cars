import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:user/constants/color_constant.dart';
import 'package:user/constants/string_constant.dart';
import 'package:user/controller/chat_screen_controller.dart';
import 'package:user/view/dashboard_screens/chat.dart';
import '../../common/loginDialog.dart';
import '../../constants/image_constant.dart';
import '../../controller/appStreamController.dart';
import '../../controller/chat_controller.dart';
import '../../pref/shared_preference.dart';
import '../../widget/app_text.dart';

class ChatListScreen extends StatefulWidget {
   ChatListScreen({Key? key}) : super(key: key);

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final chatScreenController=Get.put(ChatScreenController());

  final chatController =Get.put(ChatController());
  AppStreamController appStreamController = AppStreamController.instance;

  @override
  void initState() {
    super.initState();

    if((SharedPreference.getBool(ConstantString.guestUser) == false)){
    chatScreenController.chatRoom();}
    appStreamController.updateChatStream();
    appStreamController.updateChatAction.listen((event) {
      chatScreenController.chatRoom();

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          shadowColor:Colors.white,
          surfaceTintColor:Colors.white,
          elevation: 5,
          centerTitle: true,


          title:
              Obx(() =>
          (chatScreenController.checkSearchField!.value)?
          Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.transparent, borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: TextField(
                onChanged: (value){
                  chatScreenController.runFilter(value);
                },
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        // /* Clear the search field */
                        chatScreenController.checkSearchField!.value=false;


                      },
                    ),

                    hintText: 'Search...',
                    border: InputBorder.none),
              ),
            ),
          ):
          AppText(
            text: "Chat",
            fontSize: 0.023,
            fontWeight: FontWeight.w700,
            fontFamily: ConstantString.fontbold,
          )),
          actions: [
            Obx(() =>
            GestureDetector(
              onTap: (){
                chatScreenController.checkSearchField!.value=true;
              },
              child: (chatScreenController.checkSearchField!.value==false)?Padding(
                  padding: EdgeInsets.only(right: Get.width*0.03),
                  child: Icon(Icons.search)):Container(),
            ))
          ],
        ),
        body: (SharedPreference.getBool(ConstantString.guestUser) == true)?
        Center(child: GestureDetector(
          onTap: (){
            loginDialog();
          },
          child: Text("Please login to access this feature"
            ,style: TextStyle(
                fontSize: Get.height*0.024,
                fontFamily: ConstantString.fontRegular
            ),
          ),
        ),):
        Obx(() =>

        (chatScreenController.loadingChat.value)?
        Center(
          child: Container(
            height: 40,
            color: Colors.transparent,

            child: Center(
              child: CircularProgressIndicator.adaptive(
                valueColor: AlwaysStoppedAnimation<Color>(ConstantColor.gradiantLightColor),),
            ),
          ),
        )
       : (chatScreenController.chatRoomList.isNotEmpty)?
            RefreshIndicator(
              onRefresh: () {
                return chatScreenController.chatRoom();
              },
          child: ListView.builder(
              itemCount: chatScreenController.chatRoomList.length,
              itemBuilder: (context,index){
                return GestureDetector(
                  onTap: (){
                    chatController.currentPage=1;
                    chatController.chatMessageList.clear();

                    Get.to(Chat(userId: chatScreenController.chatRoomList[index].withChatId!.toString(),chatId:chatScreenController.chatRoomList[index].name!  ,namee:chatScreenController.chatRoomList[index].roomName))!.then((value) =>
                        chatScreenController.chatRoom()
                    );
                  },
                  child: Column(

                    children: [
                      Container(
                        padding: EdgeInsets.only(left: Get.width*0.06,right: Get.width*0.06,
                            top: Get.height*0.02),
                        height: Get.height*0.11,
                        color: Colors.white,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                (chatScreenController.chatRoomList[index].roomImage!.isNotEmpty)?
                                Image.network(chatScreenController.chatRoomList[index].roomImage!,width: Get.width*0.165,height: Get.height*0.082,fit: BoxFit.fill,):

                                ClipRRect(

                                    child: SvgPicture.asset(ConstantImage.profileImage,fit: BoxFit.fill,)),
                                SizedBox(width: Get.width*0.018,),
                                SizedBox(
                                  width: Get.width*0.2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      AppText(
                                          overflow: TextOverflow.ellipsis,text: chatScreenController.chatRoomList[index].roomName!, fontSize: 0.017, fontWeight: FontWeight.w700),

                                      AppText(
                                        overflow: TextOverflow.ellipsis,

                                          text: chatScreenController.chatRoomList[index].lastMessage!,

                                          textColor: Colors.grey.shade500,fontSize: 0.014, fontWeight: FontWeight.w700),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AppText(text:chatScreenController.chatRoomList[index].time??"",fontSize: 0.017, fontWeight: FontWeight.w700,textColor: Colors.grey.shade500,),
                                (chatScreenController.chatRoomList[index].unreadCount!=0)?
                                Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.orangeAccent,
                                        shape: BoxShape.circle
                                    ),
                                    child: AppText(text: chatScreenController.chatRoomList[index].unreadCount.toString(), fontSize: 0.014,textColor: Colors.white, fontWeight: FontWeight.w700)

                                ):Container(),
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(left: Get.width*0.06,right: Get.width*0.06,),
                        child: Divider(color: Colors.grey.shade200,),
                      )
                    ],
                  ),
                );

              }),
        ):

        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText(
                text: "No Chat Found",
                textColor: Colors.black,
                fontSize: 0.02, fontWeight: FontWeight.w500,
              ),
              SizedBox(height: Get.height*0.02,),
              GestureDetector(
                onTap: (){
                  chatScreenController.chatRoom();
                },
                child: AppText(
                  text: "Refresh",
                  textColor: ConstantColor.gradiantDarkColor,
                  fontSize: 0.023, fontWeight: FontWeight.w500,
                ),
              ),

            ],
          ),
        )
        ));
  }
}
