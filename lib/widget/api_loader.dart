import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/color_constant.dart';

class CommonDialog {
  static void showLoading({String title = "Loading..."}) {
    Get.dialog(
      Center(
        child: Container(
          height: 40,
          color: Colors.transparent,
          child: CircularProgressIndicator.adaptive(
            valueColor: AlwaysStoppedAnimation<Color>(ConstantColor.gradiantLightColor),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  static void hideLoading() {
    Get.back();
  }

  static void showErrorDialog({String title = "Oops Error", String description = "Something went wrong "}) {
    Get.dialog(
      Dialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: Get.textTheme.headline6,
              ),
              const SizedBox(height: 10),
              Text(
                description,
                style: const TextStyle(fontSize: 16),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text("Okay"),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}
