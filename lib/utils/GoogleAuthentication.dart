import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../controller/login_Controller.dart';
import '../widget/error_message_toast.dart';

class Authentication {



  static Future<User?> signInWithGoogle({required BuildContext context}) async {
    final loginController = Get.put(LoginController());
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      try {
        final UserCredential userCredential = await auth.signInWithCredential(credential);
        String? imageUrl = googleSignInAccount.photoUrl;
        String? userName = googleSignInAccount.displayName;
        String? userEmail = googleSignInAccount.email;
        user = userCredential.user;
        loginController.socialLogin(userName, userEmail, imageUrl);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          toastMessage("The account already exists with a different credential");
        } else if (e.code == 'invalid-credential') {
          toastMessage("Error occurred while accessing credentials. Try again.");
        }else{
          toastMessage("Error occurred.Try again.");
        }
      } catch (e) {
        toastMessage("Error occurred using Google Sign In. Try again.");
      }
    }else{
      toastMessage("google null");
    }
    return user;
  }
}