import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../constants/image_constant.dart';
import '../../constants/string_constant.dart';
import '../../controller/profile_controller.dart';
import '../../widget/app_text.dart';

class TermsScreen extends StatelessWidget {
   TermsScreen({super.key});

  final profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Stack(
        children: [

          Positioned(
            top: 0,
            child:Image.asset(ConstantImage.appointment_bg, height: Get.height * 0.23, fit: BoxFit.fill,),
          ),
          Positioned(
              top: 0,
              right: 0,
              bottom: 0,
              left: 0,
              child: SvgPicture.asset(ConstantImage.yellowBack, fit: BoxFit.fill,)),
          // SvgPicture.asset(ConstantImage.aboutBackImg,  height: Get.height * 0.23,fit: BoxFit.fill,),
          Padding(
            padding:  EdgeInsets.only(top: Get.height*0.06,left: Get.width*0.04, right: Get.width*0.04
            ),
            child: Column(
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Get.back();
                      },
                      child: SvgPicture.asset(ConstantImage.back,height: Get.height*0.045,),
                    ),
                    AppText(text:"Terms & Condition", fontSize: 0.022, fontWeight: FontWeight.w700,
                        fontFamily: ConstantString.fontRegular),

                    SizedBox(width: Get.width*0.09,),
                  ],
                ),
                SizedBox(height: Get.height*0.03,),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:

                            Obx(() =>  HtmlWidget(
                              profileController.termText!.value??"",

                            )),


                    ),
                  ),
                ),




              ],
            ),
          )
        ],
      ),
    );
  }
}
