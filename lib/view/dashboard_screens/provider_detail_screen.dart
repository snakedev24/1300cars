import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:user/Model/NewServiceListModel.dart';
import 'package:user/controller/provider_detail_controller.dart';
import '../../constants/color_constant.dart';
import '../../constants/image_constant.dart';
import '../../constants/string_constant.dart';
import '../../controller/home_controller.dart';
import '../../controller/service_list_controller.dart';
import '../../widget/app_text.dart';
import '../../widget/app_textfield.dart';
import '../../widget/auth_comman_button.dart';
import '../../widget/error_message_toast.dart';


class ProviderDetailScreen extends StatefulWidget {
  String? businessName;
  String? name;
  bool? isGoogle;
  String? location;
  double? latitude;
  double? longitude;
  String? startTime;
  String? endTime;
  List<ServicePrice>? servicePrice;
  List<String>? types;
  int? id;
  List<DiscountCoupons>? discountCoupons;
  dynamic ratings;
  String? membership;
  String? contactno;
  String? placeId;

  ProviderDetailScreen(this.businessName, this.name, this.isGoogle, this.location, this.latitude, this.longitude, this.startTime, this.endTime, this.servicePrice, this.types, this.id, this.discountCoupons, this.ratings, this.membership, this.contactno, this.placeId,    {
    Key? key,
  }) : super(key: key);

  @override
  State<ProviderDetailScreen> createState() => _ProviderDetailScreenState();
}

