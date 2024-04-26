import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

import '../Model/StaticDataModel.dart';
import '../constants/string_constant.dart';
import '../network/api_provider.dart';
import '../pref/shared_preference.dart';

class ProfileController extends GetxController{


  @override
  void onInit() {
    super.onInit();


    if((SharedPreference.getBool(ConstantString.guestUser) == false)) {
      privacyPolicy();
      terms();
      about();
    }

  }




  RxString? privacyText="".obs;
  RxString? termText="".obs;
  RxString? aboutText="".obs;




  privacyPolicy() async {
    try {
      var response = await ApiProvider().getPrivacy();
      if ((response as StaticDataModel).statusCode == 200) {
        privacyText!.value =response.data!.content!;
      }
    } catch(e){
      print("$e");
    }
  }

  terms() async {

    try {
      var response = await ApiProvider().term();
      if ((response as StaticDataModel).statusCode == 200) {
        termText!.value =response.data!.content!;

      }
    } catch(e){
      print("$e");
    }
  }


  about() async {

    try {
      var response = await ApiProvider().about();
      if ((response as StaticDataModel).statusCode == 200) {
        aboutText!.value =response.data!.content!;
      }
    } catch(e){
      print("$e");
    }
  }

}