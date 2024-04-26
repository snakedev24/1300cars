import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:user/Model/CardListModel.dart';
import 'package:user/Model/ChangeCardStatusModel.dart';
import 'package:user/Model/DeleteCardModel.dart';
import 'package:user/widget/api_loader.dart';

import '../Model/CardRegisterModel.dart';
import '../network/api_provider.dart';
import '../widget/error_message_toast.dart';

class CardController extends GetxController {
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

        // FocusScope.of(BuildContext).unfocus();
        holderNameConttoller.clear();
        accountnumberConttoller.clear();
        expireDateConttoller.clear();
        Get.back();
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
      return "Number is invalid";
    }
    return null;
  }

  validationCvv(String value) {
    if(value.isEmpty){
      return "Please enter a valid cvv";
    }
    if (value.length < 3 || value.length >= 5) {
      return "CVV is invalid";
    }
    return null;
  }

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

  deleteCard(String id) async{
    try{
      var response = await ApiProvider().deleteCard(id);
      if ((response as DeleteCardModel ).statusCode == 204 ) {
      }
    }catch(e){
      print('Error in login(): $e');
    }
  }

  changeCardStatus(bool value, int? id) async {
    try {
      var response = await ApiProvider().defaultCard(value,id);
      if ((response as ChangeCardStatusModel).statusCode == 201 ){
        card();
      }else{

      }
    } catch (e) {
      print('Error in login(): $e');
    }
  }

}
