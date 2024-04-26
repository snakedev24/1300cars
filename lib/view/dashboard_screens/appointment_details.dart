import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:user/widget/auth_comman_button.dart';

import '../../constants/color_constant.dart';
import '../../constants/image_constant.dart';
import '../../constants/string_constant.dart';
import '../../controller/home_controller.dart';
import '../../widget/app_text.dart';

class AppointmentDetails extends StatelessWidget {
  String? name;
  String? serviceTime;
  String? location;
  String? id;
  var service;
  String? providerStatus;
  String? image;
  dynamic ratings;
  String? serviceDate;



   AppointmentDetails(this.name, this.serviceTime, this.location, this.id, this.service, this.providerStatus, this.image, this.ratings, this.serviceDate,  {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController());
    return Scaffold(

      appBar: AppBar(
        leadingWidth: Get.height * 0.05,
        elevation: 1,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: EdgeInsets.only(left: Get.width * 0.01),
          child: GestureDetector(
              onTap: (){
                Get.back();
              },
              child: SvgPicture.asset(ConstantImage.back)),
        ),
        title: AppText(
          text: "Appointment Details",
          fontWeight: FontWeight.w700,
          fontSize: 0.02,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding:  EdgeInsets.all(Get.height*0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 3,
              color: Colors.white,

              child: Padding(
                padding:  EdgeInsets.all(Get.height*0.01),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(5.0),


                                child:Image.network(image.toString(), fit: BoxFit.fill,height: Get.height * 0.09,
                                  width: Get.width * 0.165,)
                               ),
                            SizedBox(
                              width: Get.width * 0.01,
                            ),
                            Container(
                              width: Get.width*0.45,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppText(
                                    text: name!,
                                    fontSize: 0.018,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: ConstantString.fontbold,
                                  ),
                                  RatingBar.builder(
                                    initialRating: ratings,
                                    minRating: 1,
                                    itemSize: Get.height*0.03,
                                    ignoreGestures: true,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,

                                    itemCount: 5,
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 1.0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.amber,

                                    ),
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                    },
                                  ),
                                  AppText(
                                    text: location!,
                                    fontSize: 0.014,
                                    fontWeight: FontWeight.w700,
                                    textColor: ConstantColor.grey,
                                  ),

                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding:  EdgeInsets.only(top: Get.height*0.01),
                          child: Column(

                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    ConstantImage.small_calander,
                                    height: Get.height * 0.02,
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.015,
                                  ),
                                  AppText(
                                    text: serviceDate,
                                    fontSize: 0.015,
                                    fontWeight: FontWeight.w400,
                                    textColor: ConstantColor.light_black,
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    ConstantImage.clock,
                                    height: Get.height * 0.02,
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.015,
                                  ),
                                  AppText(
                                    text: convert12HourTo24Hour(serviceTime!),
                                    fontSize: 0.015,
                                    fontWeight: FontWeight.w400,
                                    textColor: ConstantColor.light_black,
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.015,
                                  ),
                                ],
                              ),

                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: Get.height*0.02,),

            AppText(text: "Services Offered",
              fontSize: 0.026,
              fontWeight: FontWeight.w700,
              fontFamily: ConstantString.fontbold,
            ),

            SizedBox(height: Get.height*0.02,),

            ListView.builder(
                itemCount: service!.length,
                shrinkWrap: true,
                itemBuilder: (context,indextype){
              return    Padding(
                padding:  EdgeInsets.only(bottom: Get.height*0.012),
                child: Row(
                  children: [
                    Image.asset(
                      ConstantImage
                          .close_png,
                      height:
                      Get.height *
                          0.025,
                      width: Get.width *
                          0.08,
                      // fit: BoxFit.fill,
                    ),
                    SizedBox(width: Get.width*0.02),
                    AppText(text: service![indextype].service!,
                      fontSize: 0.017, fontWeight: FontWeight.w400,
                      textColor: ConstantColor.light_black),
                  ],
                ),
              );
            }),
            SizedBox(height: Get.height*0.02,),

            // (providerStatus == "blank")?
            // AppText(
            //   text: "Cancel Request",
            //   fontSize: 0.016,
            //   fontWeight: FontWeight.w700,
            //   textColor: ConstantColor.redColor,
            // ):
            // (providerStatus == "accept")?
            //
            // SvgPicture.asset(ConstantImage.chatsvg) :
            // AppText(
            //   text: "Rejected",
            //   fontSize: 0.016,
            //   fontWeight: FontWeight.w700,
            //   textColor: ConstantColor.redColor,
            // ),
          ],
        ),
      ),
    );
  }
  String convert12HourTo24Hour(String time12Hour) {
    final inputFormat = DateFormat('HH:mm');
    final outputFormat = DateFormat('h:mm a');
    final dateTime = inputFormat.parse(time12Hour);
    final time24Hour = outputFormat.format(dateTime);
    return time24Hour;
  }
}
