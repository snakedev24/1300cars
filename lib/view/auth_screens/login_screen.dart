import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/route_manager.dart';
import 'package:user/constants/color_constant.dart';
import 'package:user/constants/string_constant.dart';
import 'package:user/controller/login_Controller.dart';
import 'package:user/utils/GoogleAuthentication.dart';
import 'package:user/view/auth_screens/recovery_password_screen.dart';
import 'package:user/view/auth_screens/register_screen.dart';
import 'package:user/view/dashboard_screens/home_screen.dart';
import 'package:user/widget/app_text.dart';
import 'package:user/widget/app_textfield.dart';
import 'package:user/widget/auth_comman_button.dart';

import '../../constants/image_constant.dart';
import '../../pref/shared_preference.dart';
import '../../utils/facebookLogin.dart';
import '../dashboard_screens/dashboard_screen.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});
  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {

    return MediaQuery.removePadding(
      context: context,
      removeBottom: true,
      removeLeft: true,
      removeRight: true,
      removeTop: true,
      child: Scaffold(
          body: Stack(
            children: [
              Image.asset(
                ConstantImage.loginBg,
                fit: BoxFit.fill,
                height: Get.height,
                width: Get.width,
              ),
              SingleChildScrollView(
                child: Form(

                    key: loginController.formKey,

                  child: Padding(
                    padding: EdgeInsets.all(Get.height*0.027),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: Get.height * 0.1,
                        ),
                        Image.asset(ConstantImage.loginLogo,height: Get.height*0.087,),

                        SizedBox(height: Get.height * 0.030,),

                        AppText(text: ConstantString.welcomeBack, fontWeight: FontWeight.w900, fontSize: 0.036,),

                        SizedBox(height: Get.height * 0.010,),

                        AppText(
                          text: ConstantString.loginText,
                          fontWeight: FontWeight.w400,
                          fontSize: 0.018,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: Get.height * 0.050,
                        ),
                        AppTextField(
                            validator: (val) {
                              return loginController.emailValidation(val!);
                            },
                            textCapitalization :TextCapitalization.sentences,
                            keyBoardType: TextInputType.emailAddress,
                            textController: loginController.emailController,
                            hintText: ConstantString.emailAddress, textColor: Colors.black),

                        SizedBox(height: Get.height * 0.035),

                        Obx(()=> AppTextField(
                          validator: (val) {
                            if (val!.isEmpty) return ConstantString.enterPassword;
                            loginController.password = val;
                          },
                          keyBoardType: TextInputType.visiblePassword,
                          obscureText:
                          loginController.obscureTextPassword!.value,
                            textController: loginController.passwordController,
                            hintText: ConstantString.password,
                            textColor: Colors.black,
                          maxLines: 1,
                            suffixIcon: GestureDetector(
                                onTap: () {
                                  loginController.obscureTextPassword!.value =
                                  !loginController
                                      .obscureTextPassword!.value;
                                },
                                child: Icon((loginController
                                    .obscureTextPassword!.value)
                                    ? Icons.visibility_off
                                    : Icons.visibility)),
                        )),


                        SizedBox(
                          height: Get.height * 0.030,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                    Get.to(RecoveryPasswordScreen());
                                },
                                child: Text(
                                  ConstantString.recoveryPassword,
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      decorationColor: ConstantColor.greenDark,
                                      decorationStyle: TextDecorationStyle.solid,
                                      color: ConstantColor.greenDark,
                                      fontSize: Get.height * 0.016,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ]),
                        SizedBox(
                          height: Get.height * 0.060,
                        ),
                        GestureDetector(
                          onTap: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            if (loginController.formKey.currentState!.validate()) {
                              SharedPreference.setBool(ConstantString.guestUser, false);
                              loginController.login();

                            }

                          },
                          child: CommonButton(
                            text: ConstantString.signIn,
                          ),
                        ),
                        SizedBox(height: Get.height * 0.050),


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
                              child: GestureDetector(

                                onTap: (){
                                  SharedPreference.setBool(ConstantString.guestUser, false);
                                  Authentication.signInWithGoogle(context: context);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(ConstantImage.googleLogo),
                                    // Image.asset(ConstantImage.googleLogo),
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
                              child: GestureDetector(
                                onTap: (){
                                  SharedPreference.setBool(ConstantString.guestUser, false);
                                  FacebookLoginClass().loginWithFacebook();
                                },
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
                            ),
                          ],
                        ),

                        SizedBox(height: Get.height * 0.015),


                        GestureDetector(
                          onTap: (){
                            SharedPreference.setBool(ConstantString.guestUser, true);
                            loginController.guestUser == true;
                            Get.to(DashboardScreen()
                            );
                          },

                          child: AppText(
                            text: "Login as Guest",
                            fontWeight: FontWeight.w400,
                            textColor: Colors.black,
                            fontSize: 0.018,
                          ),
                        ),

                        SizedBox(height: Get.height * 0.020),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: ConstantString.dontHaveAny,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: ConstantString.fontRegular,
                                  fontSize: Get.height * 0.016,
                                ),
                              ),
                              TextSpan(
                                text: ConstantString.signUp,
                                style: TextStyle(
                                  color: ConstantColor.greenDark,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: ConstantString.fontRegular,
                                  fontSize: Get.height * 0.016,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                  loginController.emailController.clear();
                                  loginController.passwordController.clear();
                                   Get.to(RegisterScreen());
                                  },
                              ),
                            ],
                          ),
                        ),



                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
