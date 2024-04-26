import 'dart:io';
import 'dart:ui';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:user/Model/EditProfileModel.dart';

import '../Model/GetProfileModel.dart';
import '../constants/string_constant.dart';
import '../network/api_provider.dart';
import '../pref/shared_preference.dart';
import '../widget/error_message_toast.dart';
import '../widget/no_internet_screen.dart';

class UpdateProfileController extends GetxController{
  final nameController=TextEditingController();
  final emailController=TextEditingController();
  final phoneController=TextEditingController();
  final addressController=TextEditingController();
  RxString? userProfileImage="".obs;
  final formKey = GlobalKey<FormState>();
  RxString? profileImage="".obs;
  RxString? profileName="".obs;
  RxBool? loading=false.obs;

  @override
  void onInit() {
    if((SharedPreference.getBool(ConstantString.guestUser) == false)){

    profile();}
    super.onInit();

  }


  edit() async {
    try {

      final connectivityResult = await (Connectivity().checkConnectivity());

      if (connectivityResult == ConnectivityResult.none) {
        return {
          Get.to(InternetLoss())
        };
      }

      String imagePath = selectedImagePath.value;


      var response = await ApiProvider().editProfile(nameController.text,
        phoneController.text, addressController.text,File(imagePath),);
      if ((response as EditProfileModel).statusCode == 200 ){
        SharedPreference.setString(ConstantString.nameSave, response.data!.name.toString());
        SharedPreference.setString(ConstantString.profileImage, response.data!.uploadImage.toString());
        profileImage!.value=response.data!.uploadImage.toString();
        profileName!.value = response.data!.name.toString();
        toastMessage("Profile Update Sucessfully");
      }else{
        print("Error");
      }
    } catch (e) {
      print('Error in login(): $e');
    }
  }


  profile() async {

    try {

      // final connectivityResult = await (Connectivity().checkConnectivity());
      //
      // if (connectivityResult == ConnectivityResult.none) {
      //   return {
      //     Get.to(InternetLoss())
      //   };
      // }


      var response = await ApiProvider().getProfile();
      if ((response as GetProfileModel).statusCode == 200) {
        nameController.text =  response.data!.name!;
        emailController.text = response.data!.email!;
        phoneController.text =  response.data!.phoneNumber!;
        addressController.text = response.data!.address!;
        userProfileImage!.value=response.data!.uploadImage!;
        print("user profile ${response.data!.uploadImage}");
      }
    } catch(e){
      print("$e");
    }
  }

  void imagePickerOption() {
    Get.bottomSheet(
      SingleChildScrollView(
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
          child: Container(
            color: Colors.white,
            height: Get.height*0.33,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Pic Image From",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: Get.height*0.015,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      pickImage(ImageSource.camera);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade200,
                    ),
                    icon: const Icon(Icons.camera,color: Colors.black,),
                    label: const Text("CAMERA",style: TextStyle(color: Colors.black),),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      pickImage(ImageSource.gallery);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade200,
                    ),
                    icon: const Icon(Icons.image,color: Colors.black,),
                    label: const Text("GALLERY",style: TextStyle(color: Colors.black),),
                  ),
                  SizedBox(
                    height: Get.height*0.010,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent.shade200,
                    ),
                    icon: const Icon(Icons.close,color: Colors.black,),
                    label: const Text("CANCEL",style: TextStyle(color: Colors.black),),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  // var selectedImagePath="".obs;
  // var selectedImageSize="".obs;
  //
  //
  // pickImage(ImageSource imageType) async {
  //   try {
  //     final photo = await ImagePicker().pickImage(source: imageType);
  //     if (photo != null) {
  //       selectedImagePath.value=photo.path;
  //       final tempImage = File(photo.path);
  //       pickedImage=tempImage;
  //       userProfileImage!.value="";
  //       selectedImagePath.value=photo.path;
  //       selectedImageSize.value=(File(selectedImagePath.value).lengthSync()/1024/1024).toStringAsFixed(2)+" Mb";
  //       Get.back();
  //
  //     }
  //
  //   } catch (error) {
  //     debugPrint(error.toString());
  //   }
  // }
  //
  // File? pickedImage;



  var selectedImagePath = "".obs;
  var selectedImageSize = "".obs;

  pickImage(ImageSource imageType) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: imageType);
      if (pickedFile != null) {
        selectedImagePath.value = pickedFile.path;
        final tempImage = File(pickedFile.path);
        //final fixedImage = await fixImageOrientation(tempImage);
        pickedImage = tempImage;
        userProfileImage!.value = "";
        selectedImagePath.value = pickedFile.path;
        // selectedImageSize.value =
        //     (fixedImage.lengthSync() / 1024 / 1024).toStringAsFixed(2) + " Mb";
        Get.back();

        // Now, you can upload 'fixedImage' to the server
        // Call your upload function here
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<File> fixImageOrientation(File file) async {
    List<int> imageBytes = await file.readAsBytes();
    // Perform checks to verify the image orientation and fix it if needed
    // Here you can use packages like flutter_image_fix or exif

    // For example, if using the flutter_image_fix package:
    // var fixedBytes = await FlutterImageFix.decodeAndFixOrientation(imageBytes);

    // Return the fixed image as a File
    // return File.fromRawPath(fixedBytes!);

    // In absence of a specific package, you can just return the original file
    return file;
  }

  File? pickedImage;


}