class _ProviderDetailScreenState extends State<ProviderDetailScreen> {
  final providerDetailController = Get.put(ProviderDetailController());
  final serviceController = Get.put(ServiceListController());
  final homeController = Get.put(HomeController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.isGoogle == true) {
      providerDetailController.getGoogleDetail(widget.placeId.toString(),
          widget.latitude.toString(), widget.longitude.toString());
    }else{

    }
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: Stack(
          children: [
            Image.asset(
              ConstantImage.backImage,
              fit: BoxFit.fill,
              width: Get.width,
            ), (widget.isGoogle == false) ?
            Padding(
                    padding: EdgeInsets.only(
                        top: Get.height * 0.07,
                        left: Get.width * 0.02,
                        right: Get.width * 0.02),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(Get.height * 0.008),
                          child: GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: SvgPicture.asset(
                                  ConstantImage.back,
                                  height: Get.height * 0.055,
                                )),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.08,
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: Get.width * 0.02, right: Get.width * 0.02),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.white),
                          child: Padding(
                            padding: EdgeInsets.all(Get.height * 0.015),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AppText(
                                      text: widget.name,
                                      fontSize: 0.022,
                                      fontWeight: FontWeight.w900,
                                      textColor: Colors.black,
                                      fontFamily: ConstantString.fontbold,
                                    ),
                                    (widget.membership.toString() == "Autocare Premium")?
                                    SvgPicture.asset(ConstantImage.tag_right_premium,):
                                    (widget.membership.toString() == "Garage VIP")?
                                    SvgPicture.asset(ConstantImage.tag_right_vip,)
                                        :SizedBox(height: Get.height * 0.001,),

                                  ],
                                ),
                                SizedBox(
                                  height: Get.height * 0.008,
                                ),
                                AppText(
                                  text: widget.businessName,
                                  fontSize: 0.017,
                                  fontWeight: FontWeight.w400,
                                  textColor: Colors.black,
                                ),
                                SizedBox(
                                  height: Get.height * 0.008,
                                ),
                                Row(
                                  children: [

                                    AppText(
                                      text: "(${widget.ratings})",
                                      fontSize: 0.018,
                                      fontWeight: FontWeight.w400,
                                      textColor: ConstantColor.light_black,
                                    ),

                                    SizedBox(
                                      width: Get.width * 0.003,
                                    ),


                                    RatingBar.builder(
                                      initialRating: widget.ratings,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: false,
                                      itemCount: 5,
                                      ignoreGestures: true,
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
                                  ],
                                ),

                                SizedBox(
                                  height: Get.height * 0.008,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    AppText(
                                      text: "Contact No.:- ${widget.contactno}",
                                      fontSize: 0.017,
                                      fontWeight: FontWeight.w400,
                                      textColor: Colors.black,
                                    ),


                                    GestureDetector(
                                        onTap: () async {
                                          Uri phoneno = Uri.parse(
                                              "tel:${widget.contactno}");
                                          if (await launchUrl(phoneno)) {

                                          } else {

                                          }
                                        },
                                        child: SvgPicture.asset(
                                            ConstantImage.call)),
                                  ],
                                ),
                                SizedBox(
                                  height: Get.height * 0.008,
                                ),
                                AppText(
                                  text: widget.location ?? "",
                                  fontSize: 0.017,
                                  fontWeight: FontWeight.w400,
                                  textColor: Colors.black,
                                ),
                                SizedBox(
                                  height: Get.height * 0.008,
                                ),

                                Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      Get.width * 0.0,
                                      Get.height * 0.0,
                                      Get.width * 0.012,
                                      Get.height * 0.00),
                                  child: Row(
                                    children: [
                                      AppText(
                                          text:
                                          "Start Time - "
                                              "${convert12HourTo24Hour(
                                             widget.startTime.toString()
                                          )}",
                                          fontSize: 0.016,
                                          fontWeight: FontWeight.w400,
                                          textColor: ConstantColor
                                              .light_black),
                                      SizedBox(
                                        width: Get.width * 0.01,
                                      ),
                                      SizedBox(
                                        width: Get.width * 0.01,
                                      ),
                                      AppText(
                                          text:
                                          "Closed Time - ${convert12HourTo24Hour(
                                             widget.endTime.toString())}",
                                          fontSize: 0.016,
                                          fontWeight: FontWeight.w400,
                                          textColor: ConstantColor
                                              .light_black),
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                        Container(
                          height: Get.height * 0.45,
                          margin: EdgeInsets.only(
                              left: Get.width * 0.02, right: Get.width * 0.02),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.white),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(Get.height * 0.02),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AppText(
                                        text: "Services we Provide",
                                        fontSize: 0.019,
                                        textColor: Colors.black,
                                        fontFamily: ConstantString.fontbold,
                                        fontWeight: FontWeight.w700),
                                    AppText(
                                        text: "Price",
                                        fontSize: 0.019,
                                        fontFamily: ConstantString.fontbold,
                                        fontWeight: FontWeight.w700),
                                  ],
                                ),
                              ),
                              Divider(
                                color: ConstantColor.darkWhite,
                              ),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),
                              MediaQuery.removePadding(
                                context: context,
                                removeBottom: true,
                                removeLeft: true,
                                removeRight: true,
                                removeTop: true,
                                child: Expanded(
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: widget.servicePrice!.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: EdgeInsets.only(
                                              right: Get.width * 0.04,
                                              left: Get.width * 0.04,
                                              bottom: Get.height * 0.01),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              AppText(
                                                text: widget.servicePrice?[index].service,
                                                fontSize: 0.014,
                                                fontWeight: FontWeight.w400,
                                                textColor:
                                                    ConstantColor.greyColor,
                                              ),
                                              AppText(
                                                text:
                                                    "\$${widget.servicePrice?[index].price ?? ""}",
                                                fontSize: 0.014,
                                                fontWeight: FontWeight.w400,
                                                textColor: ConstantColor
                                                    .priceYellowColor,
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                ),
                              ),


                              Padding(
                                padding: EdgeInsets.only(top: Get.height * 0.03, left: Get.width * 0.06, right:  Get.width * 0.06),
                                child: GestureDetector(
                                    onTap: () {
                                      serviceController.launchMapsUrl(double.parse(widget.latitude!.toString()),double.parse(widget.longitude!.toString()));
                                    },
                                    child: CommonButton(
                                      text: "Open this in Map",
                                    )),
                              ),

                              GestureDetector(
                                onTap: () {
                                  Get.dialog(
                                      barrierDismissible: false,

                                      Dialog(
                                        insetPadding: EdgeInsets.all(Get.width*0.08),
                                        backgroundColor: ConstantColor.grey,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color:
                                                ConstantColor.backgroundColor,
                                          ),
                                          child: SingleChildScrollView(
                                            child: Padding(
                                              padding: EdgeInsets.all(
                                                  Get.height * 0.012),
                                              child: Form(
                                                key: providerDetailController
                                                    .formKey,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                           EdgeInsets.all(
                                                              Get.height * 0.004),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [

                                                          GestureDetector(
                                                            onTap: () {
                                                              Get.back();
                                                            },
                                                            child: Image.asset(
                                                              ConstantImage
                                                                  .blue_cross,
                                                              height:
                                                                  Get.height *
                                                                      0.035,
                                                              width: Get.width *
                                                                  0.10,
                                                              // fit: BoxFit.fill,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),



                                                    Align(
                                                      child: AppText(
                                                        text:
                                                        "Book Service",
                                                        fontSize: 0.022,
                                                        fontFamily:
                                                        ConstantString
                                                            .fontbold,
                                                        textColor:
                                                        ConstantColor
                                                            .headingColor,textAlign: TextAlign.center,
                                                      ),
                                                    ),

                                                    SizedBox(
                                                        height:
                                                        Get.height * 0.020),

                                                    AppTextField(
                                                      validator: (val) {
                                                        if (val!.isEmpty)
                                                          return "Enter Name";
                                                        providerDetailController
                                                            .name = val;
                                                      },
                                                      keyBoardType:
                                                          TextInputType.text,
                                                      textController:
                                                          providerDetailController
                                                              .nameController,
                                                      hintText: "Name",
                                                      textColor: Colors.black,
                                                    ),


                                                    SizedBox(
                                                        height:
                                                            Get.height * 0.020),



                                                    AppTextField(
                                                      validator: (val) {
                                                        return providerDetailController
                                                            .validatePhoneNumber(
                                                                val!);
                                                      },
                                                      keyBoardType:
                                                          TextInputType.number,
                                                      textController:
                                                          providerDetailController
                                                              .phoneNoController,
                                                      hintText: "Phone Number",
                                                      textColor: Colors.black,
                                                      minChar: 15,
                                                      inputFormatters: [
                                                        FilteringTextInputFormatter
                                                            .allow(RegExp(
                                                                r'[0-9]')), // Allow only digits
                                                      ],
                                                    ),



                                                    SizedBox(
                                                        height:
                                                            Get.height * 0.020),

                                                    AppTextField(
                                                      validator: (val) {
                                                        if (val!.isEmpty)
                                                          return "Enter Loaction";
                                                        providerDetailController
                                                            .location = val;
                                                      },
                                                      keyBoardType:
                                                          TextInputType
                                                              .emailAddress,
                                                      textController:
                                                          providerDetailController
                                                              .locationController,
                                                      hintText: "location",
                                                      textColor: Colors.black,
                                                    ),

                                                    SizedBox(
                                                        height:
                                                            Get.height * 0.020),
                                                    GestureDetector(
                                                      onTap: () {
                                                        List<bool> temporaryCheckboxStates = List.generate(widget.servicePrice!.length, (index) => widget.servicePrice![index].isChecked.value);

                                                        Get.dialog(
                                                            barrierDismissible:
                                                                false,
                                                            Dialog(
                                                              backgroundColor:
                                                                  Colors.white,
                                                              child:
                                                                  SingleChildScrollView(
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                      .only(
                                                                      top: 8.0,
                                                                      bottom:
                                                                          8.0),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    children: [
                                                                      ListView.builder(
                                                                          shrinkWrap: true,
                                                                          itemCount: widget.servicePrice!.length,
                                                                          physics: NeverScrollableScrollPhysics(),
                                                                          itemBuilder: (BuildContext context, int indexType) {
                                                                            return ListTile(
                                                                                leading: Obx(() => Checkbox(
                                                                                      checkColor: Colors.white,
                                                                                      activeColor: Colors.blue,
                                                                                      value: widget.servicePrice![indexType].isChecked.value,
                                                                                      onChanged: (value) {
                                                                                        widget.servicePrice![indexType].isChecked.value = value!;
                                                                                      },
                                                                                    )),
                                                                                trailing: Text(
                                                                                  "\$${widget.servicePrice?[indexType].price ?? ""}",
                                                                                  style: TextStyle(color: Colors.green, fontSize: 15),
                                                                                ),
                                                                                title: Text(widget.servicePrice![indexType].service.toString()));
                                                                          }),
                                                                      SizedBox(
                                                                        height: Get.height *
                                                                            0.02,
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.end,
                                                                          children: [
                                                                            GestureDetector(
                                                                              onTap: () {
                                                                                for (int i = 0; i < widget.servicePrice!.length; i++) {
                                                                                  widget.servicePrice![i].isChecked.value = temporaryCheckboxStates[i];
                                                                                }
                                                                                Get.back();
                                                                              },
                                                                              child: Align(
                                                                                  alignment: Alignment.bottomCenter,
                                                                                  child: Container(
                                                                                      decoration: const BoxDecoration(
                                                                                        color: Colors.black,
                                                                                        borderRadius: BorderRadius.only(
                                                                                          topLeft: Radius.circular(50),
                                                                                          topRight: Radius.circular(50),
                                                                                          bottomLeft: Radius.circular(50),
                                                                                          bottomRight: Radius.circular(50),
                                                                                        ),
                                                                                      ),
                                                                                      child: Padding(
                                                                                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                                                                        child: Text(
                                                                                          "Cancel",
                                                                                          style: TextStyle(color: Colors.white),
                                                                                        ),
                                                                                      ))),
                                                                            ),
                                                                            SizedBox(
                                                                              width: Get.width * 0.02,
                                                                            ),
                                                                            GestureDetector(
                                                                              onTap: () {
                                                                                providerDetailController.selectedID.clear();
                                                                                providerDetailController.selectedItems.clear();
                                                                                providerDetailController.priceItem.clear();
                                                                                providerDetailController.totalPrice!.value=0.0;
                                                                                for (int i = 0; i < widget.servicePrice!.length; i++) {
                                                                                  if (widget.servicePrice![i].isChecked.value == true) {
                                                                                    providerDetailController.selectedID.add(widget.servicePrice![i].id!.toInt());
                                                                                    providerDetailController.selectedItems.add(widget.servicePrice![i].service.toString());
                                                                                    providerDetailController.priceItem.add(widget.servicePrice![i].price.toString());
                                                                                    providerDetailController.totalPrice!.value = (providerDetailController.totalPrice!.value + (double.tryParse(widget.servicePrice![i].price!) ?? 0.0));                                                                                  }
                                                                                }
                                                                                temporaryCheckboxStates = List.generate(widget.servicePrice!.length, (index) => widget.servicePrice![index].isChecked.value);
                                                                                Get.back();
                                                                              },
                                                                              child: Align(
                                                                                  alignment: Alignment.bottomCenter,
                                                                                  child: Container(
                                                                                      decoration: const BoxDecoration(
                                                                                        color: Colors.black,
                                                                                        borderRadius: BorderRadius.only(
                                                                                          topLeft: Radius.circular(50),
                                                                                          topRight: Radius.circular(50),
                                                                                          bottomLeft: Radius.circular(50),
                                                                                          bottomRight: Radius.circular(50),
                                                                                        ),
                                                                                      ),
                                                                                      child: Padding(
                                                                                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                                                                        child: Text(
                                                                                          "Okay",
                                                                                          style: TextStyle(color: Colors.white),
                                                                                        ),
                                                                                      ))),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ));
                                                      },
                                                      child: Container(
                                                        height:
                                                            Get.height * 0.07,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            border: Border.all(
                                                                color: Colors
                                                                    .grey)),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Obx(() => (providerDetailController
                                                                    .selectedItems
                                                                    .isNotEmpty)
                                                                ? Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            16.0),
                                                                    child:
                                                                        SizedBox(
                                                                      width: Get
                                                                              .width *
                                                                          0.55,
                                                                      height: Get
                                                                              .height *
                                                                          0.028,
                                                                      child: ListView.builder(
                                                                          shrinkWrap: true,
                                                                          scrollDirection: Axis.horizontal,
                                                                          itemCount: providerDetailController.selectedItems.length,
                                                                          itemBuilder: (context, index) {
                                                                            final currentItem =
                                                                                providerDetailController.selectedItems[index];
                                                                            final isLastItem =
                                                                                index == providerDetailController.selectedItems.length - 1;
                                                                            return AppText(
                                                                                text: isLastItem ? currentItem : '$currentItem,',
                                                                                fontSize: 0.018,
                                                                                fontWeight: FontWeight.w500);
                                                                          }),
                                                                    ),
                                                                  )
                                                                : Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                    child:
                                                                        AppText(text: "Select Services",
                                                                      fontSize: 0.018,
                                                                      fontWeight: FontWeight.w500,
                                                                      textColor: ConstantColor.grey,
                                                                    ),
                                                                  )),

                                                            const Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      right: 8),
                                                              child: Icon(Icons
                                                                  .arrow_drop_down),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        height:
                                                            Get.height * 0.020),

                                                    AppTextField(
                                                        callback: () async {
                                                          DateTime? pickedDate = await showDatePicker(
                                                                  context: context,
                                                                  initialDate: DateTime.now(),
                                                                  firstDate: DateTime.now(),
                                                                  lastDate:
                                                                      DateTime(
                                                                          2101));

                                                          if (pickedDate !=
                                                              null) {
                                                            print(pickedDate);
                                                            String
                                                                formattedDate =
                                                                DateFormat(
                                                                        'yyyy-MM-dd')
                                                                    .format(
                                                                        pickedDate);
                                                            print(
                                                                formattedDate);
                                                            providerDetailController
                                                                    .serviceTimeController
                                                                    .text =
                                                                formattedDate; //set output date to TextField value.
                                                          } else {
                                                            print(
                                                                "Date is not selected");
                                                          }
                                                        },
                                                        validator: (val) {
                                                          if (val!.isEmpty)
                                                            return "Enter Date";
                                                          providerDetailController
                                                              .time = val;
                                                        },
                                                        keyBoardType:
                                                            TextInputType
                                                                .emailAddress,
                                                        textController:
                                                            providerDetailController
                                                                .serviceTimeController,
                                                        hintText:
                                                            "Service Date",
                                                        textColor: Colors.black,
                                                        readOnly: true,
                                                        suffixIcon: Padding(
                                                          padding:
                                                               EdgeInsets
                                                                  .all(8.0),
                                                          child:
                                                              SvgPicture.asset(
                                                            ConstantImage
                                                                .calander,
                                                            width: 15,
                                                            height: 15,
                                                          ),
                                                        )),

                                                    SizedBox(
                                                        height:
                                                            Get.height * 0.020),

                                                    AppTextField(
                                                      callback: (){
                                                        providerDetailController.selectTime(context);
                                                      },
                                                      validator: (val) {
                                                        if (val!.isEmpty)
                                                          return "Enter Time";
                                                        providerDetailController
                                                            .date = val;
                                                      },
                                                      keyBoardType:
                                                          TextInputType
                                                              .emailAddress,
                                                      textController:
                                                          providerDetailController
                                                              .serviceDateController,
                                                      hintText: "Service Time",
                                                      textColor: Colors.black,
                                                      readOnly: true,
                                                      suffixIcon: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: SvgPicture.asset(
                                                          ConstantImage.timer,
                                                          width: 15,
                                                          height: 15,
                                                        ),
                                                      ),
                                                    ),

                                                    SizedBox(
                                                        height:
                                                            Get.height * 0.03),


                                                    (widget.discountCoupons!.isNotEmpty)?
                                                        AppTextField(
                                                            callback: () {
                                                              (providerDetailController.totalPrice!.value.toString() == "0.0")?
                                                              toastMessage("To get any discount please select any service"):
                                                              Get.dialog(
                                                                  barrierDismissible:
                                                                  false,
                                                                  Dialog(
                                                                    backgroundColor:
                                                                    Colors
                                                                        .white,
                                                                    child:
                                                                    SingleChildScrollView(
                                                                      child:
                                                                      Padding(
                                                                        padding: const EdgeInsets.only(
                                                                            top: 8.0,
                                                                            bottom: 8.0),
                                                                        child:
                                                                        Column(
                                                                          mainAxisSize:
                                                                          MainAxisSize.min,
                                                                          children: [
                                                                            ListView.builder(
                                                                                shrinkWrap: true,
                                                                                itemCount: widget.discountCoupons!.length,
                                                                                physics: NeverScrollableScrollPhysics(),
                                                                                itemBuilder: (BuildContext context, int indexType) {
                                                                                  return ListTile(
                                                                                    leading: Obx(() => Checkbox(
                                                                                      checkColor: Colors.white,
                                                                                      activeColor: Colors.blue,
                                                                                      value: widget.discountCoupons![indexType].isChecked.value,
                                                                                      onChanged: (value) {
                                                                                        for (int i = 0; i < widget.discountCoupons!.length; i++) {
                                                                                          widget.discountCoupons![i].isChecked.value = false;
                                                                                          providerDetailController.getDiscount!.value = 0;
                                                                                          providerDetailController.maximumPrice!.value = 0;
                                                                                          providerDetailController.disconutVoucher = "" ;
                                                                                        }
                                                                                        widget.discountCoupons![indexType].isChecked.value = value!;
                                                                                        providerDetailController.getDiscount!.value = widget.discountCoupons![indexType].discount!;
                                                                                        providerDetailController.maximumPrice!.value = widget.discountCoupons![indexType].maximumDiscount!;
                                                                                        providerDetailController.disconutVoucher =widget.discountCoupons![indexType].discountToken!;
                                                                                        providerDetailController.discountName.value = widget.discountCoupons![indexType].couponName.toString();
                                                                                      },
                                                                                    )),
                                                                                    title: Text(widget.discountCoupons![indexType].couponName.toString() ?? ""),
                                                                                    subtitle: Text("${widget.discountCoupons![indexType].discount.toString()}% OFF up to ${widget.discountCoupons![indexType].maximumDiscount.toString()}"
                                                                                    ),
                                                                                  );
                                                                                }),
                                                                            SizedBox(
                                                                              height:
                                                                              Get.height * 0.02,
                                                                            ),
                                                                            Padding(
                                                                              padding:
                                                                              const EdgeInsets.all(8.0),
                                                                              child:
                                                                              Row(
                                                                                mainAxisAlignment: MainAxisAlignment.end,
                                                                                children: [
                                                                                  GestureDetector(
                                                                                    onTap: () {
                                                                                      providerDetailController.getDiscount!.value = 0;
                                                                                      providerDetailController.maximumPrice!.value = 0;
                                                                                      providerDetailController.disconutVoucher ="";
                                                                                      providerDetailController.discountController.text = "";

                                                                                      Get.back();
                                                                                    },
                                                                                    child: Align(
                                                                                        alignment: Alignment.bottomCenter,
                                                                                        child: Container(
                                                                                            decoration: const BoxDecoration(
                                                                                              color: Colors.black,
                                                                                              borderRadius: BorderRadius.only(
                                                                                                topLeft: Radius.circular(50),
                                                                                                topRight: Radius.circular(50),
                                                                                                bottomLeft: Radius.circular(50),
                                                                                                bottomRight: Radius.circular(50),
                                                                                              ),
                                                                                            ),
                                                                                            child: Padding(
                                                                                              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                                                                              child: Text(
                                                                                                "Cancel",
                                                                                                style: TextStyle(color: Colors.white),
                                                                                              ),
                                                                                            ))),
                                                                                  ),

                                                                                  SizedBox(
                                                                                    width: Get.width * 0.02,
                                                                                  ),


                                                                                  GestureDetector(
                                                                                    onTap: () {
                                                                                      final double totalPrice = double.parse(providerDetailController.totalPrice!.value.toString());
                                                                                      final double getDiscount = double.parse(providerDetailController.getDiscount!.value.toString());
                                                                                      final double discountedPrice =totalPrice * getDiscount/100;
                                                                                      if(discountedPrice<providerDetailController.maximumPrice!.value){
                                                                                        providerDetailController.priceGet.value =(totalPrice- discountedPrice).toString();
                                                                                      }else{
                                                                                        providerDetailController.priceGet.value =(totalPrice- providerDetailController.maximumPrice!.value).toString();
                                                                                      }
                                                                                    //  providerDetailController.discountController.text =  "${providerDetailController.discountName} Save Upto \$${(totalPrice - double.parse(providerDetailController.priceGet.toString())).toString() }" ;
                                                                                      Get.back();
                                                                                    },
                                                                                    child: Align(
                                                                                        alignment: Alignment.bottomCenter,
                                                                                        child: Container(
                                                                                            decoration: const BoxDecoration(
                                                                                              color: Colors.black,
                                                                                              borderRadius: BorderRadius.only(
                                                                                                topLeft: Radius.circular(50),
                                                                                                topRight: Radius.circular(50),
                                                                                                bottomLeft: Radius.circular(50),
                                                                                                bottomRight: Radius.circular(50),
                                                                                              ),
                                                                                            ),
                                                                                            child: Padding(
                                                                                              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                                                                              child: Text(
                                                                                                "Okay",
                                                                                                style: TextStyle(color: Colors.white),
                                                                                              ),
                                                                                            ))),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ));
                                                            },

                                                            keyBoardType: TextInputType.text,
                                                            textController: providerDetailController.discountController,
                                                            hintText: "Coupon",
                                                            textColor: Colors.black,
                                                            readOnly: true,
                                                            maxLines: 2,
                                                            fontSize: 0.012,
                                                            suffixIcon: Padding(
                                                                padding:
                                                                EdgeInsets.only(right : Get.width*0.07, top: Get.height*0.015),
                                                                child:
                                                                Text("Apply", style: TextStyle(color: ConstantColor.light_black),)
                                                            )
                                                        ) :

                                                    SizedBox(
                                                        height:
                                                        Get.height * 0.0001),


                                                    SizedBox(
                                                        height:
                                                        Get.height * 0.02),



                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        AppText(
                                                          text: "Total price",
                                                          fontSize: 0.019,
                                                          fontWeight:
                                                              FontWeight.w900,
                                                          textColor:
                                                              ConstantColor
                                                                  .darkYellow,
                                                        ),
                                                        Obx(() =>  AppText(
                                                          text: "\$${providerDetailController.totalPrice!.value.toString()}",
                                                          fontSize: 0.019,
                                                          fontWeight:
                                                          FontWeight.w900,
                                                          textColor:
                                                          ConstantColor
                                                              .darkYellow,
                                                        )),
                                                      ],
                                                    ),

                                                    SizedBox(
                                                        height: Get.height * 0.01),


                                                    (widget.discountCoupons!.isNotEmpty)?
                                                      Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          AppText(
                                                            text: "After Discount price",
                                                            fontSize: 0.019,
                                                            fontWeight:
                                                            FontWeight.w900,
                                                            textColor:
                                                            ConstantColor
                                                                .darkYellow,
                                                          ),
                                                          Obx(() =>  AppText(
                                                            text:  "\$${providerDetailController.priceGet.value.toString()}",
                                                            fontSize: 0.019,
                                                            fontWeight:
                                                            FontWeight.w900,
                                                            textColor:
                                                            ConstantColor
                                                                .darkYellow,
                                                          )),
                                                        ],
                                                      ):
                                                    SizedBox(
                                                        height:
                                                        Get.height * 0.00001),


                                                    SizedBox(
                                                        height:
                                                            Get.height * 0.020),

                                                    GestureDetector(
                                                      onTap: () {
                                                        if (providerDetailController.selectedID.isNotEmpty) {
                                                          if (providerDetailController.formKey.currentState!.validate()) {

                                                            Get.dialog(

                                                                barrierDismissible:
                                                                false,
                                                                Dialog(
                                                                  backgroundColor:
                                                                  Colors.white,
                                                                  child:
                                                                  SingleChildScrollView(
                                                                    child: Padding(
                                                                      padding:  EdgeInsets
                                                                          .only(
                                                                          top: Get.height*0.04,
                                                                          bottom: Get.height*0.03,
                                                                      left: Get.width*0.05,
                                                                      right: Get.width*0.05),
                                                                      child: Column(
                                                                        mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                        children: [

                                                                          Container(

                                                                            child: AppText(
                                                                              text: "Are you sure you want to pay with your card number 9087 and amount \$${providerDetailController.totalPrice!.value.toString()}",
                                                                              fontSize: 0.019,
                                                                              fontWeight:
                                                                              FontWeight.w900,
                                                                              textColor:
                                                                              ConstantColor
                                                                                  .light_black,
                                                                            ),
                                                                          ),


                                                                          SizedBox(height : Get.height*0.03),


                                                                          Row(
                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                            children: [
                                                                              GestureDetector(
                                                                                  onTap: () {
                                                                                    Get.back();
                                                                                  },
                                                                                  child:
                                                                                  Container(
                                                                                    width: Get.width * 0.3,
                                                                                    decoration: BoxDecoration(
                                                                                      color: Colors.white,
                                                                                      borderRadius: BorderRadius
                                                                                          .all(
                                                                                          Radius.circular(10)),
                                                                                      border: Border.all(
                                                                                          color: Colors.red),


                                                                                    ),
                                                                                    alignment: Alignment.center,
                                                                                    child: Padding(
                                                                                        padding: const EdgeInsets
                                                                                            .all(16.0),
                                                                                        child: AppText(
                                                                                          text: "Cancel",
                                                                                          fontWeight: FontWeight
                                                                                              .w700,
                                                                                          fontFamily: ConstantString
                                                                                              .fontbold,
                                                                                          textColor: Colors.red,
                                                                                          fontSize: 0.018,
                                                                                        )),
                                                                                  )),
                                                                              SizedBox(width : Get.width*0.04),
                                                                              GestureDetector(
                                                                                  onTap: () {
                                                                                    providerDetailController.serviceBooking(widget.id);
                                                                                  },
                                                                                  child:
                                                                                  Container(
                                                                                    width: Get.width * 0.3,
                                                                                    decoration: BoxDecoration(
                                                                                      borderRadius: BorderRadius
                                                                                          .all(
                                                                                          Radius.circular(10)),
                                                                                      boxShadow: [
                                                                                        BoxShadow(
                                                                                          color: Colors.grey
                                                                                              .withOpacity(0.5),
                                                                                          // Shadow color
                                                                                          spreadRadius: 2,
                                                                                          // Spread radius
                                                                                          blurRadius: 4,
                                                                                          // Blur radius
                                                                                          offset: Offset(0,
                                                                                              2), // Offset from top-left
                                                                                        ),
                                                                                      ],
                                                                                      gradient: LinearGradient(
                                                                                        begin: Alignment.topRight,
                                                                                        end: Alignment.bottomLeft,
                                                                                        colors: [
                                                                                          ConstantColor
                                                                                              .gradiantDarkColor,
                                                                                          ConstantColor
                                                                                              .gradiantLightColor,

                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    alignment: Alignment.center,
                                                                                    child: Padding(
                                                                                        padding: const EdgeInsets
                                                                                            .all(16.0),
                                                                                        child: AppText(
                                                                                          text: "Procced",
                                                                                          fontWeight: FontWeight
                                                                                              .w700,
                                                                                          textColor: Colors.white,
                                                                                          fontFamily: ConstantString
                                                                                              .fontbold,
                                                                                          fontSize: 0.018,
                                                                                        )),
                                                                                  )),
                                                                            ],
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ));
                                                          }
                                                        } else {
                                                          toastMessage("please select at least one service");
                                                        }
                                                      },
                                                      child: CommonButton(text: "Proceed to Pay",),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ));
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(Get.height * 0.03),
                                  child: CommonButton(
                                    text: "Book Service",
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                :
                Obx(() =>
            (providerDetailController.isLoader.value)?
            Center(
              child: Container(
                height: 40,
                color: Colors.transparent,
                child: CircularProgressIndicator.adaptive(
                  valueColor: AlwaysStoppedAnimation<Color>(ConstantColor.gradiantLightColor),
                ),
              ),
            )
            :Padding(
                    padding: EdgeInsets.only(
                        top: Get.height * 0.07,
                        left: Get.width * 0.02,
                        right: Get.width * 0.02),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(Get.height * 0.008),
                            child: GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: SvgPicture.asset(
                                    ConstantImage.back,
                                    height: Get.height * 0.055,
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.08,
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: Get.width * 0.02, right: Get.width * 0.02),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Colors.white),
                            child: Padding(
                              padding: EdgeInsets.all(Get.height * 0.015),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(

                                        child: Container(
                                          child: AppText(
                                            text: widget.businessName??"",
                                            fontSize: 0.022,
                                            fontWeight: FontWeight.w900,
                                            textColor: Colors.black,
                                            fontFamily: ConstantString.fontbold,
                                          ),


                                          width: Get.width*0.8,
                                        ),
                                      ),

                                    ],
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.008,
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.008,
                                  ),
                                  Row(
                                    children: [

                                      Obx(() =>
                                          AppText(
                                            text: "${providerDetailController.ratingCount.value.toString()} ",
                                            fontSize: 0.018,
                                            fontWeight: FontWeight.w400,
                                            textColor: ConstantColor.light_black,
                                          )),

                                      RatingBar.builder(
                                        initialRating: widget.ratings,
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

                                      Obx(() =>
                                          AppText(
                                            text: "(${providerDetailController.ratingNo.value.toInt().toString()}) .",
                                            fontSize: 0.018,
                                            fontWeight: FontWeight.w400,
                                            textColor: ConstantColor.light_black,
                                          )),

                                      SizedBox(
                                        width: Get.width * 0.008,
                                      ),

                                      Obx(() =>
                                      AppText(
                                        text: providerDetailController.distance.value,
                                        fontSize: 0.018,
                                        fontWeight: FontWeight.w400,
                                        textColor: ConstantColor.light_black,
                                      )),

                                    ],
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.008,
                                  ),



                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Obx(() =>
                                        AppText(
                                          text: "Contact No.:- ${providerDetailController.googlenumber.value}",
                                          fontSize: 0.018,
                                          fontWeight: FontWeight.w400,
                                          textColor: ConstantColor.light_black,
                                        )),


                                        GestureDetector(
                                            onTap: () async {
                                              Uri phoneno = Uri.parse(
                                                  "tel:${providerDetailController.googlenumber.value.toString()}");
                                              if (await launchUrl(phoneno)) {

                                              } else {

                                              }
                                            },
                                            child: SvgPicture.asset(
                                                ConstantImage.call)),
                                      ],
                                    ),


                                  SizedBox(
                                    height: Get.height * 0.009,
                                  ),


                                  AppText(
                                      text: widget.location??"",
                                      fontSize: 0.017,
                                      fontWeight: FontWeight.w400,
                                      textColor: Colors.black,
                                    ),



                                  SizedBox(
                                    height: Get.height * 0.008,
                                  ),


                                  Row(

                                    children: [
                                      (providerDetailController.openShopCheck == true)?
                                           AppText(
                                             text: "Opened",
                                             fontSize: 0.018,
                                             fontWeight: FontWeight.w400,
                                             textColor: ConstantColor.green_color,
                                           ):
                                       AppText(
                                          text: "Closed",
                                          fontSize: 0.018,
                                          fontWeight: FontWeight.w400,
                                          textColor: ConstantColor.redColor,

                                      ),
                                      SizedBox(width: Get.width*0.02,),

                                    ],
                                  ),


                                  Obx(() => GestureDetector(
                                      onTap: (){
                                        providerDetailController.open.value =! providerDetailController.open.value;
                                      },
                                      child: Row(
                                        children: [

                                          AppText(
                                            text: "Opening hours",
                                            fontSize: 0.018,
                                            fontWeight: FontWeight.w400,
                                            textColor: Colors.black,

                                          ),
                                          Icon((providerDetailController.open.value)?Icons.keyboard_arrow_up_rounded:Icons.keyboard_arrow_down_rounded),
                                        ],
                                      )),),


                                  Obx(() =>
                                  (providerDetailController.open.value)?
                                      SizedBox():
                                  Container(
                                    height: Get.height*0.2,

                                    decoration: BoxDecoration(
                                      color: Colors.white
                                    ),
                                    child: MediaQuery.removePadding(
                                      context: context,
                                      removeTop: true,
                                      child: ListView.builder(
                                          itemCount:  providerDetailController.dayList.length,
                                          itemBuilder: (context,index){
                                        return Padding(
                                          padding:  EdgeInsets.only(bottom: 4),
                                          child: Text(providerDetailController.dayList[index],
                                          style: TextStyle(fontSize: Get.height*0.017,fontFamily: ConstantString.fontRegular,
                                          color: Colors.black),
                                          ),
                                        );
                                      }),
                                    ),



                                  ))



                                ],
                              ),
                            ),



                          ),
                          SizedBox(
                            height: Get.height * 0.03,
                          ),
                          Padding(
                            padding: EdgeInsets.all(Get.height * 0.03),
                            child: GestureDetector(
                                onTap: () {
                                  serviceController.launchMapsUrl(double.parse(widget.latitude!.toString()),double.parse(widget.longitude!.toString()));
                                },
                                child: CommonButton(
                                  text: "Open this in Map",
                                )),
                          )

                        ],
                      ),
                    ),
                  ))
          ],
        ));
  }

  String convert12HourTo24Hour(String time12Hour) {
    final inputFormat = DateFormat('HH:mm');
    final outputFormat = DateFormat('h:mm a');
    final dateTime = inputFormat.parse(time12Hour);
    final time24Hour = outputFormat.format(dateTime);
    return time24Hour;
  }
}
