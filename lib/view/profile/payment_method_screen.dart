import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:user/constants/color_constant.dart';
import 'package:user/constants/string_constant.dart';
import 'package:user/widget/app_text.dart';
import 'package:user/widget/app_textfield.dart';
import 'package:user/widget/auth_comman_button.dart';
import '../../constants/image_constant.dart';
import '../../controller/card_controller.dart';
import '../../widget/error_message_toast.dart';

class CardListScreen extends StatefulWidget {
  bool? checkCardChange;
  CardListScreen({Key? key, this.checkCardChange}) : super(key: key);
  @override
  _CardListScreenState createState() => _CardListScreenState();
}

class _CardListScreenState extends State<CardListScreen> {
  final cardController = Get.put(CardController());


  @override
  void initState() {
    super.initState();
    cardController.card();
  }

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
                      key: cardController.formKey,
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

                          Text("Add new card", style: TextStyle(fontFamily: ConstantString.fontbold, fontSize: Get.height*0.025),),

                          SizedBox(height: Get.height*0.03),

                          AppTextField(validator: (val) {
                            if (val!.isEmpty) return "Enter Name";
                            cardController.holderName = val;
                          },
                              textInputAction: TextInputAction.next,
                              textController: cardController.holderNameConttoller, hintText:  'Name on card', textColor: ConstantColor.light_black),


                          SizedBox(height: Get.height*0.02),





                          AppTextField(
                            validator: (val) {
                              if (val!.isEmpty) return cardController.validationNumber(val!);
                              cardController.accountnumber = val;
                            },
                            textInputAction: TextInputAction.next,
                            keyBoardType: TextInputType.number,
                            minChar: 16,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                              // Allow only digits
                            ],

