import 'dart:async';

class AppStreamController {
  AppStreamController._internal();

  static final AppStreamController _instance = AppStreamController._internal();
  static AppStreamController get instance => _instance;

  // Stream to handle tab bar
  StreamController<bool> updateChat = StreamController.broadcast();
  Stream get updateChatAction => updateChat.stream;


  void disposeRefreshStream() {
    updateChat.close();

  }

  void updateChatStream() {
    if (updateChat.isClosed) {
      updateChat = StreamController.broadcast();
    }
  }


}