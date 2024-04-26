import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../constants/color_constant.dart';
import '../constants/image_constant.dart';
import 'app_text.dart';


class InternetLoss extends StatelessWidget {
  const InternetLoss({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(ConstantImage.close,
            height: Get.height*0.2,
            color: ConstantColor.green_color,
          ),
          SizedBox(height: Get.height*0.02,width: Get.width,),
          AppText(text: "No Internet", fontSize: 0.04, fontWeight: FontWeight.w600,
          textColor: ConstantColor.green_color,
          )

        ],
      ),
    );
  }
}
