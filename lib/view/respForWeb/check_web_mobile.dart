import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user/view/auth_screens/login_screen.dart';
import 'package:user/view/auth_screens/splash_screen.dart';

class CheckWebMobile extends GetResponsiveView{

  @override
  Widget? phone() {
    // TODO: implement phone
    return SplashScreen();
  }

  @override
  Widget? desktop() {
    // TODO: implement desktop
    return LoginScreen();
  }

}