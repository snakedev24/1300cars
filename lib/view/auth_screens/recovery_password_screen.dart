import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:user/view/auth_screens/login_screen.dart';
import 'package:user/view/auth_screens/register_screen.dart';
import 'package:user/view/dashboard_screens/dashboard_screen.dart';
import 'package:user/widget/app_text.dart';

import '../../constants/color_constant.dart';
import '../../constants/image_constant.dart';
import '../../constants/string_constant.dart';
import '../../controller/login_Controller.dart';
import '../../controller/recovery_password_controller.dart';
import '../../widget/app_textfield.dart';
import '../../widget/auth_comman_button.dart';

class RecoveryPasswordScreen extends StatelessWidget {
   RecoveryPasswordScreen({super.key});
  GlobalKey<FormState> formKeySignUp = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final recoveryPasswordController = Get.put(RecoveryPasswordController());
    return WillPopScope(

      child :Scaffold(

        body: SingleChildScrollView(
          child: Stack(


            children: [


              Image.asset(ConstantImage.loginBg, fit: BoxFit.fill,height: Get.height, width: Get.width,),

              Padding(
                padding: const EdgeInsets.all(17.0),
                child: Form(
                  key: formKeySignUp,
                  child: Column(
                    children: <Widget>[

                      SizedBox(height: Get.height*0.11,),

                      Image.asset(ConstantImage.loginLogo, height: Get.height*0.087),

                      SizedBox(height: Get.height*0.030,),

                      AppText(text:ConstantString.recoveryPassword,fontSize: 0.036,fontWeight: FontWeight.w900),

                      SizedBox(height: Get.height*0.010,),

                      AppText(text:   ConstantString.recoveryText,fontSize: 0.022,fontWeight: FontWeight.w400, textAlign: TextAlign.center,textColor: ConstantColor.light_black,),

                      SizedBox(height: Get.height*0.050,),

                      AppTextField(
                          validator: (val){
                            return recoveryPasswordController.emailValidation(val!);
                          },

                          keyBoardType: TextInputType.emailAddress,
                          textController: recoveryPasswordController.emailController,
                          hintText: ConstantString.emailAddress,
                          textColor: Colors.black),


                      SizedBox(height: Get.height*0.030,),


                      GestureDetector(

                        onTap: (){
                          if(formKeySignUp.currentState!.validate()) {
                            recoveryPasswordController.recoveryPassword();
                          }
                          // recoveryPasswordController.emailController.clear();
                        },


                        child: CommonButton(text: ConstantString.Continue),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )),

        onWillPop: () async {
          // recoveryPasswordController.emailController.clear();
      return true;
    },
    );


  }
}
