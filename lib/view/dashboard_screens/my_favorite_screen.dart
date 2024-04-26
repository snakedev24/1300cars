import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:user/view/dashboard_screens/provider_detail_screen.dart';

import '../../constants/color_constant.dart';
import '../../constants/image_constant.dart';
import '../../constants/string_constant.dart';
import '../../controller/favourite_controller.dart';
import '../../controller/service_list_controller.dart';
import '../../widget/app_text.dart';

class MyFavoriteScreen extends StatefulWidget {
   MyFavoriteScreen({Key? key}) : super(key: key);

  @override
  State<MyFavoriteScreen> createState() => _MyFavoriteScreenState();
}

class _MyFavoriteScreenState extends State<MyFavoriteScreen> {
   final serviceController = Get.put(ServiceListController());

  final favouriteController = Get.put(FavouriteController());
   String? subscription="";
  @override
  void initState() {

    super.initState();
    favouriteController.favoriate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Stack(
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
                        onTap : (){
                      Get.back();
              },

                        child: SvgPicture.asset(ConstantImage.back,width: Get.width*0.09,)),
                    AppText(text: "My Favorite",fontWeight: FontWeight.w700,
                      fontFamily: ConstantString.fontbold,
                      fontSize: 0.022,
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
                  child: Padding(
                    padding:  EdgeInsets.all(Get.height*0.008),
                    child:

                    Obx(() =>


                    (favouriteController.loading!.value)?
                    Center(
                      child: Container(
                        height: 40,
                        color: Colors.transparent,
                        child: CircularProgressIndicator.adaptive(
                          valueColor: AlwaysStoppedAnimation<Color>(ConstantColor.gradiantLightColor),
                        ),
                      ),
                    ):

                    (favouriteController.favoriateList.isEmpty)?
                         Center(
                        child: Text("List is empty"),):
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: favouriteController.favoriateList.length,
                        itemBuilder: (context,index){
                          return


                            GestureDetector(
                              onTap : (){


                                bool isMembership =  favouriteController.favoriateList.any((data) =>
                                data.memberShipInfo != null &&
                                    data.memberShipInfo!.subcriptionType != null &&
                                    data.memberShipInfo!.subcriptionType!.isNotEmpty);
                                if (isMembership) {
                                  subscription = favouriteController.favoriateList[index].memberShipInfo!.subcriptionType;
                                } else {
                                  subscription = "";
                                }
                                Get.to(ProviderDetailScreen(
                                    favouriteController.favoriateList[index].businessName,
                                    favouriteController.favoriateList[index].name,
                                    favouriteController.favoriateList[index].isGoogle,
                                    favouriteController.favoriateList[index].location,
                                    favouriteController.favoriateList[index].latitude,
                                    favouriteController.favoriateList[index].longitude,
                                    favouriteController.favoriateList[index].startTime,
                                    favouriteController.favoriateList[index].endTime,
                                    favouriteController.favoriateList[index].servicePrice,
                                    favouriteController.favoriateList[index].types,
                                    favouriteController.favoriateList[index].id,
                                    favouriteController.favoriateList[index].discountCoupons,
                                    (favouriteController.favoriateList[index].ratings==0)?0.0:favouriteController.favoriateList[index].ratings,
                                    favouriteController.favoriateList[index].memberShipInfo!.subcriptionType.toString(),
                                    favouriteController.favoriateList[index].contactMobile.toString(),
                                    ""
                                )
                                );
                              },

                              child: Container(
                              padding: EdgeInsets.all(Get.height*0.01),
                              margin: EdgeInsets.only(bottom: Get.height * 0.02),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.circular(Get.height * 0.01)),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Stack(
                                            children: [

                                              Container(
                                                height:Get.height*0.08,
                                                  width: Get.width*0.15,

                                                child:favouriteController.favoriateList[index].image != ""?
                                                Image.network(favouriteController.favoriateList[index].image, fit: BoxFit.fill,):
                                                Image.asset(ConstantImage.person_png)
                                              ),
                                              Positioned(
                                                right: 2,
                                                top: 1,
                                                child: Container(
                                                    padding: EdgeInsets.all(1),

                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        shape: BoxShape.circle
                                                    ),
                                                    child: Icon(Icons.heart_broken,color: Colors.red,size: 10,)),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            width: Get.width * 0.02,
                                          ),
                                          SizedBox(
                                            width:Get.width*0.5,
                                            child: Column(

                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                AppText(
                                                  text: favouriteController.favoriateList[index].name.toString(),
                                                  fontSize: 0.017,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily:
                                                  ConstantString.fontbold,
                                                ),
                                                AppText(
                                                  text: favouriteController.favoriateList[index]!.servicePrice![0].service.toString(),
                                                  fontSize: 0.014,
                                                  fontWeight: FontWeight.w700,
                                                  textColor:
                                                  ConstantColor.textGrayColor,
                                                ),
                                                AppText(
                                                  text: favouriteController.favoriateList[index].businessName.toString(),
                                                  fontSize: 0.015,
                                                  fontWeight: FontWeight.w700,
                                                  textColor:
                                                  ConstantColor.textGrayColor,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.star,color:  ConstantColor.darkYellow,),

                                          AppText(
                                            text: favouriteController.favoriateList[index].ratings.toString(),
                                            fontSize: 0.02,
                                            fontWeight: FontWeight.w700,
                                            textColor:
                                            ConstantColor.grey,
                                          ),
                                        ],
                                      ),

                                    ],
                                  ),
                                ],
                              ),
                          ),
                            );



                        }),)

                  ),
                ),
              )

            ],
          ),
        ],
      ),














    );
  }
}
