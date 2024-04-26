import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class ChatImageZoom extends StatelessWidget {
  String? image;
  int? checkImage;
   ChatImageZoom({Key? key,this.image,this.checkImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(

      ),
      body: (checkImage==0)?PhotoView(
        imageProvider:
        CachedNetworkImageProvider(image!),
      ):

      Center(
        child: PhotoView(

          imageProvider: FileImage(
            File(image!),

          ),
        ),
      ),

    );
  }
}
