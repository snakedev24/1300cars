import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:user/constants/color_constant.dart';
import 'package:user/constants/image_constant.dart';
import 'package:user/controller/setting_controller.dart';
import 'package:user/view/dashboard_screens/emergency_contacts_screen.dart';
import 'package:user/view/profile/membership_plan_screen.dart';
import '../../constants/string_constant.dart';
import '../../pref/shared_preference.dart';
import '../../widget/app_text.dart';
import '../../widget/app_textfield.dart';
import '../../widget/auth_comman_button.dart';

class SettingScreen extends StatefulWidget {
  SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final settingController=Get.put(SettingController());

  @override
  void initState() {
    super.initState();
    settingController. getReminder();
  }

  // RxBool? checkBox = false.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: Get.height * 0.05,
          ),
          ListTile(
            leading: GestureDetector(
              onTap: (){
                Get.back();
              },
              child: SvgPicture.asset(
                ConstantImage.back,
                height: Get.height * 0.05,
              ),
            ),
            title: AppText(
              text: "Account & Settings",
              fontSize: 0.02,
              fontWeight: FontWeight.w700,
              textAlign: TextAlign.center,
            ),
            trailing: Text(""),
          ),
          SizedBox(
            height: Get.height * 0.04,
          ),
          Padding(
            padding: EdgeInsets.only(
                left: Get.width * 0.02,
                right: Get.width * 0.03,
                bottom: Get.height * 0.01),
            child: Column(
              children: [
          //       GestureDetector(
          //         onTap :
          //       (){
          //           Get.to(MembershipScreen());
          // },
          //         child: Card(
          //           elevation: 2,
          //           color: Colors.white,
          //           child: ListTile(
          //             leading: SvgPicture.asset(ConstantImage.membershipIcon),
          //             contentPadding: EdgeInsets.only(
          //                 left: Get.width * 0.03, right: Get.width * 0.03),
          //             title: AppText(
          //               text: "Membership plans",
          //               fontWeight: FontWeight.w700,
          //               fontSize: 0.018,
          //             ),
          //             trailing: Icon(
          //               Icons.arrow_forward_ios_rounded,
          //               size: Get.height * 0.03,
          //               color: Colors.grey,
          //             ),
          //           ),
          //         ),
          //       ),
               (SharedPreference.getBool(ConstantString.socialLogin) == true)?


                  SizedBox(
                    height: Get.height * 0.01,
                  ):



                Column(
                  children: [
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    GestureDetector(
                      onTap: () {
                        settingController.oldPassword.clear();
                        settingController.newPassword.clear();
                        settingController.confPassword.clear();
                        settingController.obscureTextOldPassword = true.obs;
                        settingController.obscureTextNewPassword = true.obs;
                        settingController.obscureTextConfirmNewPassword = true.obs;
                        Get.bottomSheet(
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
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
                                  child: Form(
                                    key: settingController.validationFormKey,
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
                                            BorderRadius.all(Radius.circular(15)),
                                          ),
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.03,
                                        ),
                                        Text(
                                          "Password Change",
                                          style: TextStyle(
                                              fontFamily: ConstantString.fontbold,
                                              fontSize: Get.height * 0.022),
                                        ),
                                        SizedBox(height: Get.height * 0.03),

                                        Obx(()=> AppTextField(
                                          validator: (val) {
                                            if(val!.isEmpty){
                                              return "Old Password is required";
                                            }
                                          },
                                          keyBoardType: TextInputType.visiblePassword,
                                          obscureText:
                                          settingController.obscureTextOldPassword!.value,
                                          textController: settingController.oldPassword,
                                          hintText: ConstantString.password,
                                          maxLines: 1,
                                          textColor: Colors.black,
                                          suffixIcon: GestureDetector(
                                              onTap: () {
                                                settingController.obscureTextOldPassword!.value =
                                                !settingController.obscureTextOldPassword!.value;
                                              },
                                              child: Icon((settingController.obscureTextOldPassword!.value)
                                                  ? Icons.visibility_off
                                                  : Icons.visibility)),
                                        )),

                                        SizedBox(height: Get.height * 0.02),

                                        Obx(()=> AppTextField(
                                          validator: (val) {
                                            if(val!.isEmpty){
                                              return "New Password is required";
                                            }else if (val.length < 8) {
                                              return 'Password must be at least 8 characters long';
                                            }
                                          },
                                          keyBoardType: TextInputType.visiblePassword,
                                          obscureText:
                                          settingController.obscureTextNewPassword!.value,
                                          textController: settingController.newPassword,
                                          hintText: "New Password",
                                          maxLines: 1,
                                          textColor: Colors.black,
                                          suffixIcon: GestureDetector(
                                              onTap: () {
                                                settingController.obscureTextNewPassword!.value =
                                                !settingController.obscureTextNewPassword!.value;
                                              },
                                              child: Icon((settingController.obscureTextNewPassword!.value)
                                                  ? Icons.visibility_off
                                                  : Icons.visibility)),
                                        )),

                                        SizedBox(
                                          height: Get.height * 0.02,
                                        ),

                                        Obx(()=> AppTextField(
                                          validator: (val) {
                                            if(val!.isEmpty){
                                              return  "Confirm password is required";
                                            }
                                            else if (val.length < 8) {
                                              return 'Password must be at least 8 characters long';
                                            }
                                            return settingController.validateConfirmPassword(val);
                                          },
                                          keyBoardType: TextInputType.visiblePassword,
                                          maxLines: 1,
                                          obscureText:
                                          settingController.obscureTextConfirmNewPassword!.value,
                                          textController: settingController.confPassword,
                                          hintText: "Repeat New Password",
                                          textColor: Colors.black,
                                          suffixIcon: GestureDetector(
                                              onTap: () {
                                                settingController.obscureTextConfirmNewPassword!.value =
                                                !settingController.obscureTextConfirmNewPassword!.value;
                                              },
                                              child: Icon((settingController.obscureTextConfirmNewPassword!.value)
                                                  ? Icons.visibility_off
                                                  : Icons.visibility)),
                                        )
                                        ),



                                        SizedBox(
                                          height: Get.height * 0.02,
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              FocusScope.of(context).requestFocus(new FocusNode());
                                              if (settingController.validationFormKey.currentState!.validate()) {
                                                settingController.changePassword();
                                              }
                                            },
                                            child:
                                            CommonButton(text: "Save Password")),
                                        SizedBox(height: Get.height * 0.04),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          isScrollControlled: true,
                        );
                      },
                      child: Card(
                        elevation: 2,
                        color: Colors.white,
                        child: ListTile(
                          leading: SvgPicture.asset(ConstantImage.changePassword),
                          contentPadding: EdgeInsets.only(
                              left: Get.width * 0.03, right: Get.width * 0.03),
                          title: AppText(
                            text: "Change password",
                            fontWeight: FontWeight.w700,
                            fontSize: 0.018,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: Get.height * 0.03,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),

                  ],
                ),

                Card(
                  elevation: 2,
                  color: Colors.white,
                  child: ListTile(
                    leading: SvgPicture.asset(ConstantImage.reminderSetting),
                    contentPadding: EdgeInsets.only(
                        left: Get.width * 0.03, right: Get.width * 0.03),
                    title: AppText(
                      text: "Reminder setting",
                      fontWeight: FontWeight.w700,
                      fontSize: 0.018,
                    ),
                    trailing: Obx(() => GestureDetector(
                      onTap: (){

                      },

                      child: CupertinoSwitch(
                            onChanged: (bool? value) {
                              settingController.checkBox!.value = value!;
                              settingController.reminder();
                            },
                            value: settingController.checkBox!.value,
                            activeColor: ConstantColor.gradiantDarkColor,
                            trackColor: Colors.grey,
                          ),
                    )),
                  ),
                ),


                SizedBox(
                  height: Get.height * 0.01,
                ),

                GestureDetector(
                  onTap: (){
                    Get.to(EmergencyContactScreen());
                  },

                  child: Card(
                    elevation: 2,
                    color: Colors.white,
                    child: ListTile(
                      leading: SvgPicture.asset(ConstantImage.emergencyContacts),
                      contentPadding: EdgeInsets.only(
                          left: Get.width * 0.03, right: Get.width * 0.03),
                      title: AppText(
                        text: "Emergency contacts",
                        fontWeight: FontWeight.w700,
                        fontSize: 0.018,
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: Get.height * 0.03,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: Get.height * 0.01,
                ),

                GestureDetector(
                  onTap: (){
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
                                      BorderRadius.all(Radius.circular(15)),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.03,
                                  ),
                                  Text(
                                    "Delete your Account",
                                    style: TextStyle(
                                        fontFamily: ConstantString.fontbold,
                                        fontSize: Get.height * 0.022),
                                  ),
                                  SizedBox(height: Get.height * 0.025),
                                  Divider(),
                                  SizedBox(height: Get.height * 0.02),
                                  AppText(text:"You will lose of your data by deleting your account. This action cannot be undone",
                                  textColor: Colors.black,
                                    textAlign: TextAlign.center,
                                    fontSize: 0.015,
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.03,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                          onTap: () {
                                            Get.back();
                                          },
                                          child:
                                          Container(
                                            width: Get.width*0.4,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(Radius.circular(10)),
                                              border: Border.all(color: Colors.red),


                                            ),
                                            alignment: Alignment.center,
                                            child: Padding(
                                                padding: const EdgeInsets.all(16.0),
                                                child: AppText(
                                                  text: "Cancel",
                                                  fontWeight: FontWeight.w700,
                                                  textColor: Colors.red,
                                                  fontSize: 0.018,
                                                )),
                                          )),
                                      GestureDetector(
                                          onTap: () {
                                            settingController.deleteAccount();
                                          },
                                          child:
                                          Container(
                                            width: Get.width*0.4,
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
                                                  ConstantColor.lightRedColor,
                                                  ConstantColor.redColor,

                                                ],
                                              ),
                                            ),
                                            alignment: Alignment.center,
                                            child: Padding(
                                                padding: const EdgeInsets.all(16.0),
                                                child: AppText(
                                                  text: "Delete Account",
                                                  fontWeight: FontWeight.w700,
                                                  textColor: Colors.white,
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
                    );
                  },
                  child: Card(
                    elevation: 2,
                    color: Colors.white,
                    child: ListTile(
                      leading: SvgPicture.asset(ConstantImage.deleteAccount),
                      contentPadding: EdgeInsets.only(
                          left: Get.width * 0.03, right: Get.width * 0.03),
                      title: AppText(
                        text: "Delete Account",
                        fontWeight: FontWeight.w700,
                        fontSize: 0.018,
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: Get.height * 0.03,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
