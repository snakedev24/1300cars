import 'dart:async';
import 'package:app_settings/app_settings.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:user/widget/error_message_toast.dart';
import '../Model/ServiceModel.dart';
import '../Model/pormotion_model.dart';
import '../constants/string_constant.dart';
import '../network/api_provider.dart';
import '../pref/shared_preference.dart';
import '../utils/firebase_api.dart';
import '../widget/no_internet_screen.dart';


class HomeController extends GetxController {
  CarouselController buttonCarouselController = CarouselController();
  RxInt current = 0.obs;
  RxInt changeValue = 0.obs;
  RxBool checkClick = false.obs;
  RxBool? loading=false.obs;

  RxList<ServiceData> serviceList=<ServiceData>[].obs;
  RxList<Data> imageCarousel=<Data>[].obs;

  void makeEmergencyCall() async {
    String? emergencyNumber = SharedPreference.getString(ConstantString.emergency);

    if (emergencyNumber != "null" ) {
      Uri phoneNumber = Uri.parse("tel:$emergencyNumber");
      await launchUrl(phoneNumber);
    } else {
      toastMessage("Please add an Emergency Number");
    }
  }

  service() async{
    loading!.value=true;
    try{
      serviceList.clear();
      var response = await ApiProvider().serviceList();
      if ((response as ServiceModel).status == 200){

        serviceList.addAll(response.data!);
        loading!.value=false;
        // await FireBaseApi().initNotification();
        // await FireBaseApi().setup();
      }
    }
    catch(e){
      loading!.value=false;
    }
  }

  promotion() async{


    try{
      imageCarousel.clear();
      var response = await ApiProvider().promotionList();
      if ((response as PromotionModel).data != null){
        imageCarousel.addAll(response.data!);
      }
    }
    catch(e){

    }finally {}
  }


  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;
  String long = "", lat = "";
  late StreamSubscription<Position> positionStream;

  bool isRequestingPermission = false;

  Future<void> checkGps() async {

    try {
      servicestatus = await Geolocator.isLocationServiceEnabled();
      if (servicestatus) {
        permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
          if (permission == LocationPermission.denied) {
            print('Location permissions are denied');
            SharedPreference.setBool(ConstantString.locationDeny, true);
            toastMessage("Please Allow location to access Service");
          } else if (permission == LocationPermission.deniedForever) {
            AppSettings.openAppSettings(type: AppSettingsType.location);
            throw Exception(
                'Location permissions are permanently denied, we cannot request permissions.');
            print("Location permissions are permanently denied");
          } else {
            haspermission = true;
          }
        } else {
          haspermission = true;
          SharedPreference.setBool(ConstantString.locationDeny, false);
        }
        if (haspermission) {
          position = await Geolocator.getCurrentPosition();
          long = position.longitude.toString();
          lat = position.latitude.toString();

         // await getLocation(); // Wait for permission before getting location
        }
      } else {
        print("GPS Service is not enabled, turn on GPS location");
      }
    } catch (e) {
      print('Error while checking or requesting permission: $e');
    }
  }

  Future<void> getLocation() async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      Get.to(InternetLoss());
      return;
    }

    try {
      await service();
      await  promotion();
      LocationSettings locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.lowest,
        distanceFilter: 2000,
      );
      // position = await Geolocator.getCurrentPosition();
      // long = position.longitude.toString();
      // lat = position.latitude.toString();

    } catch (e) {
      print('Error while getting location: $e');
    }
  }

// Future<void> checkGps() async {
  //   LocationPermission permission;
  //
  //   servicestatus = await Geolocator.isLocationServiceEnabled();
  //   if(servicestatus){
  //     permission = await Geolocator.checkPermission();
  //     if (permission == LocationPermission.denied) {
  //       permission = await Geolocator.requestPermission();
  //       if (permission == LocationPermission.denied) {
  //         print('Location permissions are denied');
  //         SharedPreference.setBool(ConstantString.locationDeny, true);
  //         toastMessage("Please Allow location to access Service");
  //       } else if(permission == LocationPermission.deniedForever){
  //         AppSettings.openAppSettings(type: AppSettingsType.location);
  //         return Future.error(
  //             'Location permissions are permanently denied, we cannot request permissions.');
  //         print("'Location permissions are permanently denied");
  //       } else{
  //         haspermission = true;
  //         //AppSettings.openAppSettings(type: AppSettingsType.location);
  //       }
  //     }else{
  //       haspermission = true;
  //       SharedPreference.setBool(ConstantString.locationDeny, false);
  //
  //     }
  //     if(haspermission){
  //
  //       //Future.delayed(const Duration(milliseconds: 200), () {
  //         getLocation();
  //       //});
  //
  //
  //     }
  //   }else{
  //     print("GPS Service is not enabled, turn on GPS location");
  //   }
  // }
  //
  //
  //
  // getLocation() async {
  //   final connectivityResult = await (Connectivity().checkConnectivity());
  //
  //   if (connectivityResult == ConnectivityResult.none) {
  //     return {
  //       Get.to(InternetLoss())
  //     };
  //   }
  //   try {
  //     position = await Geolocator.getCurrentPosition();
  //     long = position.longitude.toString();
  //     lat = position.latitude.toString();
  //     service();
  //     promotion();
  //     LocationSettings locationSettings = const LocationSettings(
  //       accuracy: LocationAccuracy.lowest,
  //       distanceFilter: 2000,
  //     );
  //
  //     StreamSubscription<Position> positionStream = Geolocator.getPositionStream(
  //       locationSettings: locationSettings,
  //     ).listen((Position position) {
  //       long = position.longitude.toString();
  //       lat = position.latitude.toString();
  //     });
  //   } catch (e) {
  //     print('Error while getting location: $e');
  //   }
  // }
}



// Future<void> getLocation() async {
//
//   bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   if (!serviceEnabled) {
//     print('Location services are disabled.');
//     return;
//   }
//
//
//   LocationPermission permission = await Geolocator.checkPermission();
//   if (permission == LocationPermission.denied) {
//     permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied) {
//       print('Location permissions are denied.');
//       return;
//     }
//   }
//
//   // Fetch current position
//   try {
//     Position currentPosition = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.lowest,
//     );
//
//     // Use the obtained position (currentPosition)
//
//     // Create location settings
//     LocationSettings locationSettings = const LocationSettings(
//       accuracy: LocationAccuracy.lowest,
//       distanceFilter: 1000,
//     );
//
//     // Listen for position updates
//     StreamSubscription<Position> positionStream = Geolocator.getPositionStream(
//       locationSettings: locationSettings,
//     ).listen((Position position) {
//       // Use the updated position (position)
//     });
//
//     // Cancel the positionStream when no longer needed
//     // positionStream.cancel(); // <- Add this line when the stream is no longer required
//   } catch (e) {
//     print('Error obtaining location: $e');
//   }
// }