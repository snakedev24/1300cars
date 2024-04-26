import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MediaListPicker{
  String? text;
  IconData? icons;
  MediaListPicker({this.text,this.icons});
}
List<MediaListPicker> mediaList=[
  MediaListPicker(text: "Photo",icons: Icons.photo_outlined),
  MediaListPicker(text: "Camera",icons: Icons.camera_alt_outlined),
  MediaListPicker(text: "File",icons: Icons.file_copy_outlined),
];

void passwordChangePopup(final void Function(int click) onTap ) {
  Get.bottomSheet(
    SingleChildScrollView(
      child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
          child: Container(
            decoration:  BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Get.height*0.010),
                    topLeft: Radius.circular(Get.height*0.010))),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: Get.height*0.010,
                    left: Get.width*0.030,
                    right: Get.width*0.030,
                    top: Get.height*0.020),
                child: Column(
                  children: [
                    Container(
                      height: Get.height*0.010,
                      width: Get.width*0.3,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                        borderRadius: BorderRadius.all(Radius.circular(Get.height*0.010))
                      ),
                    ),
                    SizedBox(height: Get.height*0.020,),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: mediaList.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context,index){
                          return Padding(
                            padding:  EdgeInsets.only(bottom: Get.height*0.010),
                            child: GestureDetector(
                              onTap: (){
                                onTap(index);
                              },
                              child: Container(
                                height: Get.height*0.040,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(mediaList[index].icons,size: Get.height*0.035,),
                                    SizedBox(width: Get.width*0.030,),
                                    Text(mediaList[index].text!,style: TextStyle(
                                      fontSize: Get.height*0.022,
                                      fontWeight: FontWeight.w500
                                    ),),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                    ),

                  ],
                )
              ),

            ),
          )),
    ),
  );
}