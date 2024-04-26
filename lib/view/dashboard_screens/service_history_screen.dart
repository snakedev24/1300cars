import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:shimmer/shimmer.dart';
import 'package:user/constants/color_constant.dart';
import 'package:user/constants/image_constant.dart';
import 'package:user/controller/service_history_controller.dart';
import 'package:user/view/profile/feedback_and_ranking_screen.dart';
import 'package:user/widget/app_text.dart';

import '../../constants/string_constant.dart';
import 'appointment_details.dart';

class ServiceHistoryScreen extends StatelessWidget {
  ServiceHistoryScreen({Key? key}) : super(key: key);

  final serviceHistoryController = Get.put(ServiceHistoryController());

  RxInt checkTab = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: 0,
              right: 0,
              bottom: 0,
              left: 0,
              child: SvgPicture.asset(ConstantImage.yellowBack, fit: BoxFit.fill,)),

          Padding(
            padding: EdgeInsets.only(
                left: Get.width * 0.04, right: Get.width * 0.04),
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: SvgPicture.asset(ConstantImage.back, width: Get.width * 0.09 ),
                    ),

                    AppText(
                      text: "Service History",
                      fontWeight: FontWeight.w700,
                      fontSize: 0.02,
                    ),

                    SizedBox(
                      width: Get.width * 0.09,
                    )

                  ],
                ),

                SizedBox(
                  height: Get.height * 0.025,
                ),

                Obx(() => (serviceHistoryController.loading!.value)?


                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(

                    width: Get.width,
                    height: Get.height * 0.1,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                      borderRadius: BorderRadius.circular(10)
                    ),
                  ),
                ):
                Container(
                  width: Get.width,
                  height: Get.height * 0.08,
                  decoration: BoxDecoration(
                      border: GradientBoxBorder(
                        gradient: LinearGradient(colors: [
                          ConstantColor.gradiantLightColor,
                          ConstantColor.gradiantDarkColor
                        ]),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(16)),
                  child: Obx(() =>


                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              serviceHistoryController
                                  .getServiceHistory("accept");
                              checkTab.value = 0;
                            },
                            child: Container(
                              width: Get.width * 0.3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                    (checkTab.value == 0)
                                        ? ConstantColor.gradiantDarkColor
                                        : Colors.white,
                                    (checkTab.value == 0)
                                        ? ConstantColor.gradiantLightColor
                                        : Colors.white,
                                  ],
                                ),
                              ),
                              child: Center(
                                child: AppText(
                                  text: "Upcoming",
                                  fontSize: 0.018,
                                  textColor: (checkTab.value == 0)
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),

                          GestureDetector(
                            onTap: () {
                              serviceHistoryController
                                  .getServiceHistory("complete");
                              checkTab.value = 1;
                            },
                            child: Container(
                              width: Get.width * 0.3,
                              child: Center(
                                child: AppText(
                                  text: "Completed",
                                  fontSize: 0.018,
                                  textColor: (checkTab.value == 1)
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                    (checkTab.value == 1)
                                        ? ConstantColor.gradiantDarkColor
                                        : Colors.white,
                                    (checkTab.value == 1)
                                        ? ConstantColor.gradiantLightColor
                                        : Colors.white,
                                  ],
                                ),
                              ),
                            ),
                          ),

                          GestureDetector(
                            onTap: () {
                              serviceHistoryController
                                  .getServiceHistory("decline");
                              checkTab.value = 2;
                            },
                            child: Container(
                              width: Get.width * 0.3,
                              child: Center(
                                child: AppText(
                                  text: "Cancelled",
                                  fontSize: 0.018,
                                  textColor: (checkTab.value == 2)
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                    (checkTab.value == 2)
                                        ? ConstantColor.gradiantDarkColor
                                        : Colors.white,
                                    (checkTab.value == 2)
                                        ? ConstantColor.gradiantLightColor
                                        : Colors.white,
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                )),
                SizedBox(
                  height: Get.height * 0.025,
                ),
            Obx(() =>
            (serviceHistoryController.loading!.value)?
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child:
              SizedBox(
                height: Get.height*0.8,
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return Container(
                   height: Get.height*0.1,
                 decoration: BoxDecoration(
                   color: Colors.grey,
                   borderRadius: BorderRadius.circular(10)
                 ),
                   padding: EdgeInsets.all(10),
                   margin: EdgeInsets.only(
                       bottom: Get.height * 0.02),
                  );},
            ),
                ),
              )):
                Expanded(
                  child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: Obx(() =>
                       (serviceHistoryController.serviceHistoryList.isEmpty) ?

                               Center(child: Text("No service history available"),)

                           : ListView.builder(
                              shrinkWrap: true,
                              itemCount: serviceHistoryController
                                  .serviceHistoryList.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(

                                    onTap: () {
                                      Get.to(AppointmentDetails(
                                          serviceHistoryController.serviceHistoryList[index].name,
                                          serviceHistoryController.serviceHistoryList[index].serviceTime,
                                          serviceHistoryController.serviceHistoryList[index].location,
                                          serviceHistoryController.serviceHistoryList[index].id,
                                          serviceHistoryController.serviceHistoryList[index].service,
                                          serviceHistoryController.serviceHistoryList[index].providerStatus,
                                         serviceHistoryController.serviceHistoryList[index].provider?.image,
                                          (serviceHistoryController.serviceHistoryList[index].provider!.ratings==0)?0.0:serviceHistoryController.serviceHistoryList[index].provider!.ratings,
                                        serviceHistoryController.serviceHistoryList[index].serviceDate,
                                      ));
                                  },

                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    margin: EdgeInsets.only(
                                        bottom: Get.height * 0.02),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(
                                            Get.height * 0.01)),
                                    child: Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  height:Get.height*0.08,
                                                  width: Get.width*0.13,
                                                  child: serviceHistoryController.serviceHistoryList[index].provider?.image != ""?
                                                  Image.network(serviceHistoryController.serviceHistoryList[index].provider!.image.toString(), fit: BoxFit.fill,):
                                                  Image.asset(ConstantImage.person_png)
                                                ),
                                                SizedBox(width: Get.width * 0.015,),
                                                SizedBox(
                                                    width: Get.width * 0.53,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        AppText(
                                                          text: serviceHistoryController
                                                              .serviceHistoryList[
                                                                  index]
                                                              .name,
                                                          fontSize: 0.017,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontFamily:
                                                              ConstantString
                                                                  .fontbold,
                                                        ),


                                                        AppText(
                                                          text:
                                                          serviceHistoryController.convert12HourTo24Hour( serviceHistoryController
                                                              .serviceHistoryList[
                                                          index]
                                                              .serviceDate.toString()),



                                                          fontSize: 0.014,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          textColor: ConstantColor
                                                              .textGrayColor,
                                                        ),

                                                        (serviceHistoryController.serviceHistoryList[index].providerStatus == "accept")?
                                                          GestureDetector(
                                                            onTap :(){


                                                              Get.to(FeedbackRatingScreen(serviceHistoryController.serviceHistoryList[index].provider!.id,serviceHistoryController.serviceHistoryList[index].id));
                                  },
                                                            child: AppText(
                                                              text:
                                                              "Rate Now",
                                                              fontSize: 0.015,
                                                              fontWeight:
                                                              FontWeight.w700,
                                                              textColor: ConstantColor
                                                                  .redColor,
                                                            ),
                                                          )

                                                        : Container(
                                                          width: 100, // Specify a fixed width for the container
                                                          child:

                                                          AppText(
                                                            text:
                                                            serviceHistoryController.serviceHistoryList[index].provider!.service![0].toString(),
                                                            fontSize: 0.015,
                                                            fontWeight:
                                                            FontWeight.w700,
                                                            textColor: ConstantColor
                                                                .textGrayColor,overflow:  TextOverflow.ellipsis,
                                                          ),),




                                                      ],
                                                    )),
                                              ],
                                            ),
                                            AppText(
                                              text: '\$${serviceHistoryController.serviceHistoryList[index].totalPrice.toString()}'
                                              ,fontSize: 0.02,
                                              fontWeight: FontWeight.w700,
                                              textColor: ConstantColor.darkYellow,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }))),
                )

            )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
