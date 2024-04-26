import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:user/widget/app_text.dart';

import '../../constants/color_constant.dart';
import '../../constants/image_constant.dart';
import '../../constants/string_constant.dart';

class MembershipScreen extends StatelessWidget {
  const MembershipScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(


      appBar: AppBar(
        leading: Container(
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Transform.scale(
              scale: 0.7, // Adjust the scale factor as needed to reduce the icon size
              child: SvgPicture.asset(ConstantImage.back),
            ),
          ),
        ),

        backgroundColor: Colors.white,

        centerTitle: true,

        title:  AppText(text:"Membership plans",fontSize: 0.023, textColor: Colors.black,fontFamily: ConstantString.fontbold,),
      ),

      body: Padding(
        padding: EdgeInsets.all(20),

          child:SingleChildScrollView(
            child: Column(
              children: [

                Container(

                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        spreadRadius: 5,
                        blurRadius: 8,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],

                    border: Border.all(color: ConstantColor.skyBlue, width: Get.width*0.002),
                    borderRadius:BorderRadius.all(Radius.circular(10)),
                  ),


                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            SvgPicture.asset(ConstantImage.basic),

                            SizedBox(width: Get.width*0.030,),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(text:"Basic Service",fontSize: 0.023, textColor: Colors.black,fontFamily: ConstantString.fontbold,),

                                AppText(text:"Pricing plan for startup company",fontSize: 0.014, textColor: ConstantColor.light_black)
                              ],
                            ),
                          ],
                        ),
                      ),

                      Divider(
                        color: ConstantColor.skyBlue,
                        height: Get.height*0.002,
                      ),

                      Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                AppText(text:"\$${00.00}/",fontSize: 0.024, textColor:  ConstantColor.skyBlue,fontFamily: ConstantString.fontbold,),
                                AppText(text:"One Month only",fontSize: 0.013, textColor: ConstantColor.skyBlue,fontFamily: ConstantString.fontRegular,),
                              ],
                            ),

                            SizedBox(height: Get.height*0.015,),

                            Row(
                              children: [
                                SvgPicture.asset(ConstantImage.blue_tick),
                                SizedBox(width: Get.width*0.020,),
                                AppText(text:"Nearby services finder: - Road side assistance only 3\n random , Fuel stations only 3, EV stations only 3",fontSize: 0.013, textColor: ConstantColor.text_color,fontFamily: ConstantString.fontRegular, fontWeight: FontWeight.w400,),
                              ],
                            ),

                            SizedBox(height: Get.height*0.010,),

                            Row(
                              children: [
                                SvgPicture.asset(ConstantImage.blue_tick),
                                SizedBox(width: Get.width*0.020,),
                                AppText(text:"Add favourite automotive services",fontSize: 0.013, textColor: ConstantColor.text_color,fontFamily: ConstantString.fontRegular, fontWeight: FontWeight.w400,),

                              ],
                            ),

                            SizedBox(height: Get.height*0.010,),

                            Row(
                              children: [
                                SvgPicture.asset(ConstantImage.blue_tick),
                                SizedBox(width: Get.width*0.020,),
                                AppText(text:"Email newsletter",fontSize: 0.013, textColor: ConstantColor.text_color,fontFamily: ConstantString.fontRegular, fontWeight: FontWeight.w400,),

                              ],
                            ),


                            SizedBox(height: Get.height*0.010,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(


                                  decoration: BoxDecoration(
                                    color: ConstantColor.skyBlue,
                                    borderRadius: BorderRadius.circular(8), // Adjust the radius as needed
                                  ),

                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: AppText(text:"PURCHASE NOW",fontSize: 0.014, textColor:  Colors.white,fontFamily: ConstantString.fontbold,),
                                  ),

                                ),
                              ],
                            )

                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: Get.height*0.030,),


                Container(

                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        spreadRadius: 5,
                        blurRadius: 8,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],

                      border: Border.all(color: ConstantColor.skyBlue, width: Get.width*0.002),
                    borderRadius:BorderRadius.all(Radius.circular(10)),
                  ),


                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            SvgPicture.asset(ConstantImage.basic),

                            SizedBox(width: Get.width*0.030,),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(text:"Basic Service",fontSize: 0.023, textColor: Colors.black,fontFamily: ConstantString.fontbold,),

                                AppText(text:"Pricing plan for startup company",fontSize: 0.014, textColor: ConstantColor.light_black)
                              ],
                            ),
                          ],
                        ),
                      ),

                      Divider(
                        color: ConstantColor.skyBlue,
                        height: Get.height*0.002,
                      ),

                      Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                AppText(text:"12.99/",fontSize: 0.024, textColor:  ConstantColor.skyBlue,fontFamily: ConstantString.fontbold,),
                                AppText(text:" One Month",fontSize: 0.013, textColor: ConstantColor.skyBlue,fontFamily: ConstantString.fontRegular,),
                              ],
                            ),

                            SizedBox(height: Get.height*0.015,),

                            Row(
                              children: [
                                SvgPicture.asset(ConstantImage.blue_tick),
                                SizedBox(width: Get.width*0.020,),
                                AppText(text:"AI Assist Nearby services finder: -Road side assistance,\nFuel stations, EV stations, Car rentals, Car wash,\nservice stations, spare parts, Vehicle retailers and\n dealerships, Comprehensive insurance companies,\n Vehicle finance companies",fontSize: 0.013, textColor: ConstantColor.text_color,fontFamily: ConstantString.fontRegular, fontWeight: FontWeight.w400,),
                              ],
                            ),

                            SizedBox(height: Get.height*0.010,),

                            Row(
                              children: [
                                SvgPicture.asset(ConstantImage.blue_tick),
                                SizedBox(width: Get.width*0.020,),
                                AppText(text:"1300 AI Maps",fontSize: 0.013, textColor: ConstantColor.text_color,fontFamily: ConstantString.fontRegular, fontWeight: FontWeight.w400,),

                              ],
                            ),

                            SizedBox(height: Get.height*0.010,),

                            Row(
                              children: [
                                SvgPicture.asset(ConstantImage.blue_tick),
                                SizedBox(width: Get.width*0.020,),
                                AppText(text:"1300 AI Parking Pin ",fontSize: 0.013, textColor: ConstantColor.text_color,fontFamily: ConstantString.fontRegular, fontWeight: FontWeight.w400,),

                              ],
                            ),

                            SizedBox(height: Get.height*0.010,),

                            Row(
                              children: [
                                SvgPicture.asset(ConstantImage.blue_tick),
                                SizedBox(width: Get.width*0.020,),
                                AppText(text:"Nearby Cheapest Fuel price updates ",fontSize: 0.013, textColor: ConstantColor.text_color,fontFamily: ConstantString.fontRegular, fontWeight: FontWeight.w400,),
                              ],
                            ),

                            SizedBox(height: Get.height*0.010,),



                            Row(
                              children: [
                                SvgPicture.asset(ConstantImage.blue_tick),
                                SizedBox(width: Get.width*0.020,),
                                AppText(text:"Service booking option",fontSize: 0.013, textColor: ConstantColor.text_color,fontFamily: ConstantString.fontRegular, fontWeight: FontWeight.w400,),
                              ],
                            ),

                            SizedBox(height: Get.height*0.010,),

                            Row(
                              children: [
                                SvgPicture.asset(ConstantImage.blue_tick),
                                SizedBox(width: Get.width*0.020,),
                                AppText(text:"Service Appointments option",fontSize: 0.013, textColor: ConstantColor.text_color,fontFamily: ConstantString.fontRegular, fontWeight: FontWeight.w400,),
                              ],
                            ),

                            SizedBox(height: Get.height*0.010,),

                            Row(
                              children: [
                                SvgPicture.asset(ConstantImage.blue_tick),
                                SizedBox(width: Get.width*0.020,),
                                AppText(text:"Live chat option",fontSize: 0.013, textColor: ConstantColor.text_color,fontFamily: ConstantString.fontRegular, fontWeight: FontWeight.w400,),
                              ],
                            ),

                            SizedBox(height: Get.height*0.010,),

                            Row(
                              children: [
                                SvgPicture.asset(ConstantImage.blue_tick),
                                SizedBox(width: Get.width*0.020,),
                                AppText(text:"Service Review option",fontSize: 0.013, textColor: ConstantColor.text_color,fontFamily: ConstantString.fontRegular, fontWeight: FontWeight.w400,),
                              ],
                            ),

                            SizedBox(height: Get.height*0.010,),

                            Row(
                              children: [
                                SvgPicture.asset(ConstantImage.blue_tick),
                                SizedBox(width: Get.width*0.020,),
                                AppText(text:"Vehicle diagnostic records",fontSize: 0.013, textColor: ConstantColor.text_color,fontFamily: ConstantString.fontRegular, fontWeight: FontWeight.w400,),
                              ],
                            ),

                            SizedBox(height: Get.height*0.010,),

                            Row(
                              children: [
                                SvgPicture.asset(ConstantImage.blue_tick),
                                SizedBox(width: Get.width*0.020,),
                                AppText(text:"Service history",fontSize: 0.013, textColor: ConstantColor.text_color,fontFamily: ConstantString.fontRegular, fontWeight: FontWeight.w400,),
                              ],
                            ),

                            SizedBox(height: Get.height*0.010,),


                            Row(
                              children: [
                                SvgPicture.asset(ConstantImage.blue_tick),
                                SizedBox(width: Get.width*0.020,),
                                AppText(text:"Add favourite automotive services ",fontSize: 0.013, textColor: ConstantColor.text_color,fontFamily: ConstantString.fontRegular, fontWeight: FontWeight.w400,),
                              ],
                            ),

                            SizedBox(height: Get.height*0.010,),

                            Row(
                              children: [
                                SvgPicture.asset(ConstantImage.blue_tick),
                                SizedBox(width: Get.width*0.020,),
                                AppText(text:"Service reminders",fontSize: 0.013, textColor: ConstantColor.text_color,fontFamily: ConstantString.fontRegular, fontWeight: FontWeight.w400,),
                              ],
                            ),

                            SizedBox(height: Get.height*0.010,),


                            Row(
                              children: [
                                SvgPicture.asset(ConstantImage.blue_tick),
                                SizedBox(width: Get.width*0.020,),
                                AppText(text:"Emergency contact list",fontSize: 0.013, textColor: ConstantColor.text_color,fontFamily: ConstantString.fontRegular, fontWeight: FontWeight.w400,),
                              ],
                            ),

                            SizedBox(height: Get.height*0.010,),

                            Row(
                              children: [
                                SvgPicture.asset(ConstantImage.blue_tick),
                                SizedBox(width: Get.width*0.020,),
                                AppText(text:"Discounts and offer membership",fontSize: 0.013, textColor: ConstantColor.text_color,fontFamily: ConstantString.fontRegular, fontWeight: FontWeight.w400,),
                              ],
                            ),

                            SizedBox(height: Get.height*0.010,),


                            Row(
                              children: [
                                SvgPicture.asset(ConstantImage.blue_tick),
                                SizedBox(width: Get.width*0.020,),
                                AppText(text:"Email newsletter",fontSize: 0.013, textColor: ConstantColor.text_color,fontFamily: ConstantString.fontRegular, fontWeight: FontWeight.w400,),
                              ],
                            ),

                            SizedBox(height: Get.height*0.010,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(


                                  decoration: BoxDecoration(
                                    color: ConstantColor.skyBlue,
                                    borderRadius: BorderRadius.circular(8), // Adjust the radius as needed
                                  ),

                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: AppText(text:"PURCHASE NOW",fontSize: 0.014, textColor:  Colors.white,fontFamily: ConstantString.fontbold,),
                                  ),

                                ),
                              ],
                            )

                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: Get.height*0.030,),

                Container(

                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        spreadRadius: 5,
                        blurRadius: 8,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],

                    border: Border.all(color: ConstantColor.priceYellowColor, width: Get.width*0.002),
                    borderRadius:BorderRadius.all(Radius.circular(10)),
                  ),


                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            SvgPicture.asset(ConstantImage.premium),

                            SizedBox(width: Get.width*0.030,),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(text:"Premium Service",fontSize: 0.023, textColor: Colors.black,fontFamily: ConstantString.fontbold,),

                                AppText(text:"Pricing plan for startup company",fontSize: 0.014, textColor: ConstantColor.light_black)
                              ],
                            ),
                          ],
                        ),
                      ),

                      Divider(
                        color: ConstantColor.priceYellowColor,
                        height: Get.height*0.002,
                      ),

                      Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                AppText(text:"599.00 /",fontSize: 0.024, textColor:  ConstantColor.priceYellowColor,fontFamily: ConstantString.fontbold,),
                                AppText(text:" Yearly",fontSize: 0.013, textColor: ConstantColor.priceYellowColor,fontFamily: ConstantString.fontRegular,),
                              ],
                            ),

                            SizedBox(height: Get.height*0.015,),

                            Row(
                              children: [
                                SvgPicture.asset(ConstantImage.yellow_tick),
                                SizedBox(width: Get.width*0.020,),
                                AppText(text:"Engine Oil Replacement",fontSize: 0.013, textColor: ConstantColor.text_color,fontFamily: ConstantString.fontRegular, fontWeight: FontWeight.w400,),
                              ],
                            ),

                            SizedBox(height: Get.height*0.010,),

                            Row(
                              children: [
                                SvgPicture.asset(ConstantImage.yellow_tick),
                                SizedBox(width: Get.width*0.020,),
                                AppText(text:"Oil Filter Replacement",fontSize: 0.013, textColor: ConstantColor.text_color,fontFamily: ConstantString.fontRegular, fontWeight: FontWeight.w400,),

                              ],
                            ),

                            SizedBox(height: Get.height*0.010,),

                            Row(
                              children: [
                                SvgPicture.asset(ConstantImage.yellow_tick),
                                SizedBox(width: Get.width*0.020,),
                                AppText(text:"Air Filter Cleaning",fontSize: 0.013, textColor: ConstantColor.text_color,fontFamily: ConstantString.fontRegular, fontWeight: FontWeight.w400,),

                              ],
                            ),

                            SizedBox(height: Get.height*0.010,),

                            Row(
                              children: [
                                SvgPicture.asset(ConstantImage.yellow_tick),
                                SizedBox(width: Get.width*0.020,),
                                AppText(text:"Coolant Top up",fontSize: 0.013, textColor: ConstantColor.text_color,fontFamily: ConstantString.fontRegular, fontWeight: FontWeight.w400,),
                              ],
                            ),

                            SizedBox(height: Get.height*0.010,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(


                                  decoration: BoxDecoration(
                                    color: ConstantColor.priceYellowColor,
                                    borderRadius: BorderRadius.circular(8), // Adjust the radius as needed
                                  ),

                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: AppText(text:"PURCHASE NOW",fontSize: 0.014, textColor:  Colors.white,fontFamily: ConstantString.fontbold,),
                                  ),

                                ),
                              ],
                            )

                          ],
                        ),
                      ),
                    ],
                  ),
                ),


                SizedBox(height: Get.height*0.030,),

                Container(

                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        spreadRadius: 5,
                        blurRadius: 8,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],

                    border: Border.all(color: ConstantColor.green_color, width: Get.width*0.002),
                    borderRadius:BorderRadius.all(Radius.circular(10)),
                  ),


                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            SvgPicture.asset(ConstantImage.supreme),

                            SizedBox(width: Get.width*0.030,),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(text:"Supreme Service",fontSize: 0.023, textColor: Colors.black,fontFamily: ConstantString.fontbold,),

                                AppText(text:"Pricing plan for startup company",fontSize: 0.014, textColor: ConstantColor.light_black)
                              ],
                            ),
                          ],
                        ),
                      ),

                      Divider(
                        color: ConstantColor.green_color,
                        height: Get.height*0.002,
                      ),

                      Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                AppText(text:"599.00 /",fontSize: 0.024, textColor:  ConstantColor.green_color,fontFamily: ConstantString.fontbold,),
                                AppText(text:" Yearly",fontSize: 0.013, textColor: ConstantColor.green_color,fontFamily: ConstantString.fontRegular,),
                              ],
                            ),

                            SizedBox(height: Get.height*0.015,),

                            Row(
                              children: [
                                SvgPicture.asset(ConstantImage.green_tick),
                                SizedBox(width: Get.width*0.020,),
                                AppText(text:"Engine Oil Replacement",fontSize: 0.013, textColor: ConstantColor.text_color,fontFamily: ConstantString.fontRegular, fontWeight: FontWeight.w400,),
                              ],
                            ),

                            SizedBox(height: Get.height*0.010,),

                            Row(
                              children: [
                                SvgPicture.asset(ConstantImage.green_tick),
                                SizedBox(width: Get.width*0.020,),
                                AppText(text:"Oil Filter Replacement",fontSize: 0.013, textColor: ConstantColor.text_color,fontFamily: ConstantString.fontRegular, fontWeight: FontWeight.w400,),

                              ],
                            ),

                            SizedBox(height: Get.height*0.010,),

                            Row(
                              children: [
                                SvgPicture.asset(ConstantImage.green_tick),
                                SizedBox(width: Get.width*0.020,),
                                AppText(text:"Air Filter Cleaning",fontSize: 0.013, textColor: ConstantColor.text_color,fontFamily: ConstantString.fontRegular, fontWeight: FontWeight.w400,),

                              ],
                            ),

                            SizedBox(height: Get.height*0.010,),

                            Row(
                              children: [
                                SvgPicture.asset(ConstantImage.green_tick),
                                SizedBox(width: Get.width*0.020,),
                                AppText(text:"Coolant Top up",fontSize: 0.013, textColor: ConstantColor.text_color,fontFamily: ConstantString.fontRegular, fontWeight: FontWeight.w400,),
                              ],
                            ),

                            SizedBox(height: Get.height*0.010,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(


                                  decoration: BoxDecoration(
                                    color: ConstantColor.green_color,
                                    borderRadius: BorderRadius.circular(8), // Adjust the radius as needed
                                  ),

                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: AppText(text:"PURCHASE NOW",fontSize: 0.014, textColor:  Colors.white,fontFamily: ConstantString.fontbold,),
                                  ),

                                ),
                              ],
                            )

                          ],
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          )



      ),
    );
  }
}
