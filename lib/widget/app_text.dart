import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user/constants/string_constant.dart';
class AppText extends StatelessWidget {
  String? text;
  Color? textColor;
  double? fontSize;
  String? fontFamily;
  FontWeight? fontWeight;
  TextAlign? textAlign;
  int? maxLines;
  TextOverflow? overflow;


  AppText({super.key,this.text,this.textColor,this.fontSize,this.fontFamily,this.fontWeight,this.textAlign, this.maxLines,this.overflow});

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      overflow: overflow,
      textAlign: textAlign??TextAlign.start,
      maxLines: maxLines,
      style: TextStyle(
        color: textColor??Colors.black,
        fontSize: Get.height*fontSize!,
        fontFamily: fontFamily??ConstantString.fontRegular,
        fontWeight: fontWeight??FontWeight.w500,
      ),
    );
  }
}
