

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:user/view/auth_screens/login_screen.dart';
import 'package:user/view/dashboard_screens/dashboard_screen.dart';

import '../constants/string_constant.dart';
import '../pref/shared_preference.dart';
import '../view/auth_screens/onboarding_screen.dart';

class SplashController extends GetxController{

  @override
  void onInit() {
    Future.delayed(const Duration(milliseconds: 1000), () async{
      String? userStatus= SharedPreference.getString(ConstantString.userLogin)??"";
      if(userStatus.isNotEmpty){
          return Get.offAll(DashboardScreen());
        }else{
          return Get.offAll(LoginScreen());
      }
    });

    super.onInit();
  }
}