                            textController: cardController.accountnumberConttoller,
                            hintText: 'Card number',
                            textColor: ConstantColor.light_black,
                            onChanged: (value) {
                              value = value.replaceAll(RegExp(r"\D"), ""); // Remove non-digit characters
                              final formattedValue = <String>[];
                              for (int i = 0; i < value.length; i += 4) {
                                final endIndex = i + 4;
                                if (endIndex <= value.length) {
                                  formattedValue.add(value.substring(i, endIndex));
                                } else {
                                  formattedValue.add(value.substring(i));
                                }
                              }
                              cardController.accountnumberConttoller.text = formattedValue.join('-');
                              cardController.accountnumber = value; // Store the original value
                            },
                          ),



                        SizedBox(height: Get.height*0.02),


                          AppTextField(
                              validator: (val) {
                        return cardController.validationExpire(val!);
                              },

                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')), // Allow only digits
                            ],
                            textInputAction: TextInputAction.done,
                            keyBoardType: TextInputType.number,
                              textController: cardController.expireDateConttoller, hintText:  'Card Expire Date', textColor: ConstantColor.light_black,    onChanged: (value){
                            value = value.replaceAll(RegExp(r"\D"), "");
                            switch (value.length) {
                              case 0:
                                cardController.expireDateConttoller.text = "MM/YY";
                                cardController.expireDateConttoller.selection = TextSelection.collapsed(offset: 0);
                                break;
                              case 1:
                                cardController.expireDateConttoller.text = "${value}M/YY";
                                cardController.expireDateConttoller.selection = TextSelection.collapsed(offset: 1);
                                break;
                              case 2:
                                cardController.expireDateConttoller.text = "$value/YY";
                                cardController.expireDateConttoller.selection = TextSelection.collapsed(offset: 2);
                                break;
                              case 3:
                                cardController.expireDateConttoller.text =
                                "${value.substring(0, 2)}/${value.substring(2)}Y";
                                cardController.expireDateConttoller.selection = TextSelection.collapsed(offset: 4);
                                break;
                              case 4:
                                cardController.expireDateConttoller.text =
                                "${value.substring(0, 2)}/${value.substring(2, 4)}";
                                cardController.expireDateConttoller.selection = TextSelection.collapsed(offset: 5);
                                break;
                            }
                            if (value.length > 3) {
                              cardController.expireDateConttoller.text =
                              "${value.substring(0, 2)}/${value.substring(2, 4)}";
                              cardController.expireDateConttoller.selection = TextSelection.collapsed(offset: 5);
                              cardController.month=value.substring(0, 2);
                              cardController.year=value.substring(2, 4);
                            }
                          },),

                          SizedBox(height: Get.height*0.02,),

                          GestureDetector(
                              onTap: (){
                                FocusScope.of(context).requestFocus(new FocusNode());
                              //  FocusScope.of(context).unfocus();
                              if(cardController.formKey.currentState!.validate()){

                                cardController.cartRegister();
                              }
                            },
                              child: CommonButton(text:"Add Card")),

                          SizedBox(height: Get.height*0.02),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            isScrollControlled: true,
            ).whenComplete(() {
              FocusScope.of(context).unfocus();
            });
          },

          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50.0))),

          child: Container(
            child: Icon(
              Icons.add,
              size: 55,
              color: Colors.white,
            ),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: [
                  ConstantColor.gradiantLightColor,
                  ConstantColor.gradiantDarkColor
                ])),
          ),
        ),


        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Payment Card",style: TextStyle(fontFamily: ConstantString.fontbold, fontSize: 22.0),
          ),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: SvgPicture.asset(ConstantImage.back),
                tooltip: MaterialLocalizations.of(context).backButtonTooltip,
                onPressed: () {
                  Get.back();
                },
              );
            },
          ),
          backgroundColor: Colors.white,
        ),
        body: Obx(() =>

          (cardController.loading!.value)?
          Center(
            child: Container(
              height: 40,
              color: Colors.transparent,
              child: CircularProgressIndicator.adaptive(
                valueColor: AlwaysStoppedAnimation<Color>(ConstantColor.gradiantLightColor),
              ),
            ),
          ):




          (cardController.cardList.isEmpty)?
          Center(
              child: Text("List is empty"),
            )
          :
          ListView.builder(
                shrinkWrap: true,
                itemCount: cardController.cardList.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [

                      Stack(
                        children: [
                          Image.asset(ConstantImage.card_bg, fit: BoxFit.fill,
                            width: Get.width,),

                          const SizedBox(height: 30.0),
                          Padding(
                            padding: EdgeInsets.all(Get.height * 0.030),

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: Get.height * 0.01),
                                Padding(
                                  padding:  EdgeInsets.only(left :Get.width*0.04,),
                                  child:Text(
                  '**** **** **** ${cardController.cardList[index].cardNumber?.substring(cardController.cardList[index].cardNumber!.length - 4)}',
                  style: const TextStyle(
                  fontSize: 22.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  ),
                  )

                                  //
                                  // Text(
                                  //   cardController.cardList[index].cardNumber
                                  //       .toString(),
                                  //   style: const TextStyle(
                                  //     fontSize: 22.0,
                                  //     color: Colors.white,
                                  //     fontWeight: FontWeight.bold,
                                  //   ),
                                  // ),
                                ),
                                SizedBox(height: Get.height * 0.07),

                                Padding(
                                  padding:  EdgeInsets.only(left:Get.width*0.04, right: Get.width*0.04),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Text(
                                        "Card Holder's Name",
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(width: Get.width * 0.08),
                                      Text(
                                        "Expiry Date",
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:  EdgeInsets.only(left:Get.width*0.04, right: Get.width*0.04),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Text(
                                        cardController.cardList[index].cardName
                                            .toString(),
                                        style: const TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(width: Get.width * 0.010),
                                      Text(
                                        cardController.cardList[index].cardExpire
                                            .toString(),
                                        style: const TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),


                              ],
                            ),
                          ),
                        ],
                      ),

                      Padding(
                        padding: EdgeInsets.only(
                            left: Get.width * 0.06, right: Get.width * 0.06),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Obx(() =>
                                      SizedBox(
                                          height: Get.height * 0.020,
                                          width: Get.width * 0.050,
                                          child: Checkbox(

                                            checkColor: Colors.white,
                                            activeColor: Colors.blue,
                                            value: cardController
                                                .cardList[index].isChecked
                                                .value,
                                            onChanged: (value) {
                                              for (int i = 0; i <
                                                  cardController.cardList
                                                      .length; i++) {
                                                cardController.cardList[i]
                                                    .isChecked.value = false;
                                              }
                                              cardController.cardList[index]
                                                  .isChecked.value = value!;
                                              cardController.changeCardStatus(
                                                  cardController.cardList[index]
                                                      .isChecked.value,
                                                  cardController.cardList[index]
                                                      .id);
                                            },
                                          )),
                                ),


                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text("Use as default payment method",
                                    style: TextStyle(fontFamily: ConstantString
                                        .fontRegular),),
                                ),


                                SizedBox(height: Get.height * 0.01,),

                              ],
                            ),


                            GestureDetector(
                                onTap: () {  if(cardController.cardList[index].isDefault == true) {
                                  toastMessage("Default card could not delete");
                                  }else{
                                    showDialog(
                                      builder: (context) {
                                        return AlertDialog(
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(25.0))),
                                            contentPadding:
                                            const EdgeInsets.only(
                                                top: 20.0),
                                            content: Container(
                                              margin: EdgeInsets.only(
                                                  right: 10, left: 10),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius
                                                      .all(Radius.circular(
                                                      Get.height * 0.040))),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    "Are you sure you want to\n delete this card",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize:
                                                        Get.height * 0.024,
                                                        fontWeight:
                                                        FontWeight.w500,),
                                                  ),
                                                  SizedBox(
                                                    height: Get.height * 0.010,
                                                  ),

                                                  Divider(),
                                                  SizedBox(
                                                    height: Get.height * 0.010,
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          Get.back();

                                                          cardController.deleteCard(cardController.cardList[index].id.toString());
                                                          cardController.cardList.removeAt(index);
                                                        },
                                                        child: Center(
                                                          child: Text(
                                                            "Yes",
                                                            style: TextStyle(
                                                                color:
                                                                Colors.red,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                                fontSize:
                                                                Get.height *
                                                                    0.022),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height:
                                                        Get.height * 0.015,
                                                      ),
                                                      Divider(),
                                                      SizedBox(
                                                        height:
                                                        Get.height * 0.015,
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          Get.back();
                                                        },
                                                        child: const Text(
                                                          "Cancel",
                                                          style: TextStyle(
                                                              color:
                                                              Colors.black,

                                                              fontWeight:
                                                              FontWeight
                                                                  .w500),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height:
                                                        Get.height * 0.02,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ));
                                      },
                                      context: context,
                                    );
                                  }


                                },

                                child: Icon(Icons.delete, color: Colors.red,)
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                }
            ),



        )



    );
  }
}


