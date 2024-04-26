import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:user/widget/auth_comman_button.dart';

import '../../constants/color_constant.dart';
import '../../constants/image_constant.dart';
import '../../constants/string_constant.dart';
import '../../controller/feedback_rating_controller.dart';
import '../../widget/app_text.dart';

class FeedbackRatingScreen extends StatelessWidget {
  int? id;
  String? idBooking;

  FeedbackRatingScreen(this.id, this.idBooking, {Key? key}) : super(key: key);
  final feedbackRatingController = Get.put(FeedbackRatingController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: ConstantColor.dashBackColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: Get.height * 0.09,
              ),
              AppText(
                text: ConstantString.thankYou,
                fontSize: 0.023,
                fontWeight: FontWeight.bold,
                fontFamily: ConstantString.fontbold,
                textColor: ConstantColor.green_color,
              ),
              SizedBox(
                height: Get.height * 0.015,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: AppText(
                  text: ConstantString.rateYourExperience,
                  fontSize: 0.019,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                  fontFamily: ConstantString.fontbold,
                ),
              ),
              SizedBox(height: Get.height * 0.03),
              SvgPicture.asset(
                ConstantImage.feedback_image,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 0.0),
                child: AppText(
                  text: ConstantString.lovedIt,
                  fontSize: 0.025,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                  fontFamily: ConstantString.fontbold,
                ),
              ),
              SizedBox(
                height: Get.height * 0.033,
              ),
              RatingBar.builder(
                initialRating: 0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {

                  feedbackRatingController.userRating = rating.obs;

                },
              ),
              SizedBox(
                height: Get.height * 0.04,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextFormField(
                  controller: feedbackRatingController.feedbackController,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: ConstantString.fontRegular,
                  ),
                  minLines: 3,
                  maxLines: 4,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    counterText: '',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Colors.grey.shade200), //<-- SEE HERE
                    ),
                    hintText: ConstantString.typeYourFeedbackHere,
                    hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: Get.height * 0.018,
                        fontWeight: FontWeight.w400,
                        fontFamily: ConstantString.fontRegular),
                    contentPadding: EdgeInsets.symmetric(
                        vertical: Get.height * 0.022, horizontal: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blue, width: 2),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.025,
              ),
              GestureDetector(
                onTap: (){
                  feedbackRatingController.addRating(id,idBooking);
                },

                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: CommonButton(
                    text: ConstantString.publishRating,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
