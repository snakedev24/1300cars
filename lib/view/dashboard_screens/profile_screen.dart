import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:user/common/loginDialog.dart';

import 'package:user/constants/color_constant.dart';
import 'package:user/controller/update_profile_controller.dart';
import 'package:user/view/dashboard_screens/about_Screen.dart';
import 'package:user/view/dashboard_screens/terms_screen.dart';
import 'package:user/view/profile/diagnostic_tools_screen.dart';
import 'package:user/view/dashboard_screens/service_history_screen.dart';
import 'package:user/view/dashboard_screens/term_privacy_screen.dart';
import 'package:user/view/profile/payment_method_screen.dart';
import 'package:user/view/profile/setting_screen.dart';
import 'package:user/view/profile/update_profile_screen.dart';
import '../../constants/image_constant.dart';
import '../../constants/string_constant.dart';
import '../../controller/login_Controller.dart';
import '../../controller/profile_controller.dart';
import '../../pref/shared_preference.dart';
import '../../widget/app_text.dart';
import 'my_favorite_screen.dart';

class ProfileModel {
  String? title;
  String? image;
  ProfileModel({this.title,this.image});
}

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<ProfileModel> profileItem=[
    ProfileModel(title: "Edit profile",image:   ConstantImage.editIconProfile),
    ProfileModel(title: "Payment methods",image: ConstantImage.paymentMethod),
    ProfileModel(title: "My Favorite",image: ConstantImage.myFavorite),
    ProfileModel(title: "Diagnostic tools",image: ConstantImage.diadnosticTools),
    ProfileModel(title: "Service history",image: ConstantImage.serviceHistory),
    ProfileModel(title: "About",image: ConstantImage.aboutProfile),
    ProfileModel(title: "Terms of service",image: ConstantImage.termsService),
    ProfileModel(title: "Privacy policy",image: ConstantImage.privacyPolicy),
    ProfileModel(title: "Logout",image: ConstantImage.logoutProfile),
  ];

  final profileController = Get.put(ProfileController());

  final updateProfileController = Get.put(UpdateProfileController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateProfileController.profileImage!.value= SharedPreference.getString(ConstantString.profileImage)??"";
    updateProfileController.profileName!.value= SharedPreference.getString(ConstantString.nameSave)??"";
  }

  @override
  Widget build(BuildContext context) {
    final loginController = Get.put(LoginController());
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: Get.height*0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(Get.height*0.015),bottomRight: Radius.circular(Get.height*0.015)),
              gradient: LinearGradient(
                colors: [
                  ConstantColor.gradiantLightColor,
                  ConstantColor.gradiantDarkColor,
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
                    SizedBox(height: Get.height*0.05,),

                    Padding(
                      padding:  EdgeInsets.only(left: Get.width*0.02,right: Get.width*0.02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(width: Get.width*0.08,),
                          Text("Profile",style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontFamily: ConstantString.fontbold
                          ),),
                          GestureDetector(



                              onTap: (){
                                if((SharedPreference.getBool(ConstantString.guestUser) == true)){
                                  loginDialog();
                                }else{
                                  Get.to(SettingScreen());
                                }


                              },
                              child: Icon(Icons.settings,color: Colors.white,size: Get.height * 0.045,))
                        ],
                      ),
                    ),
                    SizedBox(height: Get.height*0.01,),

                    Stack(
                      children: [

                        Container(
                            height: Get.height*0.094,
                            width: Get.width*0.2,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.white,width: 2),

                            ),
                            child:   ClipRRect(
                                borderRadius: BorderRadius.circular(18),
                                child:
                                    Obx(() =>
                                (updateProfileController.profileImage!.value.isNotEmpty)?
                                Image.network(updateProfileController.profileImage!.value , fit: BoxFit.fill,):
                                Icon(Icons.person, size: Get.height*0.02,)
                                    )


                                // Image.asset(ConstantImage.back,fit: BoxFit.fill,)
                    )
                        ),

                      ],
                    ),
                    SizedBox(height: Get.height*0.02,),

                    Obx(() => AppText(text: updateProfileController.profileName!.value,
                      fontSize: 0.018, fontWeight: FontWeight.w700,fontFamily: ConstantString.fontbold,
                      textColor: Colors.white,), ),


                    SizedBox(height: Get.height*0.01,),


                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: Get.height*0.02,),

          Expanded(
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView.builder(
                  itemCount: profileItem.length,
                  shrinkWrap: true,
                  itemBuilder: (context,index){
                    return  Padding(
                      padding:  EdgeInsets.only(left: Get.width*0.02,right: Get.width*0.03,bottom: Get.height*0.01),
                      child: GestureDetector(
                        onTap: ()
                    {


                      switch (index) {
                        case 0:
                        if((SharedPreference.getBool(ConstantString.guestUser) == true)){
                    loginDialog();
                    }else{
                          Get.to(UpdateProfileScreen());}
                          break;
                        case 1:
                          if((SharedPreference.getBool(ConstantString.guestUser) == true)){
                    loginDialog();
                    }else{
                          Get.to(CardListScreen());}
                          break;

                        case 2:
                          if((SharedPreference.getBool(ConstantString.guestUser) == true)){
                    loginDialog();
                    }else{
                          Get.to(MyFavoriteScreen());}
                          break;


                        case 3:
                          if((SharedPreference.getBool(ConstantString.guestUser) == true)){
                    loginDialog();
                    }else{
                          Get.to(DiagnosticToolsScreen());}
                          break;


                        case 4:
                          if((SharedPreference.getBool(ConstantString.guestUser) == true)){
                    loginDialog();
                    }else{
                          Get.to(ServiceHistoryScreen());}

                          break;

                        case 5:

                          Get.to(AboutScreen());

                          break;

                        case 6:
                          Get.to(TermsScreen());

                          break;


                        case 7:
                          Get.to(TermPrivacyScreen());

                          break;
                        case 8:
                    if((SharedPreference.getBool(ConstantString.guestUser) == true)){
                    loginDialog();
                    }else{
                          Get.bottomSheet(
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(
                                    25.0), // Adjust the radius as needed
                                topRight: Radius.circular(
                                    25.0), // Adjust the radius as needed
                              ),
                              child: Container(
                                color: ConstantColor.backgroundColor,
                                child: SingleChildScrollView(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: Get.width * 0.05,
                                        right: Get.width * 0.05,
                                        top: Get.height * 0.01),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(height: Get.height * 0.02),
                                        Container(
                                          height: Get.height * 0.01,
                                          width: Get.width * 0.2,
                                          decoration: const BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius:
                                            BorderRadius.all(
                                                Radius.circular(15)),
                                          ),
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.03,
                                        ),
                                        Text(
                                          "Logout",
                                          style: TextStyle(
                                              fontFamily: ConstantString
                                                  .fontbold,
                                              fontSize: Get.height * 0.022),
                                        ),
                                        SizedBox(height: Get.height * 0.025),
                                        Divider(),
                                        SizedBox(height: Get.height * 0.02),
                                        AppText(
                                          text: "Are you sure you want to logout?",
                                          textColor: Colors.black,
                                          textAlign: TextAlign.center,
                                          fontSize: 0.015,
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.03,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            GestureDetector(
                                                onTap: () {
                                                  Get.back();
                                                },
                                                child:
                                                Container(
                                                  width: Get.width * 0.4,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius
                                                        .all(
                                                        Radius.circular(10)),
                                                    border: Border.all(
                                                        color: Colors.red),


                                                  ),
                                                  alignment: Alignment.center,
                                                  child: Padding(
                                                      padding: const EdgeInsets
                                                          .all(16.0),
                                                      child: AppText(
                                                        text: "Cancel",
                                                        fontWeight: FontWeight
                                                            .w700,
                                                        fontFamily: ConstantString
                                                            .fontbold,
                                                        textColor: Colors.red,
                                                        fontSize: 0.018,
                                                      )),
                                                )),
                                            GestureDetector(
                                                onTap: () {
                                                  loginController.logoutApi();
                                                },
                                                child:
                                                Container(
                                                  width: Get.width * 0.4,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius
                                                        .all(
                                                        Radius.circular(10)),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.5),
                                                        // Shadow color
                                                        spreadRadius: 2,
                                                        // Spread radius
                                                        blurRadius: 4,
                                                        // Blur radius
                                                        offset: Offset(0,
                                                            2), // Offset from top-left
                                                      ),
                                                    ],
                                                    gradient: LinearGradient(
                                                      begin: Alignment.topRight,
                                                      end: Alignment.bottomLeft,
                                                      colors: [
                                                        ConstantColor
                                                            .gradiantDarkColor,
                                                        ConstantColor
                                                            .gradiantLightColor,

                                                      ],
                                                    ),
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: Padding(
                                                      padding: const EdgeInsets
                                                          .all(16.0),
                                                      child: AppText(
                                                        text: "Yes, Logout",
                                                        fontWeight: FontWeight
                                                            .w700,
                                                        textColor: Colors.white,
                                                        fontFamily: ConstantString
                                                            .fontbold,
                                                        fontSize: 0.018,
                                                      )),
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: Get.height * 0.04),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            isScrollControlled: true,
                          );}


                          break;
                        default:
                        // Handle default case for other indices
                          break;
                      }

                        },
                        child: Card(
                          elevation: 2,
                          color: Colors.white,
                          child: ListTile(
                            contentPadding: EdgeInsets.only(left: Get.width*0.03, right: Get.width*0.03),
                            leading: SvgPicture.asset(profileItem[index].image!),
                            title: AppText(text: profileItem[index].title,fontWeight: FontWeight.w700,fontSize: 0.018,),
                            trailing: Icon(Icons.arrow_forward_ios_rounded,size: Get.height*0.017,),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          )
        ],
      ),
    );



  }
}


