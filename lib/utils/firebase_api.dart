import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../controller/appStreamController.dart';
import '../pref/shared_preference.dart';


class FireBaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;


  AppStreamController appStreamController = AppStreamController.instance;


  final localNotification=FlutterLocalNotificationsPlugin();

  final _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> setup() async {
    const androidInitializationSetting = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInitializationSetting = DarwinInitializationSettings();
    const initSettings = InitializationSettings(android: androidInitializationSetting, iOS: iosInitializationSetting);
    await _flutterLocalNotificationsPlugin.initialize(initSettings);
  }
  void showLocalNotification(String title, String body) {
    const androidNotificationDetail = AndroidNotificationDetails(
        'high_importance_channel', // channel Id
        'general' // channel Name
    );
    const iosNotificatonDetail = DarwinNotificationDetails();
    const notificationDetails = NotificationDetails(
      iOS: iosNotificatonDetail,
      android: androidNotificationDetail,
    );
    _flutterLocalNotificationsPlugin.show(0, title, body, notificationDetails);
  }

  Future initNotificationIos() async{

    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true,badge: true,sound: true);
  }


  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    final fcmToken = await _firebaseMessaging.getToken();
    SharedPreference.setString("fcmToken", fcmToken!);
    print("fcm $fcmToken");
    FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async{
      // Handle background messages here

      // Check the notification title and navigate accordingly

      if (message.notification?.title == "chat_notification") {

      } else if (message.notification?.title == "appointment") {
      }
    });

    // FirebaseMessaging.instance.getInitialMessage().then((value) =>
    //     handleBackgroundFrount(value!.messageType!)
    // );
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? value) {

        handleBackgroundFrount(value!.messageType!);
    });


    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final notification=message.notification;
      if(message.notification?.title=="chat_notification"){
        showLocalNotification(notification!.title!,notification.body!);
        appStreamController.updateChatStream();
        appStreamController.updateChat.add(true);
      }else{
        showLocalNotification(notification!.title!,notification.body!);
      }
      updateUI(message.data);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // Handle the notification that was used to open the app when in the background or terminated state
      final notification=message.notification;
      // var messageType =notification!.body!;
      // final Map<String, dynamic> messageMap = json.decode(messageType);
      if (message.notification?.title == "chat_notification") {

      } else if (message.notification?.title == "appointment") {
      }
      // You can navigate to a specific screen or perform custom actions based on the message
      // For navigation, you can use a navigation package like 'navigator' or 'flutter_bloc'
      // navigateToScreen(message.data);
    });


    // To handle messages when the app is in the foreground, you can add this callback:
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final notification=message.notification;
      var messageType =notification!.body!;
      final Map<String, dynamic> messageMap = json.decode(messageType);
      print('FCM Message received in the foreground: ${message.notification?.title}, ${messageMap['message_data']}');

    });
    return Future.value();
  }

  Future<void> handleBackgroundFrount(String message) async {
    print('FCM Message received in the background:, ${message}');
  }

  Future<void> handleBackground(RemoteMessage message) async {
    print('FCM Message received in the background: ${message.notification?.title}, ${message.notification?.body}');
  }
  void updateUI(Map<String, dynamic> data) {
    // Implement UI updates based on the data from the message
    // Get.to(ChatScreen());
    // This could involve updating widgets, displaying pop-ups, etc.
  }



  Future<void> handleBackgroundMessage(RemoteMessage message) async {
    // Handle background messages here
    print('FCM Message received in the background: ${message.notification?.title}, ${message.notification?.body}');
  }

}
