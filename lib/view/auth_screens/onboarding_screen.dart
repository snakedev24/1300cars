import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user/view/auth_screens/login_screen.dart';
import 'package:user/widget/app_text.dart';
import '../../constants/color_constant.dart';
import '../../constants/image_constant.dart';
import '../../controller/splash_controller.dart';

class OnBoardingScreen extends StatelessWidget {
   OnBoardingScreen({super.key});


  final splashController =Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(

        children: [
          Image.asset(ConstantImage.onboarding, fit: BoxFit.fill, height: Get.height, width: Get.width,),

          Positioned(
            top:0,
            right: 0,
            child: Image.asset(ConstantImage.onboardingTop),
          ),




          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 50, 8, 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [


                SizedBox(height: Get.height*0.09),

                Center(child: Image.asset(ConstantImage.loginLogo,width: Get.width*0.7,)),

                Spacer(),
                AppText(text:"Where Help Meets\n in Australia" , textColor: Colors.white,fontWeight: FontWeight.w900,fontSize: 0.037,textAlign: TextAlign.center),

                SizedBox(height: Get.height*0.010),

                GestureDetector(
                  onTap: (){
                    // Get.to(LoginScreen());
                  },
                  child: Container(

                    decoration: BoxDecoration(

                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5), // Shadow color
                          spreadRadius: 2, // Spread radius
                          blurRadius: 4, // Blur radius
                          offset: Offset(0, 2), // Offset from top-left
                        ),
                      ],
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          ConstantColor.gradiantDarkColor,
                          ConstantColor.gradiantLightColor,

                        ],
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child:  Text('Let’s Get Started', style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white, fontSize: Get.height*0.018),),
                    ),
                  ),
                ),

                Container(
                  margin:  EdgeInsets.all(Get.height*0.025),
                )
              ],
            ),
          ),
        ],
      ),

    );


  }




}
