import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../constants/image_constant.dart';
import '../../constants/string_constant.dart';
import '../../widget/app_text.dart';

class DiagnosticDetailScreen extends StatelessWidget {
  String? question;
  String? answer;

   DiagnosticDetailScreen(this.question, this.answer, {super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        leading: Container(
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Transform.scale(
              scale: 0.7, // Adjust the scale factor as needed to reduce the icon size
              child: SvgPicture.asset(ConstantImage.back),
            ),
          ),
        ),
        title: AppText(text: "Diagnostic tools",fontWeight: FontWeight.w700,
          fontFamily: ConstantString.fontbold,
          fontSize: 0.022,textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),


      body : SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(Get.height*0.01),
          child: Column(

            children: [

              AppText(
                text: question,
                fontWeight: FontWeight.w700,
                fontFamily: ConstantString.fontbold,
                fontSize: 0.020,
              ),

              SizedBox(height: Get.height*0.02,),
              AppText(
                text: answer,
                fontSize: 0.015,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
