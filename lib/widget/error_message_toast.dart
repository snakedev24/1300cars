import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<void> toastMessage(String error){
  return  Fluttertoast.showToast(
      msg: error,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Color.fromRGBO(46, 49, 146, 1.0),
      textColor: Colors.white,
      fontSize: 16.0
  );
}