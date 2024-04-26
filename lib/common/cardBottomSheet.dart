import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../constants/color_constant.dart';
import '../constants/string_constant.dart';
import '../controller/card_bottom_sheet.dart';
import '../widget/app_textfield.dart';
import '../widget/auth_comman_button.dart';


final bottomController=Get.put(CardBottomSheetController());

Future<dynamic> commonCardBottomSheet() {
  return Get.bottomSheet(
    ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25.0), // Adjust the radius as needed
        topRight: Radius.circular(25.0), // Adjust the radius as needed
      ),
      child: Container(
        color: ConstantColor.backgroundColor,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: Get.width * 0.05,
                right: Get.width * 0.05,
                top: Get.height * 0.01),
            child: Form(
              key: bottomController.formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  SizedBox(height: Get.height * 0.02),

                  Container(
                    height: Get.height * 0.01,
                    width: Get.width * 0.2,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),),
                  SizedBox(height: Get.height * 0.03,),

                  Text("Add new card", style: TextStyle(
                      fontFamily: ConstantString.fontbold, fontSize: Get
                      .height * 0.025),),

                  SizedBox(height: Get.height * 0.03),

                  AppTextField(validator: (val) {
                    if (val!.isEmpty) return "Enter Name";
                    bottomController.holderName = val;
                  },
                      textController: bottomController.holderNameConttoller,
                      hintText: 'Name on card',
                      textColor: ConstantColor.light_black),


                  SizedBox(height: Get.height * 0.02),


                AppTextField(
                  validator: (val) {
                    if (val!.isEmpty) return bottomController.validationNumber(val!);
                    bottomController.accountnumber = val;
                  },
                  keyBoardType: TextInputType.number,
                  minChar: 16,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    // Allow only digits
                  ],

                  textController: bottomController.accountnumberConttoller,
                  hintText: 'Card number',
                  textColor: ConstantColor.light_black,
                  onChanged: (value) {
                    value = value.replaceAll(RegExp(r"\D"), ""); // Remove non-digit characters
                    final formattedValue = <String>[];
                    for (int i = 0; i < value.length; i += 4) {
                      final endIndex = i + 4;
                      if (endIndex <= value.length) {
                        formattedValue.add(value.substring(i, endIndex));
                      } else {
                        formattedValue.add(value.substring(i));
                      }
                    }
                    bottomController.accountnumberConttoller.text = formattedValue.join('-');
                    bottomController.accountnumber = value; // Store the original value
                  },
                ),


                // AppTextField(
                //       validator: (val) {
                //         if (val!.isEmpty) return
                //           bottomController.validationNumber(val!);
                //         bottomController.accountnumber = val;
                //       },
                //       minChar: 16,
                //       inputFormatters: [
                //         FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                //         // Allow only digits
                //       ],
                //
                //
                //       keyBoardType: TextInputType.number,
                //       textController: bottomController
                //           .accountnumberConttoller,
                //       hintText: 'Card number',
                //       textColor: ConstantColor.light_black),

                  SizedBox(height: Get.height * 0.02),


                  AppTextField(
                    validator: (val) {
                      return bottomController.validationExpire(val!);
                    },

                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      // Allow only digits
                    ],

                    keyBoardType: TextInputType.number,
                    textController: bottomController.expireDateConttoller,
                    hintText: 'Card Expire Date',
                    textColor: ConstantColor.light_black,
                    onChanged: (value) {
                      value = value.replaceAll(RegExp(r"\D"), "");
                      switch (value.length) {
                        case 0:
                          bottomController.expireDateConttoller.text =
                          "MM/YY";
                          bottomController.expireDateConttoller.selection =
                              TextSelection.collapsed(offset: 0);
                          break;
                        case 1:
                          bottomController.expireDateConttoller.text =
                          "${value}M/YY";
                          bottomController.expireDateConttoller.selection =
                              TextSelection.collapsed(offset: 1);
                          break;
                        case 2:
                          bottomController.expireDateConttoller.text =
                          "$value/YY";
                          bottomController.expireDateConttoller.selection =
                              TextSelection.collapsed(offset: 2);
                          break;
                        case 3:
                          bottomController.expireDateConttoller.text =
                          "${value.substring(0, 2)}/${value.substring(2)}Y";
                          bottomController.expireDateConttoller.selection =
                              TextSelection.collapsed(offset: 4);
                          break;
                        case 4:
                          bottomController.expireDateConttoller.text =
                          "${value.substring(0, 2)}/${value.substring(
                              2, 4)}";
                          bottomController.expireDateConttoller.selection =
                              TextSelection.collapsed(offset: 5);
                          break;
                      }
                      if (value.length > 3) {
                        bottomController.expireDateConttoller.text =
                        "${value.substring(0, 2)}/${value.substring(2, 4)}";
                        bottomController.expireDateConttoller.selection =
                            TextSelection.collapsed(offset: 5);
                        bottomController.month = value.substring(0, 2);
                        bottomController.year = value.substring(2, 4);
                      }
                    },),

                  SizedBox(height: Get.height * 0.02,),

                  GestureDetector(
                      onTap: () {
                        if (bottomController.formKey.currentState!.validate()) {
                          bottomController.cartRegister();
                        }
                      },
                      child: CommonButton(text: "Add Card")),

                  SizedBox(height: Get.height * 0.02),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
    isScrollControlled: true,
  );
}


