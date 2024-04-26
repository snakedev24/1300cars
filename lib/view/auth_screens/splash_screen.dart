import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
   SplashScreen({super.key});
  final splashController =Get.put(SplashController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Image.asset('assets/image/png/splash.png',width: Get.width,height: Get.height,fit: BoxFit.fill,)
    );
  }
}
