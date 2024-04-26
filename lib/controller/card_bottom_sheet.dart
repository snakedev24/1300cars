import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../Model/CardListModel.dart';
import '../Model/CardRegisterModel.dart';
import '../network/api_provider.dart';
import '../widget/error_message_toast.dart';

class CardBottomSheetController extends GetxController{

  TextEditingController holderNameConttoller = TextEditingController();
  TextEditingController accountnumberConttoller = TextEditingController();
  TextEditingController expireDateConttoller = TextEditingController();
  TextEditingController cvvConttoller = TextEditingController();
  RxBool? loading=false.obs;
  RxBool? obscureTextPassword = true.obs;
  String holderName = "";
  String accountnumber = "";
  String expireDate = "";
  String cvv = "";
  String month = "";
  String year = "";
  RxBool isChecked = false.obs;

  final formKey = GlobalKey<FormState>();
  RxList<Data> cardList = <Data>[].obs;

  validationExpire(String value) {
    if(value.isEmpty){
      return "Please enter a valid expiry date";
    }
    if(month!=null &&month!.length==2  ){
      if((int.parse( month.toString()) < 1) || (int.parse( month.toString()) > 12)) {
        return 'Expiry month is invalid';
      }
    }
    if(year!=null &&year!.length==2  ){
      if((int.parse( year.toString()) < 23)) {
        return 'Expiry year is invalid';
      }
    }
    return null;
  }

  cartRegister() async {
    try {
      var response = await
      ApiProvider().cardRegister(
          holderNameConttoller.text,
          accountnumberConttoller.text,
          expireDateConttoller.text,
          cvvConttoller.text,
          isChecked.value);
      if ((response as CardRegisterModel).statusCode == 201) {
        Get.back();
        holderNameConttoller.clear();
        accountnumberConttoller.clear();
        expireDateConttoller.clear();
        card();
      } else {
        toastMessage(response.message.toString());
      }
    } catch (e) {
      print('Error in login(): $e');
    }
  }

  card() async {
    loading!.value=true;
    try {
      cardList.clear();
      var response = await ApiProvider().cardList();
      if ((response as CardListModel).data != null) {
        cardList.addAll(response.data!);
        for(int i=0;i<cardList.length;i++){
          cardList[i].isChecked.value=cardList[i].isDefault!;
        }
        loading!.value=false;
      }
    } catch (e) {
      loading!.value=false;
    } finally {}
  }

  validationNumber(String value) {
    if(value.isEmpty){
      return "Please enter a Card Number";
    }
    else if (value.length > 16) {
      return "CVV is invalid";
    }
    return null;
  }
}

