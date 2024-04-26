import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:user/Model/RecoveryPasswordModel.dart';
import 'package:user/view/auth_screens/login_screen.dart';

import '../constants/string_constant.dart';
import '../network/api_provider.dart';
import '../pref/shared_preference.dart';
import '../widget/error_message_toast.dart';

class RecoveryPasswordController extends GetxController{



  TextEditingController emailController = TextEditingController();
  String email = "";
  final formKey = GlobalKey<FormState>();
  recoveryPassword() async{
    try{
      var response = await ApiProvider().recoveryPassword(emailController.text);
      if ((response as RecoveryPasswordModel).statusCode == 200) {
        Get.offAll(LoginScreen());
        toastMessage(response.message.toString());
      }else{
        toastMessage(response.message.toString());
      }
    }catch(e){
      print('Error : $e');
    }
  }

  emailValidation(String value){
    if(value.isEmpty){
      return "Email is required";
    }else if(!GetUtils.isEmail(value)){
      return "Please enter valid email";
    }
    return null;
  }



}