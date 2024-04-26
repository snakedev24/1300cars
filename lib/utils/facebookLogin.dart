import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
class FacebookLoginClass {






  Future<void> loginWithFacebook() async {
    final result = await FacebookAuth.instance.login(
      permissions: ['email']
    );
    switch (result.status) {
      case LoginStatus.success:
        final AccessToken accessToken = result.accessToken!;
        // Use the access token to make API requests or get user data.
        final userData = await FacebookAuth.instance.getUserData();
        print('Facebook User ID: ${userData['id']}');
        print('Facebook User Name: ${userData['name']}');
        // You can now use this user data as needed.
        break;
      case LoginStatus.failed:
        print('Facebook login failed');
        break;
      case LoginStatus.cancelled:
        print('Facebook login was cancelled');
        break;
      default:
        break;
    }
  }


}