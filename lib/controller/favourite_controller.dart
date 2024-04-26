import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:user/widget/error_message_toast.dart';

import '../Model/NewServiceListModel.dart';
import '../Model/ServiceListModel.dart';
import '../network/api_provider.dart';
import '../widget/no_internet_screen.dart';

class FavouriteController extends GetxController{
  RxList<Data> favoriateList = <Data>[].obs;
  RxBool? loading=false.obs;



  favoriate() async {


    final connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      return {
        Get.to(InternetLoss())
      };
    }
    loading!.value=true;
    try {
      favoriateList.clear();
      var response = await ApiProvider().favoriateList();
      if ((response as ServiceListModel).statusCode == 200) {
        favoriateList.addAll(response.data!);
        loading!.value=false;
      }
    } catch (e) {
      loading!.value=false;
      // toastMessage("$e");
      print("Error in favoriate method: $e");
    }
  }
}