import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:user/controller/emergency_Controller.dart';

import '../../constants/color_constant.dart';
import '../../constants/image_constant.dart';
import '../../constants/string_constant.dart';
import '../../widget/app_text.dart';
import '../../widget/app_textfield.dart';
import '../../widget/auth_comman_button.dart';

class EmergencyContactScreen extends StatelessWidget {
   EmergencyContactScreen({Key? key}) : super(key: key);
  final emergencyController = Get.put(EmergencyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      floatingActionButton: FloatingActionButton(


        onPressed: () {
          Get.bottomSheet(

            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0), // Adjust the radius as needed
                topRight: Radius.circular(25.0), // Adjust the radius as needed
              ),
              child :Container(
                color: ConstantColor.backgroundColor,
                child: SingleChildScrollView(
                  child: Padding(
                    padding:  EdgeInsets.only(left: Get.width*0.05,right: Get.width*0.05,top: Get.height*0.01),
                    child: Form(
                      key: emergencyController.formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [

                          SizedBox(height: Get.height*0.02),

                          Container(
                            height: Get.height*0.01,
                            width: Get.width*0.2,
                            decoration: const BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                            ),),
                          SizedBox(height: Get.height*0.03,),

                          Text("Add Emeregency Contact", style: TextStyle(fontFamily: ConstantString.fontbold, fontSize: Get.height*0.025),),

                          SizedBox(height: Get.height*0.03),

                          AppTextField(validator: (val) {
                            if (val!.isEmpty) return "Enter Name";
                            emergencyController.name = val;
                          },
                              textCapitalization :TextCapitalization.sentences,
                              textInputAction: TextInputAction.next,
                              textController: emergencyController.nameConttoller,

                              hintText:  'Name', textColor: ConstantColor.light_black),


                          SizedBox(height: Get.height*0.02),


                          AppTextField(


                              validator: (val) {
                                if (val!.isEmpty)

                                  return emergencyController.validateContact(val!);
                                return emergencyController.validateContactNumber(val!);

                                emergencyController.number = val;
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')), // Allow only digits
                              ],
                              keyBoardType: TextInputType.number,
                              minChar: 15,
                              textController: emergencyController.numberConttoller, hintText:  'Contact Number', textColor: ConstantColor.light_black),


                          SizedBox(height: Get.height*0.02,),

                          GestureDetector(
                              onTap: (){
                                FocusScope.of(context).requestFocus(new FocusNode());
                                if(emergencyController.formKey.currentState!.validate()){
                                  emergencyController.addEmergencyContact();

                                }
                              },
                              child: CommonButton(text:"Add Contact")),

                          SizedBox(height: Get.height*0.02),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            isScrollControlled: true,
          );
        },

        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50.0))),

        child: Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,

              gradient: LinearGradient(colors: [
                ConstantColor.gradiantLightColor,
                ConstantColor.gradiantDarkColor
              ])),
          child: const Icon(
            Icons.add,
            size: 55,
            color:  Colors.white,
          ),
        ),
      ),




    body:  Stack(

      children: [
        Positioned(
          top: 0,
          right: 0,
          bottom: 0,
          left: 0,
          child: SvgPicture.asset(ConstantImage.yellowBack, fit: BoxFit.fill,),),


        Padding(
          padding:  EdgeInsets.only(left: Get.width*0.04,
              right: Get.width*0.04
          ),
          child: Column(
            children: [
              SizedBox(height: Get.height*0.05,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: (){
                      Get.back();},
                      child: SvgPicture.asset(ConstantImage.back,width: Get.width*0.09,)),

                  AppText(text: "Emergency Contact List",fontWeight: FontWeight.w700,
                    fontSize: 0.02,),

                  Container(
                    padding: EdgeInsets.all(Get.height*0.005),
                  )
                ],
              ),

              SizedBox(height: Get.height*0.025),

              Expanded(


                child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    removeLeft: true,
                    removeRight: true,
                    child:
                    Obx(() => (emergencyController.loading!.value)?
                    Center(
                      child: Container(
                        height: 40,
                        color: Colors.transparent,
                        child: CircularProgressIndicator.adaptive(
                          valueColor: AlwaysStoppedAnimation<Color>(ConstantColor.gradiantLightColor),
                        ),
                      ),
                    ):

                    (emergencyController.foundContact.isEmpty)?
                    Center(
                      child: Text("List is empty"),):
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: emergencyController.foundContact.length,
                        itemBuilder: (context,index){
                          return    Container(
                            padding: EdgeInsets.all(Get.height*0.004),
                            margin: EdgeInsets.only(bottom: Get.height * 0.02),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                BorderRadius.circular(Get.height * 0.01),

                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1), // Shadow color
                                spreadRadius: 2, // How far the shadow spreads
                                blurRadius: 3, // How blurry the shadow is
                                offset: Offset(0, 3), // Offset of the shadow
                              ),
                            ],
                            ),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(Get.height*0.014),

                                          decoration: BoxDecoration(
                                            color: Colors.green,
                                            shape: BoxShape.circle,

                                          ),
                                          child: AppText(text: emergencyController.foundContact[index].name![0]
                                              .toUpperCase(),
                                            fontWeight: FontWeight.w700,
                                            fontSize: 0.04,
                                            textColor: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          width: Get.width * 0.03,
                                        ),
                                        SizedBox(
                                            width:Get.width*0.4,
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                AppText(
                                                  text: emergencyController.foundContact[index].name,
                                                  fontSize: 0.018,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily:
                                                  ConstantString.fontbold,
                                                ),
                                                AppText(
                                                  text:  emergencyController.foundContact[index].phoneNumber,
                                                  fontSize: 0.014,
                                                  fontWeight: FontWeight.w700,
                                                  textColor:
                                                  ConstantColor.textGrayColor,
                                                ),

                                              ],
                                            )),
                                      ],
                                    ),

                                    (emergencyController.foundContact[index].isDefault == true)

                                        ? Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: Get.height * 0.01,
                                          vertical: Get.height * 0.006),
                                      decoration: BoxDecoration(
                                          color: ConstantColor.lightBlue,
                                          borderRadius:
                                          BorderRadius.circular(12)),
                                      child: AppText(
                                        text: "Default",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 0.016,
                                        textColor: Colors.black,
                                      ),
                                    )


                                        :  GestureDetector(
                                      onTap: (){
                                        emergencyController.adddefault(emergencyController.emergencyList[index].id);

                                      },

                                             child: Container(
                                               padding: EdgeInsets.symmetric(
                                                   horizontal: Get.height*0.01,
                                                   vertical: Get.height*0.006
                                               ),

                                        decoration: BoxDecoration(
                                            color: ConstantColor.lightGreen,
                                            borderRadius: BorderRadius.circular(12)


                                        ),
                                        child: AppText(text: "setDefault",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 0.016,
                                          textColor: Colors.black,
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                              ],
                            ),
                          );
                        }))
                ),
              )

            ],
          ),
        ),
      ],
    ),
    );
  }
}
