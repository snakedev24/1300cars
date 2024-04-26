import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../constants/color_constant.dart';
import '../constants/image_constant.dart';
import 'app_text.dart';

class CommonButton extends StatelessWidget {
  String? text;
  CommonButton({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Shadow color
            spreadRadius: 2, // Spread radius
            blurRadius: 4, // Blur radius
            offset: Offset(0, 2), // Offset from top-left
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            ConstantColor.gradiantDarkColor,
            ConstantColor.gradiantLightColor,
          ],
        ),
      ),
      alignment: Alignment.center,
      child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: AppText(
            text: text!,
            fontWeight: FontWeight.w700,
            textColor: Colors.white,
            fontSize: 0.018,
          )),
    );
  }
}
