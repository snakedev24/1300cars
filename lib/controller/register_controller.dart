import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:user/view/auth_screens/login_screen.dart';

import '../Model/RegisterModel.dart';
import '../network/api_provider.dart';
import '../view/dashboard_screens/dashboard_screen.dart';
import '../widget/error_message_toast.dart';
import '../widget/no_internet_screen.dart';

class RegisterController extends GetxController{


  TextEditingController nameController=TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController=TextEditingController();
  TextEditingController confirmPasswordController=TextEditingController();

  RxBool? obscureTextPassword = true.obs;
  RxBool? obscureTextConfirmPassword = true.obs;
  String name = "";
  String email = "";
  String password = "";
  String confirmPassword = "";
  final formKey = GlobalKey<FormState>();

  validateConfirmPassword(String value) {
    if(value.isEmpty){
      return "Confirm password is required";
    }
    else if (value != passwordController.text ) {
      return "Password & Confirm Passwords must be same";
    }
    return null;
  }

  validatePassword(String value) {
    if(value.isEmpty){
      return "Confirm password is required";
    }
    return null;
  }
  passwordValidation(String value){
    if(value.isEmpty){
      return "Password is required";
    }
    return null;
  }

  emailValidation(String value){
    if(value.isEmpty){
      return "Email is required";
    }else if(!GetUtils.isEmail(value)){
      return "Please enter valid email";
    }
    return null;
  }




  register() async{
    try{
      final connectivityResult = await (Connectivity().checkConnectivity());

      if (connectivityResult == ConnectivityResult.none) {
        return {
          Get.to(InternetLoss())
        };
      }


      var response = await ApiProvider().register(nameController.text, emailController.text, passwordController.text, confirmPasswordController.text);
      if((response as RegisterModel).statusCode == 200){
       nameController.clear();
       emailController.clear();
       passwordController.clear();
      confirmPasswordController.clear();

        Get.offAll(LoginScreen());
       toastMessage(response.message.toString());
      }else{
        toastMessage(response.message.toString());
      }
    }catch(e){
      print('Error in login(): $e');
    }
  }

}