import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:user/Model/GoogleListModel.dart';
import 'package:user/Model/ServiceListModel.dart';
import '../Model/FavoriateModel.dart';
import '../Model/NewServiceListModel.dart';
import '../network/api_provider.dart';
import '../widget/error_message_toast.dart';

class ServiceListController extends GetxController{

  RxList<Data> mainServiceList=<Data>[].obs;
  int? selectedServiceId;

  RxBool? loading=false.obs;
  RxBool? checkSearchField=false.obs;
  RxList<Data> foundService=<Data>[].obs;

  @override
  void onInit() {
    super.onInit();
    foundService = mainServiceList;
    _determinePosition();
  }

  // RxList<GoogleData> googleData=<GoogleData>[].obs;

  allListService(String lat, String long, String? search) async{
    loading!.value=true;
    try {
      mainServiceList.clear();
      List id=[selectedServiceId];
      var response = await ApiProvider().mainServiceList(id,lat, long, search);

      if ((response as ServiceListModel).statusCode == 200){
          mainServiceList.clear();
          mainServiceList.addAll(response.data!);
          for(int i=0;i<mainServiceList.length;i++){
            mainServiceList[i].heartClick!.value =mainServiceList[i].isFav!;
          }
          loading!.value=false;
      }
    } catch (e) {
      loading!.value=false;
      print("Error in list: $e");
    }
  }



  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }


    return await Geolocator.getCurrentPosition();
  }


  void launchMapsUrl(double lat, double long) async {
    final availableMaps = await MapLauncher.installedMaps;

    // Choose the map provider you want to use
    // For example, here we are using Google Maps
    if (availableMaps.isNotEmpty) {
      await availableMaps[0].showMarker(
        coords: Coords(lat, long),
        title: "Destination",
      );
    }
  }


  // Future<void> launchMapsUrl(double lat, double long) async {
  //   String googleMapUrl = "https://www.google.com/maps/search/?api=1&query=$lat,$long";
  //   print('Google Map URL: $googleMapUrl'); // Check if the URL is generated correctly
  //   try {
  //     if (await canLaunch(googleMapUrl)) {
  //       print('Launching Google Maps...'); // Check if attempting to launch
  //       await launch(googleMapUrl);
  //     } else {
  //       print('Could not launch $googleMapUrl');
  //     }
  //   } catch (e) {
  //     print('Error launching Google Maps: $e');
  //   }
  // }



  // Future<void> launchMapsUrl(double lat,double long)async{
  //   String googleMapUrl="https://www.google.com/maps/search/?api=1&query=$lat,$long";
  //   try {
  //     if (await canLaunch(googleMapUrl)) {
  //       await launch(googleMapUrl);
  //     } else {
  //       throw 'Could not launch $googleMapUrl';
  //     }
  //   } catch (e) {
  //     print('Error launching Google Maps:: $e');
  //   }
  // }



  favourite(int? id) async{
    try{
      var response = await ApiProvider().favoriate(id);
      if((response as FavouriteModel).statusCode == 200){
        // toastMessage("Success");
      }else{
        toastMessage("Error");
      }
    }catch(e){
      print('Error in login(): $e');
    }
  }



}