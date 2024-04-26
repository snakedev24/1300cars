import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:user/view/dashboard_screens/appointment_details.dart';

import '../../common/loginDialog.dart';
import '../../constants/color_constant.dart';
import '../../constants/image_constant.dart';
import '../../constants/string_constant.dart';
import '../../controller/appointment_controller.dart';
import '../../pref/shared_preference.dart';
import '../../widget/app_text.dart';

class AppointmentScreen extends StatefulWidget {
   AppointmentScreen({Key? key}) : super(key: key);

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {

  @override
  void initState() {
    super.initState();
    if((SharedPreference.getBool(ConstantString.guestUser) == false)){
      appointmentController.search="";
      appointmentController.appointment();
    }
  }

  final appointmentController = Get.put(AppointmentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstantColor.dashBackColor,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Image.asset(ConstantImage.appointment_bg, height: Get.height * 0.23, fit: BoxFit.fill,),
          ),

          Padding(
            padding: EdgeInsets.only(
                top: Get.height * 0.06,
                left: Get.width * 0.04,
                right: Get.width * 0.04),
            child:
            (SharedPreference.getBool(ConstantString.guestUser) == true)?
           Center(child: GestureDetector(
             onTap: (){
               loginDialog();
             },
             child: Text("Please login to access this feature"
             ,style: TextStyle(
                 fontSize: Get.height*0.024,
                 fontFamily: ConstantString.fontRegular
               ),
             ),
           ),):

            Column(
              children: [
                Obx(() =>
                (appointmentController.checkSearchField!.value)?
                Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.transparent, borderRadius: BorderRadius.circular(5)),
                  child: Center(
                    child: TextField(
                      // controller: appointmentController.searchTextController,
                      onChanged: (value){
                        appointmentController.search=value;
                        appointmentController.appointment();
                        },
                      textCapitalization :TextCapitalization.sentences,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              appointmentController.search = "";
                              // appointmentController.searchTextController.clear();
                              appointmentController.checkSearchField!.value=false;
                              appointmentController.appointment();
                            },
                          ),

                          hintText: 'Search...',
                          border: InputBorder.none),
                    ),
                  ),
                )
                    :Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: Get.width*0.09,),
                    AppText(text: "Appointment", fontSize: 0.022, fontWeight: FontWeight.w700,
                      fontFamily: ConstantString.fontbold,),
                    GestureDetector(
                      onTap: (){
                        appointmentController.checkSearchField!.value=true;
                      },


                      child:
                      ( appointmentController.appointmentList.isNotEmpty)?
                      Container(
                          margin: EdgeInsets.only(right: Get.width*0.02),
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white
                          ),
                          child: Icon(Icons.search)


                      ):
                      SizedBox(),
                    ),
                  ],
                )),

                SizedBox(
                  height: Get.height * 0.02,
                ),

                Expanded(
                    child: Obx(
                  () => (appointmentController.loading!.value)?
                    Center(
                      child: Container(
                        height: 40,
                        color: Colors.transparent,
                        child: CircularProgressIndicator.adaptive(
                          valueColor: AlwaysStoppedAnimation<Color>(ConstantColor.gradiantLightColor),
                        ),
                      ),
                    ):
                    (appointmentController.appointmentList.isEmpty)?
                    Center(child: Text("No Appointment found")):
                    ListView.builder(
                                shrinkWrap: true,
                                itemCount: appointmentController.appointmentList.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Get.to(AppointmentDetails(
                                          appointmentController.appointmentList[index].name,
                                        appointmentController.appointmentList[index].serviceTime,
                                          appointmentController.appointmentList[index].location,
                                          appointmentController.appointmentList[index].id,
                                          appointmentController.appointmentList[index].service,
                                          appointmentController.appointmentList[index].providerStatus,
                                        appointmentController.appointmentList[index].provider!.image,
                                        (appointmentController.appointmentList[index].provider!.ratings==0)?0.0:appointmentController.appointmentList[index].provider!.ratings,
                                        appointmentController.appointmentList[index].serviceDate,

                                          ));
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.only(
                                  bottom: Get.height * 0.02),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.circular(
                                      Get.height * 0.01)),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .center,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                              ConstantImage.calander),
                                          SizedBox(
                                            width: Get.width * 0.02,),
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              AppText(
                                                text: appointmentController
                                                    .appointmentList[index]
                                                    .name,
                                                fontSize: 0.017,
                                                fontWeight: FontWeight
                                                    .w700,
                                                fontFamily:
                                                ConstantString.fontbold,
                                              ),


                                              // Container(
                                              //   width: 100,
                                              //   child:
                                              //
                                              //   AppText(
                                              //     text: appointmentController.appointmentList[index]!.service![0].service.toString(),
                                              //     fontSize: 0.014,
                                              //     fontWeight: FontWeight
                                              //         .w700,
                                              //     textColor:
                                              //     ConstantColor
                                              //         .textGrayColor,
                                              //     overflow:  TextOverflow.ellipsis,
                                              //   ),),

                                              AppText(
                                                text:appointmentController
                                                    .appointmentList[index].provider!.businessName!.toString(),
                                                fontSize: 0.015,
                                                fontWeight: FontWeight
                                                    .w700,
                                                textColor:
                                                ConstantColor
                                                    .textGrayColor,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      (appointmentController.appointmentList[index].providerStatus == "blank")
                                          ? GestureDetector(
                                          onTap: (){
                                            appointmentController.cancelRequest(appointmentController.appointmentList[index].id!.toString());

                                          },

                                          child: AppText(text: "Cancel Request", fontSize: 0.016, fontWeight: FontWeight.w700, textColor: ConstantColor.redColor,))
                                          : (appointmentController
                                          .appointmentList[index]
                                          .providerStatus ==
                                          "accept")
                                          ? GestureDetector(
                                        onTap: (){

                                          appointmentController.socketOn(appointmentController.appointmentList[index].provider!.user, appointmentController.appointmentList[index].roomName, appointmentController.appointmentList[index].provider!.name.toString());

                                        },
                                            child: SvgPicture.asset(
                                            ConstantImage.chatsvg),
                                          )
                                          : AppText(
                                        text: "Rejected",
                                        fontSize: 0.016,
                                        fontWeight: FontWeight.w700,
                                        textColor:
                                        ConstantColor.redColor,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
