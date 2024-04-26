import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:user/view/auth_screens/login_screen.dart';

import '../../constants/color_constant.dart';
import '../../constants/image_constant.dart';
import '../../constants/string_constant.dart';
import '../../controller/register_controller.dart';
import '../../widget/app_text.dart';
import '../../widget/app_textfield.dart';
import '../../widget/auth_comman_button.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final registerController = Get.put(RegisterController());
    return WillPopScope(


     child: Scaffold(

        body: SingleChildScrollView(
        child: Form(

        key: registerController.formKey,

          child: Stack(


            children: [

              Image.asset(ConstantImage.loginBg, fit: BoxFit.fill,height: Get.height, width: Get.width,),

              Padding(
                padding: const EdgeInsets.all(17.0),
                child: Column(
                  children: [


                    Column(
                      children: <Widget>[

                        SizedBox(height: Get.height*0.10,),

                        Image.asset(ConstantImage.loginLogo, height: Get.height*0.087),

                        SizedBox(height: Get.height*0.030,),

                        AppText(text: ConstantString.welcomeBack,
                          fontWeight: FontWeight.w900,
                          fontSize: 0.032,
                        ),

                        SizedBox(height: Get.height*0.008,),

                        AppText(text: ConstantString.registerText,
                          fontWeight: FontWeight.w400,
                          fontSize: 0.018,textColor: ConstantColor.light_black,textAlign: TextAlign.center,
                        ),

                        SizedBox(height: Get.height*0.018,),

                        AppTextField(
                            validator: (val) {
                              if (val!.isEmpty) return ConstantString.nameEnter;
                              registerController.name = val;
                            },
                            textInputAction: TextInputAction.next,
                            keyBoardType: TextInputType.text,
                            textController: registerController.nameController,
                            hintText: ConstantString.name,
                            textColor: Colors.black),

                        SizedBox(height: Get.height*0.025),

                        AppTextField(
                            validator: (val) {
                              return  registerController.emailValidation(val!);
                            },
                            textInputAction: TextInputAction.next,
                            keyBoardType: TextInputType.emailAddress,
                            textController: registerController.emailController,
                            hintText: ConstantString.emailAddress,
                            textColor: Colors.black),

                        SizedBox(height: Get.height * 0.025),

                        Obx(()=>
                            AppTextField(


                              validator: (value) {
                                final password = value!;
                                if (password.length < 8) {
                                  return 'Password must be at least 8 characters long';
                                }
                                return registerController.passwordValidation(value!);
                              },

                              textInputAction: TextInputAction.next,
                              keyBoardType: TextInputType.visiblePassword,
                              obscureText:
                              registerController.obscureTextPassword!.value,
                              textController: registerController.passwordController,
                              hintText: ConstantString.password,
                              textColor: Colors.black,
                                maxLines: 1,
                              suffixIcon: GestureDetector(
                                  onTap: () {
                                    registerController.obscureTextPassword!.value =
                                    !registerController
                                        .obscureTextPassword!.value;
                                  },
                                  child: Icon((registerController
                                      .obscureTextPassword!.value)
                                      ? Icons.visibility_off
                                      : Icons.visibility)),
                            )
                        ),

                        SizedBox(height: Get.height * 0.025),

                        Obx(()=>
                            AppTextField(
                              validator: (val) {
                                return registerController.validateConfirmPassword(val!);
                                },
                              // textInputAction: TextInputAction.next,
                              keyBoardType: TextInputType.visiblePassword,
                              obscureText:
                              registerController.obscureTextConfirmPassword!.value,
                              textController: registerController.confirmPasswordController,
                              hintText: ConstantString.confirmPassword,
                              textColor: Colors.black,
                                maxLines: 1,
                              suffixIcon: GestureDetector(
                                  onTap: () {
                                    registerController.obscureTextConfirmPassword!.value =
                                    !registerController
                                        .obscureTextConfirmPassword!.value;
                                  },
                                  child: Icon((registerController
                                      .obscureTextConfirmPassword!.value)
                                      ? Icons.visibility_off
                                      : Icons.visibility)),
                            )
                        ),

                        SizedBox(height: Get.height*0.025,),

                        GestureDetector(
                          onTap: (){
                            FocusManager.instance.primaryFocus?.unfocus();
                            if (registerController.formKey.currentState!.validate()) {
                              registerController.register();
                            }
                          },

                          child: CommonButton(text: ConstantString.signUp,),
                        ),

                        SizedBox(height: Get.height*0.040),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height:Get.height*0.075,
                              width: Get.width*0.4,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(Get.height * 0.008)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5), // Shadow color
                                    spreadRadius: 0.2, // Spread radius
                                    blurRadius: 4, // Blur radius
                                    offset: Offset(0, 2), // Offset from top-left
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(ConstantImage.googleLogo),

                                  SizedBox(
                                    width: Get.width * 0.015,
                                  ),
                                  AppText(
                                    text: ConstantString.google,
                                    fontWeight: FontWeight.w400,
                                    textColor: Colors.black,
                                    fontSize: 0.018,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(width: Get.width * 0.025),
                            Container(
                              height:Get.height*0.075,
                              width: Get.width*0.4,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(Get.height * 0.008)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5), // Shadow color
                                    spreadRadius: 0.2, // Spread radius
                                    blurRadius: 4, // Blur radius
                                    offset: Offset(0, 2), // Offset from top-left
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(ConstantImage.facebookLogo),
                                  SizedBox(width: Get.width * 0.015),
                                  AppText(
                                    text: ConstantString.facebook,
                                    fontWeight: FontWeight.w400,
                                    textColor: Colors.black,
                                    fontSize: 0.018,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: Get.height*0.030),

                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: ConstantString.alreadyHaveAccount,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: ConstantString.fontRegular,
                                  fontSize: Get.height * 0.016,
                                ),
                              ),
                              TextSpan(
                                text: ConstantString.signIn,
                                style: TextStyle(
                                  color: ConstantColor.greenDark,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: ConstantString.fontRegular,
                                  fontSize: Get.height * 0.016,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                  registerController.nameController.clear();
                                  registerController.emailController.clear();
                                  registerController.passwordController.clear();
                                  registerController.confirmPasswordController.clear();
                                    Get.off(LoginScreen());
                                  },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),

                  ],
                ),
              ),
            ],
          ),)
        ),
    ),

        onWillPop: () async {
          registerController.nameController.clear();
          registerController.emailController.clear();
          registerController.passwordController.clear();
          registerController.confirmPasswordController.clear();
          return true;
        },
    );

  }
}
