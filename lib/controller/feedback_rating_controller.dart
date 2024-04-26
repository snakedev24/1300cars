import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../Model/AddEmeregencyModel.dart';
import '../Model/RatingModel.dart';
import '../network/api_provider.dart';
import '../widget/error_message_toast.dart';

class FeedbackRatingController extends GetxController {
  TextEditingController feedbackController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  // double userRating = 0;
  RxDouble userRating = 0.0.obs;

  addRating(id, String? idBooking) async{
    try{
      var response = await ApiProvider().rating(feedbackController.text, id, userRating.toInt(),idBooking);
      if((response as RatingModel).statusCode == 200){
        Get.back();
      }else{
        toastMessage(response.message.toString());
      }
    }catch(e){
      print('Error(): $e');
    }
  }
}