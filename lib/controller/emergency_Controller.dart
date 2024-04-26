import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:user/Model/AddEmeregencyModel.dart';
import 'package:user/Model/GetEmergencyModel.dart';

import '../Model/AddDefaultModel.dart';
import '../constants/string_constant.dart';
import '../network/api_provider.dart';
import '../pref/shared_preference.dart';
import '../widget/error_message_toast.dart';
import '../widget/no_internet_screen.dart';

class EmergencyController extends GetxController{

  final formKey = GlobalKey<FormState>();
  RxBool isChecked = false.obs;
  RxBool? loading=false.obs;

  String name = "";
  String number = "";

  TextEditingController nameConttoller = TextEditingController();
  TextEditingController numberConttoller = TextEditingController();

  RxList<Data> emergencyList=<Data>[].obs;


  addEmergencyContact() async{

    final connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      return {
        Get.to(InternetLoss())
      };
    }

    try{
      var response = await ApiProvider().addEmergencyContact(nameConttoller.text, numberConttoller.text);
      if((response as AddEmergencyModel).statusCode == 200){
        getEmergency();
        Get.back();
        nameConttoller.clear();
        numberConttoller.clear();

      }else{
        toastMessage("Error");
      }
    }catch(e){
      print('Error in login(): $e');
    }
  }

  getEmergency() async{
    loading!.value=true;
    try{
      emergencyList.clear();
      var response = await ApiProvider().getEmergency();
      if ((response as GetEmergencyModel).statusCode == 200){
        emergencyList.addAll(response.data!);
        loading!.value=false;
      }
    }
    finally {}
  }

  adddefault(int? id) async {
    try {
      var response = await ApiProvider().defaultContact(id);
      if ((response as AddDefaultModel).statusCode == 200){
        SharedPreference.setString(ConstantString.emergency, response.data!.phoneNumber.toString());

        getEmergency();
      }
    } catch (e) {
      print('Error : $e');
    }
  }

  String? validateContact(String value) {
    if (value.isEmpty) {
      return "Please enter Contact number";
    } else if (value.length < 5) {
      return "Phone number should be at least 5 digits";
    }return null;
  }

  String? validateContactNumber(String value) {
    if (value.length < 5) {
      return "Phone number should be at least 5 digits";
    }return null;
  }


  RxList<Data> foundContact=<Data>[].obs;

  @override
  void onInit() {
    super.onInit();
    getEmergency() ;
    foundContact = emergencyList;
  }



  void runFilter(String enteredKeyword) {
    RxList<Data> resultsEmpty = <Data>[].obs;
    if (enteredKeyword.isEmpty) {
      getEmergency() ;
    } else {
      resultsEmpty.value = emergencyList
          .where((user) => user.name!
          .toLowerCase()
          .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    // Obx(() {
      foundContact.value = resultsEmpty;
    // });
    // setState(() {});
  }
}