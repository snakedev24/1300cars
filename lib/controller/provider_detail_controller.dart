import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:user/Model/GoogleDetailModel.dart';
import 'package:user/view/dashboard_screens/appointments_screen.dart';
import '../Model/bookservicemodel.dart';
import '../common/cardBottomSheet.dart';
import '../network/api_provider.dart';
import '../widget/api_loader.dart';
import '../widget/error_message_toast.dart';
import 'home_controller.dart';

class ProviderDetailController extends GetxController{


  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController selectServiceController = TextEditingController();
  TextEditingController serviceDateController = TextEditingController();
  TextEditingController serviceTimeController = TextEditingController();
  TextEditingController discountController = TextEditingController();

  String name = "";
  String phoneno = "";
  String location = "";
  String date = "";
  String time = "";
  RxString googlenumber = "".obs;
  RxString distance ="".obs;
  RxInt ratingNo =0.obs;
  RxDouble ratingCount =0.0.obs;
  RxBool open = false.obs;
  bool openShopCheck=false;
  RxList<String> dayList = <String>[].obs;
  final formKey = GlobalKey<FormState>();

  RxList<String> selectedItems = <String>[].obs;
  RxList<String> priceItem = <String>[].obs;
  List<int> selectedID=[];
  var disconutVoucher = "";
  RxDouble? finalPrice = 0.0.obs;
  RxDouble? totalPrice=0.0.obs;
  RxInt? maximumPrice=0.obs;
  RxInt? getDiscount=0.obs;
  RxString discountName = "".obs;
  var priceGet="".obs;


  final homeController = Get.put(HomeController());

  serviceBooking(int? providerId) async{
    try{var response = await ApiProvider().serviceBooking(
        nameController.text,
          phoneNoController.text,
          locationController.text,
          serviceDateController.text,
          serviceTimeController.text,
          providerId,
        selectedID  ,
        disconutVoucher);
      if((response as BookServiceModel).statusCode == 201){
        Get.back();
        Get.back();
        Get.back();
        Get.to(AppointmentScreen());
      }else if   ( (response as BookServiceModel).statusCode == 404) {
        toastMessage("Add card Atleast one card then procced");
        commonCardBottomSheet();
      } else {
        toastMessage("This Coupon was expired");
      }
    }catch(e){
      print('Error : $e');
      CommonDialog.showLoading();
    }
  }

  String? validatePhoneNumber(String value) {
    if (value.isEmpty) {
      return "Phone number is required";
    } else if (value.length < 5) {
      return "Phone number should be at least 5 digits";
    }return null;
  }


  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    );

    if (pickedTime != null) {
      final TimeOfDay formattedTime = pickedTime;

      final DateTime now = DateTime.now();
      final DateTime selectedTime = DateTime(
        now.year,
        now.month,
        now.day,
        formattedTime.hour,
        formattedTime.minute,
      );

      final String formattedTimeString = DateFormat('hh:mm a').format(selectedTime);

      serviceDateController.text = formattedTimeString;
    } else {
      print("Time is not selected");
    }
  }

  // RxList<GoogleData> googleData=<GoogleData>[].obs;

  RxBool isLoader=false.obs;
  getGoogleDetail(String placeId, String latitude, String longitude) async{
    try{
      isLoader.value=true;
      var response = await ApiProvider().googleDetail(homeController.lat, homeController.long, placeId, latitude, longitude);
    if((response as GoogleDetailModel).statusCode == 200){


      distance.value =response.googleDetailData!.elementAt(1).rows!.elementAt(0).elements!.elementAt(0).distance!.text.toString();
      openShopCheck = response.googleDetailData!.first.result!.openingHours!.openNow.obs.value!;
      dayList.addAll(response.googleDetailData!.first.result!.openingHours!.weekdayText!);

      bool isFormattedPhoneNumberAvailable = response.googleDetailData!.any((data) =>
      data.result != null &&
          data.result!.formattedPhoneNumber != null &&
          data.result!.formattedPhoneNumber!.isNotEmpty);
      if (isFormattedPhoneNumberAvailable) {
        googlenumber.value = response.googleDetailData!.first.result!.formattedPhoneNumber!;
      } else {
        googlenumber.value = "";
      }



      bool isratingNo = response.googleDetailData!.any((data) =>
      data.result != null &&
          data.result!.userRatingsTotal != null
          // &&
          // data.result!.userRatingsTotal!.isNotEmpty
      );
      if (isratingNo) {
        ratingNo.value = response.googleDetailData!.first.result!.userRatingsTotal!;
      } else {
        ratingNo.value = 0;
      }


      bool isratingCount = response.googleDetailData!.any((data) =>
      data.result != null &&
          data.result!.rating != null
          // && data.result!.rating!.isNotEmpty
      );
      if (isratingCount) {
        ratingCount.value = response.googleDetailData!.first.result!.rating!;
      } else {
        ratingCount.value = 0;
      }




      isLoader.value=false;
    } else {
      toastMessage("Error");
    }
    }catch(e){
      print('Error : $e');
      isLoader.value=false;
    }
  }
}