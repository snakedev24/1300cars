import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../constants/color_constant.dart';
import '../constants/image_constant.dart';
import '../constants/string_constant.dart';
import '../view/auth_screens/login_screen.dart';
import '../widget/app_text.dart';



backCall(){
  Get.offAll(LoginScreen());
}

Future<dynamic> loginDialog() {
  return Get.defaultDialog(
      backgroundColor: Colors.white,
      title: "",
      barrierDismissible: false,
      titleStyle: TextStyle(fontSize: 0),
      content: WillPopScope(
        onWillPop:()=>backCall(),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                    onTap: (){
                      Get.back();
                    },
                    child: SvgPicture.asset(ConstantImage.close_icon)),
              ],
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),

            SizedBox(
              height: Get.height * 0.01,
            ),
            AppText(
                textAlign: TextAlign.center,
                text:
                "Please login to access this feature",
                fontSize: 0.017,
                textColor: Colors.black,
                fontWeight: FontWeight.w400),
            SizedBox(
              height: Get.height * 0.03,
            ),
            GestureDetector(
              onTap: () {
                Get.back();
                Get.offAll(LoginScreen());
              },
              child: Container(
                height: Get.height * 0.06,
                width: Get.width * 0.32,
                decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade400,
                      offset: Offset(0, 3),
                      blurRadius: 4,
                      spreadRadius: 0.1,
                    ),
                  ],
                  gradient: LinearGradient(
                    colors: [
                      ConstantColor.gradiantLightColor,
                      ConstantColor.gradiantDarkColor,
                    ],
                  ),
                ),



                child: Center(
                    child: AppText(
                      text: "Click to Login",
                      fontSize: 0.018,
                      textColor: Colors.white,
                      fontWeight: FontWeight.w700,
                    )),
              ),
            )
          ],
        ),
      )
  );
}