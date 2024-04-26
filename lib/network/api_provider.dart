
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:user/Model/AddDefaultModel.dart';
import 'package:user/Model/AddEmeregencyModel.dart';
import 'package:user/Model/AppointmentListModel.dart';
import 'package:user/Model/CardListModel.dart';
import 'package:user/Model/CardRegisterModel.dart';
import 'package:user/Model/ChangeCardStatusModel.dart';
import 'package:user/Model/DeleteCardModel.dart';
import 'package:user/Model/DiagnosticModel.dart';
import 'package:user/Model/EditProfileModel.dart';
import 'package:user/Model/FavoriateModel.dart';
import 'package:user/Model/GetEmergencyModel.dart';
import 'package:user/Model/GetProfileModel.dart';
import 'package:user/Model/GoogleDetailModel.dart';
import 'package:user/Model/GoogleListModel.dart';
import 'package:user/Model/LogoutModel.dart';
import 'package:user/Model/RatingModel.dart';
import 'package:user/Model/RecoveryPasswordModel.dart';
import 'package:user/Model/ServiceHistoryModel.dart';
import 'package:user/Model/ServiceListModel.dart';
import 'package:user/Model/SocialLoginModel.dart';
import 'package:user/Model/StaticDataModel.dart';
import 'package:user/Model/delete_account_model.dart';
import 'package:user/Model/pormotion_model.dart';
import 'package:user/constants/api_constants.dart';
import '../Model/CancelRequestModel.dart';
import '../Model/ChangeAccountModel.dart';
import '../Model/ChatMessageModel.dart';
import '../Model/ChatRoomModel.dart';
import '../Model/LoginModel.dart';
import '../Model/NewServiceListModel.dart';
import '../Model/RegisterModel.dart';
import '../Model/ReminderModel.dart';
import '../Model/SendImageModel.dart';
import '../Model/ServiceModel.dart';
import '../Model/bookservicemodel.dart';
import '../constants/string_constant.dart';
import '../pref/shared_preference.dart';
import '../widget/api_loader.dart';
import '../widget/error_message_toast.dart';

class ApiProvider {
  final Dio _dio = Dio();

  String getUrlWithBaseUrl(String url) {
    return ApiConstants.baseUrl + url;
  }

