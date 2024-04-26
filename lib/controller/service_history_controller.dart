import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:user/Model/ServiceHistoryModel.dart';

import '../network/api_provider.dart';

class ServiceHistoryController extends  GetxController{


  RxList<Data> serviceHistoryList=<Data>[].obs;
  RxBool? loading = false.obs;

  void onInit() {
    super.onInit();
    loading!.value = false;
    getServiceHistory("blank");
  }


  getServiceHistory(String service) async{
    loading!.value = true;
    try{
      serviceHistoryList.clear();
      var response = await ApiProvider().serviceHistory(service);
      if ((response as ServiceHistoryModel).statusCode == 200){
        serviceHistoryList.addAll(response.data!);
        loading!.value = false ;
      }
    }catch(e){
      print("$e");
    }
  }


  String convert12HourTo24Hour(String date) {
    final inputFormat = DateFormat('yyyy-MM-dd');
    final outputFormat = DateFormat("MMM d yyyy");
    final dateTime = inputFormat.parse(date);
    final time24Hour = outputFormat.format(dateTime);
    return time24Hour;
  }

}