import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:user/controller/diagnostic_controller.dart';

import '../../constants/color_constant.dart';
import '../../constants/image_constant.dart';
import '../../constants/string_constant.dart';
import '../../widget/app_text.dart';
import 'diagnostic_detail_screen.dart';

class DiagnosticToolsScreen extends StatelessWidget {
   DiagnosticToolsScreen({Key? key}) : super(key: key);

  final diagnosticController=Get.put(DiagnosticController());


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
              child: SvgPicture.asset(ConstantImage.yellowBack, fit: BoxFit.fill,),),
          Column(
            children: [
              SizedBox(height: Get.height*0.05,),
              Padding(
                padding:  EdgeInsets.only(left: Get.width*0.02,
                right: Get.width*0.02
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap:(){
                          Get.back();
              },
                        child: SvgPicture.asset(ConstantImage.back,
                          width: Get.width * 0.07,  // Adjust to your desired width
                          height: Get.height * 0.05,  // Adjust to your desired height
                        )),
                    AppText(text: "Diagnostic tools",fontWeight: FontWeight.w700,
                      fontFamily: ConstantString.fontbold,
                      fontSize: 0.022,textAlign: TextAlign.center,
                    ),
                    SizedBox(width: Get.width*0.09,)
                  ],
                ),
              ),

              SizedBox(height: Get.height*0.025,),
              Expanded(
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child:
                  Obx(() =>


                  (diagnosticController.loading!.value)?
                  Center(
                    child: Container(
                      height: 40,
                      color: Colors.transparent,
                      child: CircularProgressIndicator.adaptive(
                        valueColor: AlwaysStoppedAnimation<Color>(ConstantColor.gradiantLightColor),
                      ),
                    ),
                  ):

                  (diagnosticController.diagnosticList.isEmpty) ?
                  Center(
                    child: Text("No service history available"),
                  ):

                      ListView.builder(
                      shrinkWrap: true,
                      itemCount: diagnosticController.diagnosticList.length,
                      itemBuilder: (context,index){
                        return

                          GestureDetector(
                          onTap: (){
                            Get.to(DiagnosticDetailScreen(diagnosticController.diagnosticList[index].question, diagnosticController.diagnosticList[index].answer));
                          },

                          child: Container(
                            padding: EdgeInsets.all(8), // Adjust the h

                            margin: EdgeInsets.only(bottom: Get.height * 0.01,
                                top: Get.height*0.01,
                                left: Get.width*0.03,
                                right: Get.width*0.03),
                            decoration: BoxDecoration(
                                boxShadow: [BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 5.0,
                                ),],
                                color: Colors.white,
                                borderRadius:
                                BorderRadius.circular(Get.height * 0.01)),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [

                                        SizedBox(
                                          width: Get.width * 0.02,
                                        ),
                                        SizedBox(
                                          width: Get.width*0.7,
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              AppText(
                                                text: diagnosticController.diagnosticList[index].question,
                                                fontSize: 0.017,
                                                fontWeight: FontWeight.w700,
                                                fontFamily:
                                                ConstantString.fontbold,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              AppText(
                                                text: diagnosticController.diagnosticList[index].answer,
                                                fontSize: 0.014,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                fontWeight: FontWeight.w700,
                                                textColor:
                                                ConstantColor.textGrayColor,

                                              ),


                                              // SizedBox(
                                              //   width:200,
                                              //   child: Text(diagnosticController.diagnosticList[index].question.toString(),
                                              //     maxLines: 1,
                                              //     overflow: TextOverflow.ellipsis,
                                              //     style: TextStyle(
                                              //
                                              //       fontSize: 0.017,
                                              //       fontFamily:   ConstantString.fontbold,
                                              //       fontWeight: FontWeight.w700,
                                              //       color: Colors.black,
                                              //     ),
                                              //   ),
                                              // ),
                                              //
                                              // Text(diagnosticController.diagnosticList[index].answer.toString(),
                                              //   maxLines: 1, // Set to 1 to keep the text on a single line
                                              //   overflow: TextOverflow.ellipsis, // Truncate and show ellipsis if text overflows
                                              //   style: TextStyle(
                                              //     // Your text style here
                                              //     fontSize: 0.0014,
                                              //     fontFamily:   ConstantString.fontRegular,
                                              //     color: Colors.black,
                                              //   ),
                                              // )

                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Icon(Icons.arrow_forward_ios,color: Colors.grey,
                                      size: Get.height*0.025,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          );
                      }),)
                ),
              )

            ],
          ),
        ],
      ),
    );
  }
}