  var headerOptions = Options(
    headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    },
  );
  String? accessToken = SharedPreference.getString(ConstantString.accessToken);

  Future<dynamic> login(String email, password,fcmToken) async {
    CommonDialog.showLoading();
    var map = <String, dynamic>{
      "email": email,
      "password": password,
      "role": "normal",
      "fcm_token":fcmToken
    };
    try {
      final response = await _dio.post(getUrlWithBaseUrl(ApiConstants.login),
          data: map, options: headerOptions);

      CommonDialog.hideLoading();
      return LoginModel.fromJson(response.data);
    } on DioError catch (error, stacktrace) {
      CommonDialog.hideLoading();
      if (error.response!.statusCode == 401) {
        toastMessage(error.response!.data['message'].toString());
      } else if (error.response!.statusCode == 404) {
        toastMessage(error.response!.statusMessage.toString());
      }
      // else{
      //   toastMessage(error.response!.statusMessage.toString());
      // }
    }
  }

  Future<dynamic> register(String name, String email, String password,
      String confirmPassword) async {
    CommonDialog.showLoading();
    var map = <String, dynamic>{
      "first_name": name,
      "email": email,
      "password": password,
      "confirm_password": confirmPassword,
      "role": "normal"
    };
    try {
      final response = await _dio.post(getUrlWithBaseUrl(ApiConstants.register),
          data: map, options: headerOptions);
      if (response.statusCode == 200) {
        CommonDialog.hideLoading();
        return RegisterModel.fromJson(response.data);
      } else {
        CommonDialog.hideLoading();
        toastMessage("Invalid Credentials");
      }
    } on DioError catch (error, stacktrace) {
      CommonDialog.hideLoading();
      if (error.response!.statusCode == 401) {
        toastMessage(error.response!.data['detail'].toString());
      } else if (error.response!.statusCode == 404) {
        toastMessage(error.response!.statusMessage.toString());
      } else {
        toastMessage(error.response!.statusMessage.toString());
      }
    }
  }

  Future<dynamic> recoveryPassword(String email) async {
    CommonDialog.showLoading();
    var map = <String, dynamic>{
      "email": email,
    };
    try {
      final response = await _dio.post(
          getUrlWithBaseUrl(ApiConstants.recoverPassword),
          data: map,
          options: headerOptions);

      CommonDialog.hideLoading();
      return RecoveryPasswordModel.fromJson(response.data);
    } on DioError catch (error, stacktrace) {
      CommonDialog.hideLoading();
      if (error.response!.statusCode == 401) {
        toastMessage(error.response!.data['message'].toString());
      } else if (error.response!.statusCode == 404) {
        toastMessage(error.response!.statusMessage.toString());
      }else{
        toastMessage(error.response!.statusMessage.toString());
      }
    }
  }

  Future<dynamic> logout() async {
    CommonDialog.showLoading();

    var headerOptions = Options(
      headers: {
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      },
    );

    try {
      final response = await _dio.post(getUrlWithBaseUrl(ApiConstants.logout),
          options: headerOptions);

      CommonDialog.hideLoading();
      return LogoutModel.fromJson(response.data);
    } on DioError catch (error, stacktrace) {
      CommonDialog.hideLoading();
      if (error.response!.statusCode == 401) {
        toastMessage(error.response!.data['message'].toString());
      } else if (error.response!.statusCode == 404) {
        toastMessage(error.response!.statusMessage.toString());
      }else{
        toastMessage(error.response!.statusMessage.toString());
      }
    }
  }

  Future<dynamic> serviceList() async {
    // CommonDialog.showLoading();
    var headerOptions = Options(
      headers: {
        "Content-Type": "application/json",
      },
    );
    try {
      Response response = await _dio.get(
          getUrlWithBaseUrl(ApiConstants.serviceList),
          options: headerOptions);
      return ServiceModel.fromJson(response.data);
    } catch (error, stacktrace) {
      var model = ServiceModel.fromJson((error as dynamic).response.data);
      return model;
    }
  }

  Future<dynamic> promotionList() async {
    try {
      Response response = await _dio.get(
          getUrlWithBaseUrl(ApiConstants.promotion),
          options: headerOptions);

      return PromotionModel.fromJson(response.data);
    } catch (error, stacktrace) {
      var model = PromotionModel.fromJson((error as dynamic).response.data);
      return model;
    }
  }

  Future<dynamic> mainServiceList(var id, String lat, String long, String? search) async {

    print("lat long $lat");
    print("long $long");
    var map = <String, dynamic>{
      "service": id,
      "latitude": lat,
      "longitude": long,
    };
    print("map services $map");
    print("token $accessToken");
    var headerOptionsWithToken = Options(
      headers: {
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      },
    );
    try {
      final response = await _dio.post(
          getUrlWithBaseUrl("${ApiConstants.searchProvider}$search"),
          data: map,
          options: headerOptionsWithToken);
      return ServiceListModel.fromJson(response.data);
    } on DioError catch (error, stacktrace) {
      if (error.response!.statusCode == 401) {
        toastMessage(error.response!.data['message'].toString());
      } else if (error.response!.statusCode == 404) {
        toastMessage(error.response!.statusMessage.toString());
      }else{
        toastMessage(error.response!.statusMessage.toString());
      }
    }
  }

  // Future<dynamic> mainServiceListGoogle(var id, String lat, String long, String? search) async {
  //  // CommonDialog.showLoading();
  //   var map = <String, dynamic>{
  //     "service": id,
  //     "latitude": lat,
  //     "longitude": long,
  //   };
  //   var headerOptionsWithToken = Options(
  //     headers: {
  //       "Content-Type": "application/json",
  //       HttpHeaders.authorizationHeader: 'Bearer $accessToken',
  //     },
  //   );
  //   try {
  //     final response = await _dio.post(
  //         getUrlWithBaseUrl("${ApiConstants.searchProvider}$search"),
  //         data: map,
  //         options: headerOptionsWithToken);
  //    // CommonDialog.hideLoading();
  //     return GoogleListModel.fromJson(response.data);
  //   } on DioError catch (error, stacktrace) {
  //     //CommonDialog.hideLoading();
  //     if (error.response!.statusCode == 401) {
  //       toastMessage(error.response!.data['message'].toString());
  //     } else if (error.response!.statusCode == 404) {
  //       toastMessage(error.response!.statusMessage.toString());
  //     }
  //   }
  // }

  Future<dynamic> serviceBooking(String name, String phoneno, String location, String time, String date, int? providerId, List<int> selectedID, String disconutVoucher) async {
    // String convert12HourTo24Hour(String time12Hour) {
    //   final inputFormat = DateFormat('h:mm a');
    //   final outputFormat = DateFormat('HH:mm');
    //   final dateTime = inputFormat.parse(time12Hour);
    //   final time24Hour = outputFormat.format(dateTime);
    //   return time24Hour;
    // }


    // String convert12HourTo24Hour(String time12Hour) {
    //   final inputFormat = DateFormat('h:mm a');
    //   final outputFormat = DateFormat('HH:mm');
    //   final dateTime = inputFormat.parse(time12Hour);
    //
    //   // Convert to 24-hour format
    //   final time24Hour = outputFormat.format(dateTime);
    //
    //   // Convert to UTC
    //   final dateTime24Hour = DateTime.parse(time24Hour);
    //   final timeInUtc = dateTime24Hour.toUtc();
    //
    //   // Return time in UTC
    //   return timeInUtc.toString();
    // }

    String convert12HourToUtcTime(String time12Hour) {
      final inputFormat = DateFormat('h:mm a');
      final outputFormat = DateFormat('HH:mm');
      final dateTime = inputFormat.parse(time12Hour);
      final time24Hour = outputFormat.format(dateTime);

      // Convert the 24-hour formatted time to DateTime object
      final dateTime24Hour = DateTime.parse('1970-01-01 $time24Hour:00Z');

      // Convert the DateTime to UTC
      final timeInUtc = dateTime24Hour.toUtc();

      // Format UTC time according to HH:mm format
      final formattedUtcTime = DateFormat('HH:mm').format(timeInUtc);

      return formattedUtcTime;
    }


    CommonDialog.showLoading();
    var map = <String, dynamic>{
      "provider": providerId,
      "service": selectedID,
      "name": name,
      "phone_number": int.parse(phoneno),
      "location": location,
      "service_date": date,
      "service_time": convert12HourToUtcTime(time),
      "discount_coupon": disconutVoucher,
    };
    var headerOptionsWithToken = Options(
      headers: {
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      },
    );

    try {
      final response = await _dio.post(getUrlWithBaseUrl(ApiConstants.booking),
          data: map, options: headerOptionsWithToken);
        CommonDialog.hideLoading();
        print("resss ${response.data}");
        return BookServiceModel.fromJson(response.data);
    } on DioError catch (error, stacktrace) {
      CommonDialog.hideLoading();
      if (error.response!.statusCode == 401) {
        toastMessage(error.response!.data['detail'].toString());
      } else if (error.response!.statusCode == 404) {
        toastMessage(error.response!.statusMessage.toString());
      } else {
        toastMessage(error.response!.statusMessage.toString());
      }
    }
  }

  Future<dynamic> appointmentList(String search) async {
    var headerOptions = Options(
      headers: {
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      },
    );
    try {
      Response response = await _dio.get(
          getUrlWithBaseUrl("${ApiConstants.booking}$search"),
              
             
          options: headerOptions);

      return AppointmentListModel.fromJson(response.data);
    }
    catch (error) {
      var model = AppointmentListModel.fromJson((error as dynamic).response.data);
      return model;
    }
  }

  Future<dynamic> chatRoom() async {
    var headerOptions = Options(
      headers: {
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      },
    );
    try {
      Response response = await _dio.get(
          getUrlWithBaseUrl(ApiConstants.chatsRoom),
          options: headerOptions);
      return ChatRoomModel.fromJson(response.data);
    }
    on DioError catch (error, stacktrace) {
      if (error.response!.statusCode == 401) {
        toastMessage(error.response!.data['detail'].toString());
      } else if (error.response!.statusCode == 404) {
        toastMessage(error.response!.statusMessage.toString());
      } else {
        toastMessage(error.response!.statusMessage.toString());
      }
    }
  }

  Future<dynamic> chatMessage(String id,String pageNumber) async {
    var headerOptions = Options(
      headers: {
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      },
    );
    try {
      Response response = await _dio.get(
          getUrlWithBaseUrl("${ApiConstants.chatsMessages}/$id?page=$pageNumber"),
          options: headerOptions);
      return ChatMessageModel.fromJson(response.data);
    }
    on DioError catch (error, stacktrace) {
      if (error.response!.statusCode == 401) {
        toastMessage(error.response!.data['detail'].toString());
      } else if (error.response!.statusCode == 404) {
        toastMessage(error.response!.statusMessage.toString());
      } else {
        toastMessage(error.response!.statusMessage.toString());
      }
    }
  }

  Future<dynamic> cardRegister(String name, String cardtno, String experiDate, String cvvno, bool isChecked, ) async {
    CommonDialog.showLoading();
    var map = <String, dynamic>{
      "card_name": name,
      "card_number": cardtno,
      "card_expire": experiDate,
      "is_default": false,

    };

    var headerOptions = Options(
      headers: {
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      },
    );
    try {
      final response = await _dio.post(getUrlWithBaseUrl(ApiConstants.card),
          data: map, options: headerOptions);

      CommonDialog.hideLoading();
      return CardRegisterModel.fromJson(response.data);
    } on DioError catch (error, stacktrace) {
      CommonDialog.hideLoading();
      if (error.response!.statusCode == 401) {
        toastMessage(error.response!.data['message'].toString());
      } else if (error.response!.statusCode == 404) {
        toastMessage(error.response!.statusMessage.toString());
      }
    }
  }

  Future<dynamic> cardList() async {


    var headerOptions = Options(
      headers: {
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      },
    );
    try {
      Response response = await _dio.get(
          getUrlWithBaseUrl(ApiConstants.card),
          options: headerOptions);
      return CardListModel.fromJson(response.data);
    }
    catch (error) {
      CommonDialog.hideLoading();
      var model = CardListModel.fromJson((error as dynamic).response.data);
      return model;
    }
  }

  Future<dynamic> deleteCard(String id) async {

    CommonDialog.showLoading();
    var headerOptions = Options(
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',},);

    try {
      final response = await _dio.delete(
          getUrlWithBaseUrl("${ApiConstants.deleteCard}$id"),
          options: headerOptions);

      CommonDialog.hideLoading();
      return DeleteCardModel.fromJson(response.data);

    }  on DioError catch (error, stacktrace) {
      CommonDialog.hideLoading();
      if (error.response!.statusCode == 401) {
        toastMessage(error.response!.data['message'].toString());
      } else if (error.response!.statusCode == 404) {
        toastMessage(error.response!.statusMessage.toString());
      }else{
        toastMessage(error.response!.statusMessage.toString());
      }
    }
  }

  Future<dynamic> defaultCard(bool value, int? id) async {
    CommonDialog.showLoading();

    var map = <String, dynamic>{
      "is_default": value
    };
    var headerOptions = Options(
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',

      },
    );
    try {
      final response = await _dio.patch(
          getUrlWithBaseUrl("${ApiConstants.deleteCard}$id"),
          data:  FormData.fromMap(map),
          options: headerOptions);

      CommonDialog.hideLoading();
      return ChangeCardStatusModel.fromJson(response.data);

    }  on DioError catch (error, stacktrace) {
      CommonDialog.hideLoading();
      if (error.response!.statusCode == 401) {
        toastMessage(error.response!.data['message'].toString());
      } else if (error.response!.statusCode == 404) {
        toastMessage(error.response!.statusMessage.toString());
      }
    }
  }

  Future<dynamic> deleteAccount() async {
    CommonDialog.showLoading();
    var headerOptions = Options(
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      },
    );
    try {
      final response = await _dio.delete(
          getUrlWithBaseUrl(ApiConstants.deleteAccount),
          options: headerOptions);
      CommonDialog.hideLoading();
      return DeleteAccount.fromJson(response.data);
    }  on DioError catch (error, stacktrace) {
      CommonDialog.hideLoading();
      if (error.response!.statusCode == 401) {
        toastMessage(error.response!.data['message'].toString());
      } else if (error.response!.statusCode == 404) {
        toastMessage(error.response!.statusMessage.toString());
      }
    }
  }

  Future<dynamic> changePassword(String old, newPassword, confPassword) async {
    CommonDialog.showLoading();
    var map = <String, dynamic>{
      "old_password": old,
      "new_password": newPassword,
      "confirm_password": confPassword,
    };
    var headerOptionsWithToken = Options(
      headers: {
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      },
    );
    try {
      final response = await _dio.post(
          getUrlWithBaseUrl(ApiConstants.changePassword),
          data: map,
          options: headerOptionsWithToken);

      CommonDialog.hideLoading();

      return ChangeAccountModel.fromJson(response.data);
    } on DioError catch (error, stacktrace) {
      CommonDialog.hideLoading();
      if (error.response!.statusCode == 401) {
        toastMessage(error.response!.data['message'].toString());
      } else if (error.response!.statusCode == 404) {
        toastMessage(error.response!.statusMessage.toString());
      }
    }
  }


  Future<dynamic> uploadImage(String imagePath) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(imagePath),
    });
    var headerOptions = Options(
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',

      },
    );

    final response = await _dio.post(getUrlWithBaseUrl(ApiConstants.createUploadImageInChat),

        data: formData
    ,options: headerOptions
    );

    print("res $response");
    final responseData = response.data;
    if (responseData['status_code'] == 200) {
      return SendImageModel.fromJson(response.data);
    } else {
      throw Exception('Image upload failed');
    }
  }


  Future<dynamic> favoriate(int? id) async {
    CommonDialog.showLoading();
    var map = <String, dynamic>{
      "provider": id,

    };
    var headerOptionsWithToken = Options(
      headers: {
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      },
    );
    try {
      final response = await _dio.post(
          getUrlWithBaseUrl(ApiConstants.favourite),
          data: map,
          options: headerOptionsWithToken);
      CommonDialog.hideLoading();
      return FavouriteModel.fromJson(response.data);
    } on DioError catch (error, stacktrace) {
      CommonDialog.hideLoading();
      if (error.response!.statusCode == 401) {
        toastMessage(error.response!.data['message'].toString());
      } else if (error.response!.statusCode == 404) {
        toastMessage(error.response!.statusMessage.toString());
      }
    }
  }

  Future<dynamic> favoriateList() async {
    var headerOptions = Options(
      headers: {
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      },
    );
    try {

      Response response = await _dio.get(
          getUrlWithBaseUrl(ApiConstants.favourite),
          options: headerOptions);
      return ServiceListModel.fromJson(response.data);
    }
    catch (error) {

      var model = ServiceListModel.fromJson((error as dynamic).response.data);
      return model;
    }
  }

  Future<dynamic> getProfile() async {

    var headerOptions = Options(
      headers: {
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      },
    );
    try {Response response = await _dio.get(
          getUrlWithBaseUrl(ApiConstants.getProfile),
          options: headerOptions);
      return GetProfileModel.fromJson(response.data);
    }
    catch (error) {
      CommonDialog.hideLoading();
      var model = GetProfileModel.fromJson((error as dynamic).response.data);
      return model;
    }
  }

  Future<dynamic> editProfile(String name, String phone, String address, File image,) async {
    CommonDialog.showLoading();
    var map = <String, dynamic>{
      "name": name,
      "address":  address,
      "phone_number":  phone,
      if(image.path != "")
        "upload_image":  await MultipartFile.fromFile(image.path) ,
    };

    var headerOptions = Options(
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      },
    );
    try {
      final response = await _dio.patch(
          getUrlWithBaseUrl(ApiConstants.getProfile),
          data:  FormData.fromMap(map),
          options: headerOptions);

      CommonDialog.hideLoading();
      return EditProfileModel.fromJson(response.data);

    }  on DioError catch (error,stacktrace) {
      CommonDialog.hideLoading();
      if (error.response!.statusCode == 401) {
        toastMessage(error.response!.data['message'].toString());
      } else if (error.response!.statusCode == 404) {
        toastMessage(error.response!.statusMessage.toString());
      }else{
        toastMessage(error.response!.statusMessage.toString());
      }
    }
  }

  Future<dynamic> diagnostictools() async {
    // CommonDialog.showLoading();
    var headerOptions = Options(
      headers: {
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      },
    );
    try {
      // CommonDialog.hideLoading();
      Response response = await _dio.get(
          getUrlWithBaseUrl(ApiConstants.diagnostic),
          options: headerOptions);
      return DiagnosticModel.fromJson(response.data);
    }
    catch (error) {
      // CommonDialog.hideLoading();
      var model = DiagnosticModel.fromJson((error as dynamic).response.data);
      return model;
    }
  }

  Future<dynamic> addEmergencyContact(String name, String number) async {
    CommonDialog.showLoading();
    var map = <String, dynamic>{
      "name": name,
      "phone_number": number,
    };
    var headerOptions = Options(
      headers: {
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      },
    );
    try {
      final response = await _dio.post(
          getUrlWithBaseUrl(ApiConstants.emergency),
          data: map,
          options: headerOptions);

      CommonDialog.hideLoading();
      return AddEmergencyModel.fromJson(response.data);
    } on DioError catch (error, stacktrace) {
      CommonDialog.hideLoading();
      if (error.response!.statusCode == 401) {
        toastMessage(error.response!.data['message'].toString());
      } else if (error.response!.statusCode == 404) {
        toastMessage(error.response!.statusMessage.toString());
      }
    }
  }

  Future<dynamic> getEmergency() async {

    // CommonDialog.showLoading();
    var headerOptions = Options(
      headers: {
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      },
    );
    try {
      // CommonDialog.hideLoading();
      Response response = await _dio.get(
          getUrlWithBaseUrl(ApiConstants.emergency),
          options: headerOptions);
      return GetEmergencyModel.fromJson(response.data);
    }
    catch (error) {
      // CommonDialog.hideLoading();
      var model = GetEmergencyModel.fromJson((error as dynamic).response.data);
      return model;
    }
  }

  Future<dynamic> defaultContact(int? id) async {
    CommonDialog.showLoading();

    var map = <String, dynamic>{
      "is_default": true
    };
    var headerOptions = Options(
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',

      },
    );
    try {
      final response = await _dio.patch(
          getUrlWithBaseUrl("${ApiConstants.addDeafaultCard}$id"),
          data:  (map),
          options: headerOptions);

      CommonDialog.hideLoading();
      return AddDefaultModel.fromJson(response.data);

    }  on DioError catch (error, stacktrace) {
      CommonDialog.hideLoading();
      if (error.response!.statusCode == 401) {
        toastMessage(error.response!.data['message'].toString());
      } else if (error.response!.statusCode == 404) {
        toastMessage(error.response!.statusMessage.toString());
      }
    }
  }

  Future<dynamic> serviceHistory(String service) async {

    // CommonDialog.showLoading();
    var headerOptions = Options(
      headers: {
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      },
    );
    try {

      Response response = await _dio.get(
          getUrlWithBaseUrl("${ApiConstants.serviceHistory}$service"),
          options: headerOptions);
      // CommonDialog.hideLoading();
      return ServiceHistoryModel.fromJson(response.data);
    }
    catch (error) {
      // CommonDialog.hideLoading();
      var model = ServiceHistoryModel.fromJson((error as dynamic).response.data);
      return model;
    }
  }

  Future<dynamic> rating(String comment, id, int rate, String? idBooking, ) async {
    CommonDialog.showLoading();
    var map = <String, dynamic>{
      "booking": idBooking,
      "provider":int.parse(id.toString()),
      "ratings": rate,
      "comment": comment
    };
    var headerOptions = Options(
      headers: {"Content-Type": "application/json",
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      },
    );

    try {


      final response = await _dio.post(
          getUrlWithBaseUrl(ApiConstants.rating),
          data: map,
          options: headerOptions);

      CommonDialog.hideLoading();
      return RatingModel.fromJson(response.data);
    } on DioError catch (error, stacktrace) {
      CommonDialog.hideLoading();
      if (error.response!.statusCode == 401) {
        toastMessage(error.response!.data['message'].toString());
      } else if (error.response!.statusCode == 404) {
        toastMessage(error.response!.statusMessage.toString());
      }else{
        toastMessage(error.response!.statusMessage.toString());
      }
    }
  }


  Future<dynamic> cancelRequest(String id) async {
    CommonDialog.showLoading();

    var map = <String, dynamic>{
      "provider_status": "decline"
    };


    var headerOptions = Options(
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',

      },
    );
    try {
      final response = await _dio.patch(
          getUrlWithBaseUrl("${ApiConstants.cancelRequest}$id"),
          data:  FormData.fromMap(map),
          options: headerOptions);

      CommonDialog.hideLoading();
      return CancelRequestModel.fromJson(response.data);

    }  on DioError catch (error, stacktrace) {
      CommonDialog.hideLoading();
      if (error.response!.statusCode == 401) {
        toastMessage(error.response!.data['message'].toString());
      } else if (error.response!.statusCode == 404) {
        toastMessage(error.response!.statusMessage.toString());
      } else {
        toastMessage(error.response!.statusMessage.toString());
      }
    }
  }

  Future<dynamic> reminderSetting(bool value) async {
    CommonDialog.showLoading();

    var map = <String, dynamic>{
      "is_reminder": value
    };


    var headerOptions = Options(
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',

      },
    );
    try {
      final response = await _dio.patch(
          getUrlWithBaseUrl(ApiConstants.reminder),
          data:  map,
          options: headerOptions);

      CommonDialog.hideLoading();
      return ReminderModel.fromJson(response.data);
    }  on DioError catch (error, stacktrace) {
      CommonDialog.hideLoading();
      if (error.response!.statusCode == 401) {
        toastMessage(error.response!.data['message'].toString());
      } else if (error.response!.statusCode == 404) {
        toastMessage(error.response!.statusMessage.toString());
      }else{
        toastMessage(error.response!.statusMessage.toString());
      }
    }
  }

  Future<dynamic> getReminder() async {
    // CommonDialog.showLoading();
    var headerOptions = Options(
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',

      },
    );
    try {
      final response = await _dio.get(getUrlWithBaseUrl(ApiConstants.reminder),
          options: headerOptions);

      // CommonDialog.hideLoading();
      return ReminderModel.fromJson(response.data);
    } on DioError catch (error, stacktrace) {
      // CommonDialog.hideLoading();
      if (error.response!.statusCode == 401) {
        toastMessage(error.response!.data['message'].toString());
      } else if (error.response!.statusCode == 404) {
        toastMessage(error.response!.statusMessage.toString());
      }
    }
  }

  Future<dynamic> socialLogin(String? userName, String userEmail, String image, String? fcmToken,) async {

    var map = <String, dynamic>{
    'email' : userEmail,
    'name' : userName, 
      "fcm_token":fcmToken


    };
    try {
      final response = await _dio.post(getUrlWithBaseUrl(ApiConstants.socialLogin),
          data: FormData.fromMap(map));
      return SocialLoginModel.fromJson(response.data);
    } on DioError catch (error, stacktrace) {
      if (error.response!.statusCode == 401) {
        toastMessage(error.response!.data['message'].toString());
      } else if (error.response!.statusCode == 404) {
        toastMessage(error.response!.statusMessage.toString());
      }else{
        toastMessage(error.response!.statusMessage.toString());
      }
    }
  }

  Future<dynamic> getPrivacy() async {
    // CommonDialog.showLoading();
    var headerOptions = Options(
      headers: {
        "Content-Type": "application/json",
        // HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      },
    );
    try {Response response = await _dio.get(
        getUrlWithBaseUrl(ApiConstants.privacy),
        options: headerOptions);
    // CommonDialog.hideLoading();
    return StaticDataModel.fromJson(response.data);
    }
    catch (error) {
      // CommonDialog.hideLoading();
      var model = StaticDataModel.fromJson((error as dynamic).response.data);
      return model;
    }
  }

  Future<dynamic> term() async {

    var headerOptions = Options(
      headers: {
        "Content-Type": "application/json",
        // HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      },
    );
    try {Response response = await _dio.get(
        getUrlWithBaseUrl(ApiConstants.terms),
        options: headerOptions);
    return StaticDataModel.fromJson(response.data);
    }
    catch (error) {
      CommonDialog.hideLoading();
      var model = StaticDataModel.fromJson((error as dynamic).response.data);
      return model;
    }
  }

  Future<dynamic> about() async {

    var headerOptions = Options(
      headers: {
        "Content-Type": "application/json",
        // HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      },
    );
    try {Response response = await _dio.get(
        getUrlWithBaseUrl(ApiConstants.about),
        options: headerOptions);
    return StaticDataModel.fromJson(response.data);
    }
    catch (error) {
      CommonDialog.hideLoading();
      var model = StaticDataModel.fromJson((error as dynamic).response.data);
      return model;
    }
  }

  Future<dynamic> googleDetail(String lat, String long, String placeId, String latitude, String longitude, ) async {
   // CommonDialog.showLoading();
    var map = <String, dynamic>{
      "place_id":placeId,
      "destination_latitude":latitude,
      "destination_longitude": longitude,
      "origin_latitude":lat,
      "origin_longitude": long
    };
    var headerOptions = Options(
      headers: {"Content-Type": "application/json",
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      },
    );

    try {


      final response = await _dio.post(
          getUrlWithBaseUrl(ApiConstants.map_info),
          data: map,
          options: headerOptions);

     // CommonDialog.hideLoading();
      return GoogleDetailModel.fromJson(response.data);
    } on DioError catch (error, stacktrace) {
      // CommonDialog.hideLoading();
      if (error.response!.statusCode == 401) {
        toastMessage(error.response!.data['message'].toString());
      } else if (error.response!.statusCode == 404) {
        toastMessage(error.response!.statusMessage.toString());
      }else{
        toastMessage(error.response!.statusMessage.toString());
      }
    }
  }
}
