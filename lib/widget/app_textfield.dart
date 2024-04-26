import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../constants/string_constant.dart';

class AppTextField extends StatelessWidget {
  List<TextInputFormatter>?  inputFormatters;
  final TextEditingController textController;
  final TextInputAction? textInputAction;
  final TextCapitalization? textCapitalization;
  final TextInputType? keyBoardType;
  final AutovalidateMode? autoValidateMode;
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? suffix;
  final Color textColor;
  final bool? obscureText;
  final VoidCallback? callbackSuffix;
  final VoidCallback? callback;
  final FormFieldValidator<String>? validator;
  bool? readOnly;
  int? minChar;
  final ValueChanged<String>? onChanged;
  final Color? textBorderColor;
  final Color? textFieldLight;
  final Color? textFieldDark;
  final Color? textColorHint;
  final double? fontSize;
  int? maxLines;

  AppTextField(
      {Key? key, this.inputFormatters,
        this.textCapitalization,

      this.keyBoardType,
      this.autoValidateMode,
      this.textInputAction,
      required this.textController,
      required this.hintText,
      this.prefixIcon,
      this.suffixIcon,
      required this.textColor,
      this.obscureText,
      this.callbackSuffix,
      this.suffix,
      this.validator,
      this.readOnly,
      this.minChar,
      this.onChanged,
      this.textBorderColor,
      this.textFieldLight,
      this.textFieldDark,
      this.textColorHint,
        this.callback,
        this.maxLines,
        this.fontSize
      })
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(

      onTap: callback,
      textCapitalization: textCapitalization??TextCapitalization.words,
      inputFormatters : inputFormatters,
      keyboardType: keyBoardType,
      readOnly: readOnly ?? false,
      textAlign: TextAlign.start,
      maxLength: minChar,
      autovalidateMode: autoValidateMode,
      validator: validator,
      textInputAction: textInputAction,
      onChanged: onChanged,
      obscureText: obscureText ?? false,
      controller: textController,
      maxLines: maxLines,
      style: TextStyle(
        color: textColor,
        fontSize: Get.height * (fontSize??0.018),
        fontFamily: ConstantString.fontRegular,
      ),
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey),
        ),
        counterText: '',
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey),
        ),
        hintText: hintText,
        hintStyle: TextStyle(
            color: textColorHint ?? Colors.grey,
            fontSize: Get.height *0.018 ,
            fontWeight: FontWeight.w400,
            fontFamily: ConstantString.fontRegular),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,

        contentPadding: EdgeInsets.symmetric(
            vertical: Get.height * 0.022, horizontal: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
      ),
    );
  }
}
