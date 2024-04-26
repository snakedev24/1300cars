
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:user/Model/LogoutModel.dart';
import 'package:user/controller/splash_controller.dart';
import 'package:user/controller/update_profile_controller.dart';
import 'package:user/network/api_provider.dart';

import '../Model/LoginModel.dart';
import '../Model/SocialLoginModel.dart';
import '../constants/string_constant.dart';
import '../pref/shared_preference.dart';
import '../utils/firebase_api.dart';
import '../view/auth_screens/login_screen.dart';
import '../view/dashboard_screens/dashboard_screen.dart';
import '../widget/error_message_toast.dart';
import '../widget/no_internet_screen.dart';


class LoginController extends GetxController{


  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();

  RxBool? obscureTextPassword=true.obs;
  String password = "";
  String email = "";
  final formKey = GlobalKey<FormState>();
  RxBool? guestUser = false.obs;

  emailValidation(String value){
    if(value.isEmpty){
      return "Email is required";
    }else if(!GetUtils.isEmail(value)){
      return "Please enter valid email";
    }
    return null;
  }

  login() async{
    try{
      final connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        return {
          Get.to(InternetLoss())
        };
      }
      await FireBaseApi().initNotification();
      await FireBaseApi().setup();
      var fcmToken = SharedPreference.getString("fcmToken");
      var response = await ApiProvider().login(emailController.text, passwordController.text,fcmToken);
      if ((response as LoginModel).statusCode ==200 ) {
        SharedPreference.setString(ConstantString.accessToken, response.data!.access.toString());
        SharedPreference.setString(ConstantString.userId, response.data!.userId.toString());
        SharedPreference.setString(ConstantString.nameSave, response.data!.name.toString());
        SharedPreference.setString(ConstantString.profileImage, response.data!.image.toString());
        SharedPreference.setString(ConstantString.emergency, response.data!.isEmergency.toString());
        SharedPreference.setBool(ConstantString.socialLogin, (response.data!.socialLogin==true)?true:false);
        SharedPreference.setString(ConstantString.userLogin, "UserLogin");
        Get.offAll(DashboardScreen());

      }else if((response as LoginModel).statusCode ==203) {
      toastMessage(response.message.toString());
      }else{
        toastMessage(response.message.toString());
      }
    }catch(e){
      print('Error in login(): $e');
    }
  }

  logoutApi() async{
    try{
      final connectivityResult = await (Connectivity().checkConnectivity());

      if (connectivityResult == ConnectivityResult.none) {
        return {
          Get.to(InternetLoss())
        };
      }
      var response = await ApiProvider().logout();
      if ((response as LogoutModel).statusCode ==200 ) {
        logout();
        Get.offAll(LoginScreen());
      }else{
        toastMessage(response.message.toString());
      }
    }catch(e){
      print('Error in login(): $e');
    }
  }

  void logout(){
    SharedPreference.setString(ConstantString.userLogin , "");
    SharedPreference.setString(ConstantString.accessToken, "");
    SharedPreference.setString(ConstantString.userId, "");
    SharedPreference.setString(ConstantString.nameSave, "");
    SharedPreference.setString(ConstantString.profileImage, "");
    SharedPreference.setString(ConstantString.emergency, "");
    Get.offAll(LoginScreen());
  }

  socialLogin(String? userName, String userEmail, String? imageUrl) async{
    try{
      await FireBaseApi().initNotification();
      await FireBaseApi().setup();
      var fcmToken =SharedPreference.getString("fcmToken");
      var response = await ApiProvider().socialLogin(userName, userEmail ,"" ,fcmToken );
      if ((response as SocialLoginModel).statusCode ==200 ) {
        SharedPreference.setString(ConstantString.accessToken, response.data!.access.toString());
        SharedPreference.setString(ConstantString.userId, response.data!.userId.toString());
        SharedPreference.setString(ConstantString.nameSave, response.data!.name.toString());
        SharedPreference.setString(ConstantString.profileImage, response.data!.image.toString());
        SharedPreference.setString(ConstantString.emergency, response.data!.isEmergency.toString());
        SharedPreference.setBool(ConstantString.socialLogin, (response.data!.socialLogin==true)?true:false);
        SharedPreference.setString(ConstantString.userLogin, "UserLogin");
        Get.offAll(DashboardScreen());
      }else if((response as SocialLoginModel).statusCode ==203) {
        toastMessage(response.message.toString());
      }else{
        toastMessage(response.message.toString());
      }
    }catch(e){
      print('Error in login(): $e');
    }
  }
}

