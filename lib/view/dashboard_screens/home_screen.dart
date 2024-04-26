import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:user/constants/color_constant.dart';
import 'package:user/controller/home_controller.dart';
import 'package:user/controller/service_list_controller.dart';
import 'package:user/view/dashboard_screens/service_screen.dart';
import 'package:user/widget/app_text.dart';
import '../../common/loginDialog.dart';
import '../../constants/image_constant.dart';
import '../../constants/string_constant.dart';
import '../../pref/shared_preference.dart';
import '../../widget/VideoPlayerWidget.dart';

class HomeScreen extends StatefulWidget {
   HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}




class _HomeScreenState extends State<HomeScreen> {
  final homeController = Get.put(HomeController());
  final serviceListController=Get.put(ServiceListController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
       homeController.getLocation();
      // Future.delayed(const Duration(milliseconds: 7000), () {
      //     homeController.checkGps();
      // });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstantColor.darkWhite,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: <Widget>[
          Padding(
            padding:  EdgeInsets.all(Get.height*0.008),
            child: Container(
                margin:  EdgeInsets.only(right: Get.height*0.005),
                child: GestureDetector(
                    onTap: () async {
                     homeController.makeEmergencyCall();
                    },
                    child: SvgPicture.asset(ConstantImage.sosLogo))),
          )
          ,], //<Widget>[]


        title: AppText(text: "Home",
          fontWeight: FontWeight.w900,
          fontSize: 0.025,
        ),

        centerTitle: true,

      ),



      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

          Obx(() => CarouselSlider(
                carouselController: homeController.buttonCarouselController,
                options: CarouselOptions(
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 4), // Set the interval for auto rotation
                  enlargeCenterPage: true,
                  viewportFraction: 1,
                  enableInfiniteScroll: true,

                  aspectRatio: (Get.width / Get.height) * 3.9,
                  initialPage: 0,
                  onPageChanged: (index, reason) {
                    homeController.current.value = index;
                  },
                ),
                items: homeController.imageCarousel.map((i) {
                  return Stack(
                    children: [
                      (i.extension == "image")?
                      ClipRRect(borderRadius: BorderRadius.circular(10), // Image border
                        child: SizedBox.fromSize(
                          size: Size.fromRadius(Get.height*0.25), // Image radius
                          child: Image.network(i.file!, fit: BoxFit.fill,),),)
                          :
                      VideoPlayerWidget(i.file!),

                    ],
                  );
                }).toList(),
              )),



          Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                    List.generate(

                        homeController.imageCarousel.length, (index) {
                  return GestureDetector(
                    onTap: () => homeController.buttonCarouselController.animateToPage(index),
                    child: Container(
                      height: Get.height*0.011,
                      width: Get.height*0.01,

                      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (Theme.of(context).brightness == Brightness.dark
                                ? Colors.blue
                                : ConstantColor.gradiantDarkColor)
                            .withOpacity(homeController.current.value == index
                                ? 0.9
                                : 0.4),
                      ),
                    ),
                  );
                }),
              ),),

          AppText(
            text: "Nearby Services",
            fontSize: 0.036,
            fontWeight: FontWeight.w900,
          ),

          SizedBox(
            height: Get.height * 0.012,
          ),

          Expanded(
            child: Obx(() => (homeController.loading!.value)?

                Center(
                child: Container(
                  height: 42,
                  color: Colors.transparent,
                  child: CircularProgressIndicator.adaptive(
                    valueColor: AlwaysStoppedAnimation<Color>(ConstantColor.gradiantLightColor),
                  ),
                ),
              ):
                
                 (homeController.serviceList.isEmpty)?
                Center(
                  child:  Container(
                    height: 40,
                    color: Colors.transparent,
                    child: CircularProgressIndicator.adaptive(
                      valueColor: AlwaysStoppedAnimation<Color>(ConstantColor.gradiantLightColor),
                    ),
                  ),
                ):

                 GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 19,
                    mainAxisSpacing: 19,
                    crossAxisCount: 3,
                  ),
                   itemCount: homeController.serviceList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [


                                    GestureDetector(
                                        onTap: () {
                                          if (SharedPreference.getBool(ConstantString.guestUser) == true) {
                                            loginDialog();
                                          } else {
                                           //  if (SharedPreference.getBool(
                                           //          ConstantString
                                           //              .locationDeny) ==
                                           //      true) {
                                           // //   homeController.checkGps();
                                           //    // toastMessage("Please Allow location to access Service");
                                           //  } else {
                                              serviceListController
                                                      .selectedServiceId =
                                                  homeController
                                                      .serviceList[index].id;
                                              if(homeController.lat.isNotEmpty){

                                                Get.to(ServiceScreen(homeController.serviceList[index].name, homeController.lat, homeController.long));
                                                Get.find<ServiceListController>()
                                                    .checkSearchField!
                                                    .value = false;
                                                serviceListController.allListService(homeController.lat, homeController.long, "");
                                              }else{
                                                homeController.checkGps();
                                              }
                                              // checkGps()




                                          }
                                        },
                                        child: Container(
                                          height: Get.height * 0.13,
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.only(
                                            top: Get.height * 0.010,
                                            bottom: Get.height * 0.010,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  Get.height * 0.010),
                                            ),
                                            color: Colors.white,
                                          ),
                                          child: Center(
                                            // Center the content within the Container
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              // Center the content vertically
                                              children: [
                                                SvgPicture.network(
                                                  homeController
                                                      .serviceList[index]
                                                      .serviceImage
                                                      .toString(),
                                                  height: Get.height * 0.05,
                                                ),

                                                SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.003,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    right: 7,
                                                    left: 7,
                                                  ),
                                                  child: Text(
                                                    homeController
                                                        .serviceList[index].name
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize:
                                                          Get.height * 0.012,
                                                      fontFamily: ConstantString
                                                          .fontRegular,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                    maxLines: 3,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )),

                              ],
                    );
                  },

                ),

            ),
          )

        ]),
      ),
    );
  }
}
