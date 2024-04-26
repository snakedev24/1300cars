import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:marquee/marquee.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:user/constants/string_constant.dart';
import 'package:user/view/dashboard_screens/provider_detail_screen.dart';
import '../../constants/color_constant.dart';
import '../../constants/image_constant.dart';
import '../../controller/service_list_controller.dart';
import '../../widget/app_text.dart';


class ServiceScreen extends StatelessWidget {
  String? name;
  String? lat;
  String? long;

  ServiceScreen(
    this.name, this.lat, this.long,  {
    super.key,
  });
  String? subCreiption="";
  @override
  Widget build(BuildContext context) {
    final serviceController = Get.put(ServiceListController());
    return Scaffold(
      backgroundColor: ConstantColor.darkWhite,

      body: Column(
        children: [
          SizedBox(height: Get.height*0.05,),
          Container(
            color: Colors.white,
            height: Get.height*0.07,
            child: Obx(() => (serviceController.checkSearchField!.value)?
            Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.transparent, borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: TextField(
                  onChanged: (value) => serviceController.allListService(lat!, long!, value),
                  textCapitalization :TextCapitalization.sentences,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          serviceController.checkSearchField!.value=false;
                          serviceController.allListService(lat!, long!, "");
                        },
                      ),
                      hintText: 'Search.....',
                      border: InputBorder.none),
                ),
              ),
            )
                :Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [

                GestureDetector(
                  onTap: (){
                    Get.back();
                  },

                  child: Padding(
                    padding:  EdgeInsets.only(left: Get.width*0.01),
                    child: SvgPicture.asset(
                      ConstantImage.back,
                      height: Get.height * 0.05,
                    ),
                  ),
                ),





                SizedBox(

                  width: Get.width*0.55,


                  child: SizedBox(
                    width: Get.width*0.6,
                      child: Marquee(
                        text: name.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize:20),
                        scrollAxis: Axis.horizontal, //scroll direction
                        crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        blankSpace: 50.0,
                        velocity: 50.0, //speed
                        pauseAfterRound: Duration(seconds: 2),
                        startPadding: 10.0,
                        accelerationDuration: Duration(seconds: 1),
                        accelerationCurve: Curves.linear,
                        decelerationDuration: Duration(milliseconds: 500),
                        decelerationCurve: Curves.easeOut,
                      )
                  ),
                ),


                // SizedBox(
                //   width: Get.width*0.6,
                //   child:    Expanded(
                //       child: Marquee(
                //         text: name.toString(),
                //         style: TextStyle(fontWeight: FontWeight.w700, fontSize:0.022),
                //         scrollAxis: Axis.horizontal, //scroll direction
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         blankSpace: 20.0,
                //         velocity: 50.0, //speed
                //         pauseAfterRound: Duration(seconds: 1),
                //         startPadding: 10.0,
                //         accelerationDuration: Duration(seconds: 1),
                //         accelerationCurve: Curves.linear,
                //         decelerationDuration: Duration(milliseconds: 500),
                //         decelerationCurve: Curves.easeOut,
                //       )
                //   )
                //
                //
                //
                //
                //   // AppText(text: name, fontSize: 0.022, fontWeight: FontWeight.w700,
                //   //   fontFamily: ConstantString.fontbold,  overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,),
                // ),
                GestureDetector(
                  onTap: (){
                    serviceController.checkSearchField!.value=true;
                  },
                  child: Container(
                      margin: EdgeInsets.only(right: Get.width*0.02),
                      padding: EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white
                      ),
                      child: const Icon(Icons.search)),
                ),
              ],
            )),
          ),

          Expanded(
            child: Obx(() => (serviceController.loading!.value)?
            Center(
              child: Container(
                height: 40,
                color: Colors.transparent,
                child: CircularProgressIndicator.adaptive(
                  valueColor: AlwaysStoppedAnimation<Color>(ConstantColor.gradiantLightColor),
                ),
              ),
            ):

            (serviceController.mainServiceList.isEmpty) ?
            Center(child: Text("Data Not Found"),):

            MediaQuery.removePadding(
              context: context,
              removeBottom: true,
              removeLeft: true,
              removeRight: true,
              removeTop: true,

                  child: ListView.builder(
                      itemCount: serviceController.mainServiceList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: (){
                            if(serviceController.mainServiceList[index].memberShipInfo!=null){
                              subCreiption = serviceController.mainServiceList[index].memberShipInfo!.subcriptionType;
                            }else{
                              subCreiption = "";
                            }
                            Get.to(ProviderDetailScreen(
                              serviceController.mainServiceList[index].businessName,
                              serviceController.mainServiceList[index].name,
                              serviceController.mainServiceList[index].isGoogle,
                              serviceController.mainServiceList[index].location,
                              serviceController.mainServiceList[index].latitude,
                              serviceController.mainServiceList[index].longitude,
                              serviceController.mainServiceList[index].startTime,
                              serviceController.mainServiceList[index].endTime,
                              serviceController.mainServiceList[index].servicePrice,
                              serviceController.mainServiceList[index].types,
                              serviceController.mainServiceList[index].id,
                              serviceController.mainServiceList[index].discountCoupons,
                              (serviceController.mainServiceList[index].ratings==0)?0.0:serviceController.mainServiceList[index].ratings,
                              subCreiption,
                              serviceController.mainServiceList[index].contactMobile.toString(),
                              serviceController.mainServiceList[index].placeId.toString(),
                          ));
                          },

                          child: Container(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(
                                  Get.width * 0.050,
                                  Get.height * 0.030,
                                  Get.width * 0.050,
                                  Get.height * 0.000),
                              child  :(serviceController.mainServiceList[index].isGoogle != true)?

                              Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              Get.width * 0.0,
                                              Get.height * 0.0,
                                              Get.width * 0.008,
                                              Get.height * 0.008),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(

                                                children: [



                                                  (serviceController.mainServiceList[index].memberShipInfo!.subcriptionType.toString() == "Autocare Premium")?
                                                  SvgPicture.asset(ConstantImage.tag_premium):
                                                  (serviceController.mainServiceList[index].memberShipInfo!.subcriptionType.toString() == "Garage VIP")?
                                                  SvgPicture.asset(ConstantImage.tag_vip)
                                                      :

                                                  SizedBox(height: Get.height * 0.06,width:Get.width * 0.04 ,),
                                                  
                                                  Expanded(

                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                                      children: [

                                                        Column(
                                                          children: [
                                                            AppText(
                                                              text: serviceController
                                                                  .mainServiceList[index]
                                                                  .name,
                                                              fontSize: 0.020,
                                                              fontFamily: ConstantString
                                                                  .fontbold,
                                                            ),

                                                            AppText(
                                                              text: serviceController
                                                                  .mainServiceList[index]
                                                                  .businessName,
                                                              fontSize: 0.016,
                                                              fontWeight: FontWeight.w400,
                                                              textColor: ConstantColor.textGrey,
                                                            ),
                                                          ],
                                                        ),

                                                        Obx(() =>
                                                            GestureDetector(
                                                              onTap: (){
                                                                serviceController.mainServiceList[index].heartClick!.value =!serviceController.mainServiceList[index].heartClick!.value;
                                                                serviceController.favourite(serviceController.mainServiceList[index].id);
                                                              },

                                                              child: Padding(
                                                                padding:  EdgeInsets.only(right:Get.width*0.03),
                                                                child:Container(
                                                                    height: Get.height*0.035,
                                                                    width: Get.width*0.1,
                                                                    child: Icon(Icons.favorite,color:(serviceController.mainServiceList[index].heartClick!.value)? Colors.red:Colors.grey,)),
                                                              ),
                                                            )),],
                                                    ),
                                                  )
                                                ],
                                              ),

                                            ],
                                          ),
                                        ),
                                        Divider(
                                          color: ConstantColor.darkWhite,
                                          height: Get.height * 0.0005,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              Get.width * 0.025,
                                              Get.height * 0.010,
                                              Get.width * 0.040,
                                              Get.height * 0.010),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              RatingBar.builder(
                                                initialRating: serviceController
                                                    .mainServiceList[index].ratings!
                                                    .toDouble(),
                                                minRating: 1,
                                                direction: Axis.horizontal,
                                                allowHalfRating: false,
                                                ignoreGestures: true,
                                                itemCount: 5,
                                                itemSize: Get.height * 0.025,
                                                itemPadding:
                                                EdgeInsets.symmetric(horizontal: 1),
                                                itemBuilder: (context, _) =>
                                                const Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ),
                                                onRatingUpdate: (rating) {
                                                  print(rating);
                                                },
                                                updateOnDrag: false,
                                                tapOnlyMode: true,
                                              ),

                                              GestureDetector(
                                                  onTap: () async {
                                                    Uri phoneno = Uri.parse(
                                                        "tel:${serviceController
                                                            .mainServiceList[index]
                                                            .contactMobile
                                                            .toString()}");
                                                    if (await launchUrl(phoneno)) {

                                                    } else {
                                                      //dailer is not opened
                                                    }
                                                  },
                                                  child: SvgPicture.asset(
                                                      ConstantImage.call)),


                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              Get.width * 0.025,
                                              Get.height * 0.010,
                                              Get.width * 0.030,
                                              Get.height * 0.020),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .start,
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              SvgPicture.asset(
                                                  ConstantImage.location),
                                              SizedBox(
                                                width: Get.width * 0.01,
                                              ),
                                              Container(
                                                width: Get.width * 0.7,
                                                child: AppText(
                                                  text: serviceController.mainServiceList[index].location,
                                                  fontSize: 0.017,
                                                  fontWeight: FontWeight.w400,
                                                  textColor: ConstantColor
                                                      .light_black,

                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        (serviceController.mainServiceList[index].discountCoupons!.isNotEmpty)?

                                          Padding(
                                            padding:  EdgeInsets.only(left: Get.width*0.02, bottom: Get.height*0.01 ),
                                            child: AppText(
                                                text: "Get Discount",
                                                fontSize: 0.016,
                                                fontWeight: FontWeight.w400,
                                                textColor: ConstantColor
                                                    .lightRedColor),
                                          ):
                                          SizedBox(height: Get.height*0.0001,),

                                        Divider(
                                          color: ConstantColor.darkWhite,
                                          height: Get.height * 0.0005,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              Get.width * 0.025,
                                              Get.height * 0.010,
                                              Get.width * 0.012,
                                              Get.height * 0.015),
                                          child: Row(
                                            children: [
                                              AppText(
                                                  text:
                                                  "Start Time - "
                                                      "${convert12HourTo24Hour(
                                                      serviceController
                                                          .mainServiceList[index]
                                                          .startTime.toString()
                                                  )}",
                                                  fontSize: 0.016,
                                                  fontWeight: FontWeight.w400,
                                                  textColor: ConstantColor
                                                      .light_black),
                                              SizedBox(
                                                width: Get.width * 0.02,
                                              ),
                                              AppText(
                                                  text:
                                                  "Closed Time - ${convert12HourTo24Hour(
                                                      serviceController
                                                          .mainServiceList[index]
                                                          .endTime.toString())}",
                                                  fontSize: 0.016,
                                                  fontWeight: FontWeight.w400,
                                                  textColor: ConstantColor
                                                      .light_black),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ))

                             :

                              Container(
                             decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              Get.width * 0.025,
                                              Get.height * 0.012,
                                              Get.width * 0.008,
                                              Get.height * 0.008),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              AppText(
                                                text: serviceController
                                                    .mainServiceList[index].businessName,
                                                fontSize: 0.020,
                                                fontFamily: ConstantString.fontbold,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          color: ConstantColor.darkWhite,
                                          height: Get.height * 0.0005,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              Get.width * 0.025,
                                              Get.height * 0.010,
                                              Get.width * 0.040,
                                              Get.height * 0.010),
                                          child: Row(
                                            // mainAxisAlignment:
                                            // MainAxisAlignment.spaceBetween,
                                            children: [
                                              RatingBar.builder(
                                                initialRating:serviceController
                                                    .mainServiceList[index].ratings,
                                                minRating: 1,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                ignoreGestures: true,
                                                itemCount: 5,
                                                itemSize: Get.height * 0.025,
                                                itemPadding:
                                                EdgeInsets.symmetric(horizontal: 1),
                                                itemBuilder: (context, _) => Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ),
                                                onRatingUpdate: (rating) {
                                                  print(rating);
                                                },
                                              ),



                                              // AppText(
                                              //   text: ". 900m",
                                              //   fontSize: 0.016,
                                              //   fontWeight: FontWeight.w400,
                                              //   textColor: ConstantColor.greyDark,
                                              // ),
                                              // SvgPicture.asset(ConstantImage.call),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              Get.width * 0.025,
                                              Get.height * 0.010,
                                              Get.width * 0.030,
                                              Get.height * 0.020),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SvgPicture.asset(ConstantImage.location),
                                              SizedBox(
                                                width: Get.width * 0.01,
                                              ),
                                              Container(
                                                width: Get.width*0.7,
                                                child: AppText(
                                                  text: serviceController
                                                      .mainServiceList[index].location
                                                      .toString(),
                                                  fontSize: 0.016,

                                                  fontWeight: FontWeight.w400,
                                                  textColor: ConstantColor.light_black,
                                                ),
                                              ),
                                            ],
                                          ),

                                        ),


                                        // Padding(
                                        //   padding:  EdgeInsets.only(left :Get.height*0.02),
                                        //   child: AppText(
                                        //     text: "Open",
                                        //     fontSize: 0.018,
                                        //     fontWeight: FontWeight.w400,
                                        //     textColor: ConstantColor.green_color,
                                        //   ),
                                        // ),
                                        //
                                        // Padding(
                                        //   padding:  EdgeInsets.only(left :Get.height*0.02),
                                        //   child: AppText(
                                        //     text: "Closed",
                                        //     fontSize: 0.018,
                                        //     fontWeight: FontWeight.w400,
                                        //     textColor: ConstantColor.redColor,
                                        //   ),
                                        // ),

                                      ],



                                    )
                     ),
                            ),
                          ),
                        );
                      }),
                ),
            ),
          ),
        ],
      ),
    );
  }

  String convert12HourTo24Hour(String time12Hour) {
    final inputFormat = DateFormat('hh:mm');
    final outputFormat = DateFormat('h:mm a');
    final dateTime = inputFormat.parse(time12Hour);
    final time24Hour = outputFormat.format(dateTime);
    return time24Hour;
  }
}
