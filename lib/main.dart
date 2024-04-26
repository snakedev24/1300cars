import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:user/pref/shared_preference.dart';
import 'package:user/utils/firebase_api.dart';
import 'package:user/view/auth_screens/splash_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreference.init();
  await Firebase.initializeApp();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);


    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'User',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}
