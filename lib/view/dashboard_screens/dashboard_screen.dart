
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user/constants/color_constant.dart';
import 'package:user/constants/image_constant.dart';
import 'package:user/view/dashboard_screens/appointments_screen.dart';
import 'package:user/view/dashboard_screens/chat_screen.dart';
import 'package:user/view/dashboard_screens/home_screen.dart';
import 'package:user/view/dashboard_screens/profile_screen.dart';

import '../../utils/firebase_api.dart';

class DashboardScreen extends StatefulWidget {
    const DashboardScreen({super.key});

    @override
    State<DashboardScreen> createState() => _DashboardScreenState();
  }



  class _DashboardScreenState extends State<DashboardScreen> {
    int currentIndex = 0;

    List<Widget>? screen = [];

    // firbase() async{
    //   await FireBaseApi().initNotification();
    //   await FireBaseApi().setup();
    // }
    @override
    void initState() {
      // TODO: implement initState
      super.initState();
      // firbase();
      screen = [HomeScreen(), AppointmentScreen(), ChatListScreen(), ProfileScreen()];
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        final title = message.notification?.title;
        if (title == "chat_notification") {
          Get.to(ChatListScreen());
        }else if(title=="booking_notification"){
          Get.to(DashboardScreen());
        }
      });
    }

    final _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: ConstantColor.darkWhite,
        key: _scaffoldKey,
        body: screen?[currentIndex],
        bottomNavigationBar:

        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            boxShadow: [
              BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 2),
            ],
          ),
          child: ClipRRect(


            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),

              child: BottomNavigationBar(
                currentIndex: currentIndex,
                onTap: (index) {
                  setState(() {
                    currentIndex = index; // Update the current index when an item is tapped
                  });
                },
                items: [
              BottomNavigationBarItem(
                    icon: ImageIcon(
                      AssetImage(ConstantImage.home),
                      color: currentIndex == 0 ? ConstantColor.greenDark : Colors.grey,
                    ),
                    label: "Home",
                  ),

                  BottomNavigationBarItem(
                    icon: ImageIcon(
                      AssetImage(
                          ConstantImage.booking),
                      color: currentIndex == 1 ? ConstantColor.greenDark : Colors.grey,
                    ),
                    label: "Appointment",
                  ),


                  BottomNavigationBarItem(
                    icon: ImageIcon(
                      AssetImage(
                          ConstantImage.chat),
                      color: currentIndex == 2 ? ConstantColor.greenDark : Colors.grey,
                    ),
                    label: "Chat",
                  ),

                  BottomNavigationBarItem(
                    icon: ImageIcon(
                      AssetImage(
                          ConstantImage.profile),
                      color: currentIndex == 3 ? ConstantColor.greenDark : Colors.grey,
                    ),
                    label: "Profile",
                  ),
                ],
                selectedItemColor: ConstantColor.greenDark,
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.white,
              )
        ),
        ),


      );
    }
  }


