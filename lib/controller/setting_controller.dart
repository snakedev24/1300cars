import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:user/Model/ChangeAccountModel.dart';
import 'package:user/Model/ReminderModel.dart';
import 'package:user/Model/delete_account_model.dart';
import 'package:user/view/auth_screens/login_screen.dart';
import 'package:user/widget/error_message_toast.dart';

import '../constants/string_constant.dart';
import '../network/api_provider.dart';
import '../pref/shared_preference.dart';

class SettingController extends GetxController{
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confPassword = TextEditingController();
  GlobalKey<FormState> validationFormKey = GlobalKey<FormState>();
  RxBool? checkBox = false.obs;

  String oldPasswordString = "";
  String passwordString = "";
  String confirmPasswordString = "";


  RxBool? obscureTextOldPassword=true.obs;
  RxBool? obscureTextNewPassword=true.obs;
  RxBool? obscureTextConfirmNewPassword=true.obs;

  validateConfirmPassword(String value) {
    if(value.isEmpty){
      return "Confirm password is required";
    }
    else if (value != newPassword.text ) {
      return "Password & Confirm Passwords must be same";
    }
    return null;
  }
  deleteAccount() async{
    try{

      var response = await ApiProvider().deleteAccount();
      if((response as DeleteAccount).successCode==204){
        SharedPreference.setString(ConstantString.userLogin , "");
        SharedPreference.setString(ConstantString.accessToken, "");
        SharedPreference.setString(ConstantString.userId, "");
        SharedPreference.setString(ConstantString.nameSave, "");
        SharedPreference.setString(ConstantString.profileImage, "");
        SharedPreference.setString(ConstantString.emergency, "");
        Get.offAll(LoginScreen());
        toastMessage(response.message!);

        // Get.offAll(LoginScreen());
      }
    }
    catch(e){

    }finally {}
  }

  changePassword() async{
    try{
      var response = await ApiProvider().changePassword(oldPassword.text, newPassword.text, confPassword.text);
      if((response as ChangeAccountModel).statusCode==200){
        Get.back();
        oldPassword.clear();
        newPassword.clear();
        confPassword.clear();
        toastMessage(response.message!);

      }else{
        toastMessage(response.message!);
      }
    }
    catch(e){
      toastMessage("$e");
    }finally {}
  }

  reminder() async {
    try {
      var response = await ApiProvider().reminderSetting(checkBox!.value);
      if ((response as ReminderModel).statusCode == 200 ){
        // toastMessage("Done");
      }else{
        // toastMessage("error");
      }
    } catch (e) {
      print('Error in login(): $e');
    }
  }

  getReminder() async {
    try {
      var response = await ApiProvider().getReminder();
      if ((response as ReminderModel).statusCode == 200 ){
        checkBox!.value = response.data!.isReminder!;
      }else{
        print('Error');
      }
    } catch (e) {
      print('Error in login(): $e');
    }
  }



}