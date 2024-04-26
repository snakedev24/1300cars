

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:user/constants/image_constant.dart';
import 'package:user/widget/auth_comman_button.dart';
import '../../constants/color_constant.dart';
import '../../constants/string_constant.dart';
import '../../controller/update_profile_controller.dart';
import '../../widget/app_textfield.dart';

class UpdateProfileScreen extends StatelessWidget {
   UpdateProfileScreen({super.key});
  final updateProfileController=Get.put(UpdateProfileController());

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body: Column(
          children: [


            Container(
              height: Get.height*0.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(Get.height*0.015),bottomRight: Radius.circular(Get.height*0.015)),
                gradient: LinearGradient(
                  colors: [
                    ConstantColor.gradiantDarkColor,
                  ConstantColor.gradiantLightColor,
                  ],
                ),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding:  EdgeInsets.only(top: Get.height*0.03),
                    child: Image.asset(ConstantImage.profileBack,width: Get.width,fit: BoxFit.fill,),
                  ),
                  Column(
                    children: [
                      SizedBox(height: Get.height*0.06,),

                      Padding(
                        padding:  EdgeInsets.only(left: Get.width*0.02,right: Get.width*0.02),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: (){
                                Get.back();
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 6),
                                child: SvgPicture.asset(ConstantImage.back,height: Get.height*0.045,),
                              ),
                            ),
                            Text("Edit Profile",style: TextStyle(
                                color: Colors.white,
                                fontSize: Get.height*0.022,
                                fontWeight: FontWeight.w700,
                                fontFamily: ConstantString.fontbold
                            ),),
                            SizedBox(width: Get.width*0.08,),

                          ],
                        ),
                      ),
                      SizedBox(height: Get.height*0.02,),
                      Stack(
                        children: [
                          Container(
                              height: Get.height*0.1,
                              width: Get.width*0.2,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.white,width: 2),

                              ),
                              child:


                              ClipRRect(
                                  borderRadius: BorderRadius.circular(18),
                                  child:
                                  Obx(() => (updateProfileController.userProfileImage!.value.isNotEmpty )?
                                   Image.network(updateProfileController.userProfileImage!.value,fit: BoxFit.fill,)
                                      : Image.file(File( updateProfileController.selectedImagePath.value),fit: BoxFit.fill,)))
                          ),
                             Positioned(
                              top: -2,
                              right: 0,
                              child:  GestureDetector(
                                  onTap : (){
                                    updateProfileController.imagePickerOption();
                                  },

                                  child: SvgPicture.asset(ConstantImage.edit)),

                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: Get.height*0.025,),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding:  EdgeInsets.only(right: Get.width*0.04,left:Get.width*0.04, ),


                  child: Form(
                    key: updateProfileController.formKey,
                    child: Column(
                      children: [

                        SizedBox(height: Get.height * 0.016),

                        AppTextField(
                          validator: ((val) {
                            if (val!.isEmpty) {
                              return "Please enter Name";
                            }
                            return null;
                          }),
                          keyBoardType: TextInputType.text,
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          textController:
                          updateProfileController.nameController,
                          hintText: "Full Name",
                          textBorderColor: Colors.black,
                          textColor: Colors.black,
                        ),

                        SizedBox(height: Get.height * 0.016),

                        AppTextField(
                          validator: ((val) {
                            if (val!.isEmpty) {
                              return "Please enter Email Address";
                            }
                            return null;
                          }),
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          keyBoardType: TextInputType.emailAddress,
                          textController:
                          updateProfileController.emailController,
                          hintText: "Email Address",
                          textBorderColor: Colors.black,
                          textColor: Colors.black,
                          readOnly: true,
                        ),

                        SizedBox(height: Get.height * 0.016),

                        AppTextField(
                          validator: ((val) {
                            if (val!.isEmpty) {
                              return "Please enter Phone Number";
                            }
                            return null;
                          }),
                          minChar: 15,
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          keyBoardType: TextInputType.number,
                          textController: updateProfileController.phoneController,
                          hintText: "Phone Number",
                          textBorderColor: Colors.black,

                          textColor: Colors.black,
                            // inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                ),

                        SizedBox(height: Get.height * 0.016),

                        AppTextField(
                          validator: ((val) {
                            if (val!.isEmpty) {
                              return "Please enter Address";
                            }
                            return null;
                          }),
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          textController: updateProfileController.addressController,
                          hintText: "Address",
                          textBorderColor: Colors.black,
                          textColor: Colors.black,
                        ),

                        SizedBox(height: Get.height * 0.06),

                        GestureDetector(
                          onTap: (){
                            if (updateProfileController.formKey.currentState!.validate()) {
                              updateProfileController.edit();}
                          },
                          child: CommonButton(
                            text: ConstantString.saveChanges,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),

          ]
      ),
    );
  }
}
