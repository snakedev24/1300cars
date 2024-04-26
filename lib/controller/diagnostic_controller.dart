import 'package:get/get.dart';
import 'package:user/Model/DiagnosticModel.dart';

import '../network/api_provider.dart';

class DiagnosticController extends GetxController{

  RxList<Data> diagnosticList=<Data>[].obs;
  RxBool? loading=false.obs;

  void onInit() {
    super.onInit();
    diagnostic();
  }


  diagnostic() async{
    loading!.value=true;
    try{
      diagnosticList.clear();
      var response = await ApiProvider().diagnostictools();
      if ((response as DiagnosticModel).data != null){
        diagnosticList.addAll(response.data!);
        loading!.value=false;
      }
    }
finally {}
  }
}