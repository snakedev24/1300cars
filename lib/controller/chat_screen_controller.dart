import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../Model/ChatRoomModel.dart';
import '../network/api_provider.dart';
import '../widget/api_loader.dart';
import '../widget/no_internet_screen.dart';

class ChatScreenController extends GetxController{

  RxList<ChatRoomData> foundChat=<ChatRoomData>[].obs;


  @override
  void onInit() {
    super.onInit();
    foundChat = chatRoomList;
  }
  RxBool loadingChat=false.obs;

  RxBool? checkSearchField=false.obs;

  void runFilter(String enteredKeyword) {
    RxList<ChatRoomData> resultsEmpty = <ChatRoomData>[].obs;
    if (enteredKeyword.isEmpty) {
      chatRoom() ;
    } else {
      resultsEmpty.value = chatRoomList
          .where((user) => user.roomName!
          .toLowerCase()
          .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    // chatRoom() ;
    foundChat.value = resultsEmpty;
  }

  String? fcmToken;

  String formatTimestampForChat(String timestamp) {
    final parsedDateTime = DateTime.parse(timestamp);
    final now = DateTime.now();
    final difference = now.difference(parsedDateTime);

    if (difference.inSeconds < 60) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min ago';
    } else if (difference.inDays == 0) {
      final formatter = DateFormat.jm();
      return formatter.format(parsedDateTime);
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else {
      final formatter = DateFormat('dd MMM');
      return formatter.format(parsedDateTime);
    }
  }

  RxList<ChatRoomData> chatRoomList=<ChatRoomData>[].obs;

  chatRoom() async {
    try {


      final connectivityResult = await (Connectivity().checkConnectivity());

      if (connectivityResult == ConnectivityResult.none) {
        return {
          Get.to(InternetLoss())
        };
      }

      loadingChat.value=true;

      chatRoomList.clear();
      var response = await ApiProvider().chatRoom();
      if ((response as ChatRoomModel).statusCode == 200) {
        chatRoomList.addAll(response.data!);

        for(int i=0;i<chatRoomList.length;i++){
          if(chatRoomList[i].timestamp!.isNotEmpty){
            // final parsedDateTime = DateTime.parse(chatRoomList[i].timestamp!);
            // final formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
            // final formattedDateTime=formatTimestampForChat(formatter.format(parsedDateTime));
            // chatRoomList[i].time=formattedDateTime.toString();

            DateTime timestamp = DateTime.parse(chatRoomList[i].timestamp!);
            DateTime localTime = timestamp.toLocal();
            final formattedLocalTime = DateFormat('hh:mm a').format(localTime);

            chatRoomList[i].time=formattedLocalTime.toString();
          }

        }
        loadingChat.value=false;
      }
    }
    catch(e){

    }
    finally {}
  }
}