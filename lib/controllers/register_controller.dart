import 'dart:convert';
import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:delivery/constants.dart';
import 'package:delivery/dialog/dialog.dart';
import 'package:delivery/models/user_model.dart';
import 'package:delivery/routes.dart';
import 'package:delivery/service/api_service.dart';
import 'package:delivery/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:telephony/telephony.dart';
import 'package:otp_text_field/otp_text_field.dart';

class RegisterationController extends GetxController {
  var showPassword = false.obs;
  var isLoading = false.obs;
  var _status = ''.obs;
  UserService userService = Get.find();
  final formKey = GlobalKey<FormState>();
  var otp_response = ''.obs;
  Rx<UserModel?> user = (null as UserModel?).obs;
  var email = (null as String?).obs;
  var phone = (null as String?).obs;
  var otp = (null as String?).obs;
  OtpFieldController otpbox = OtpFieldController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  late Telephony telephony;
  Future<void> onInit() async {
    super.onInit();
    // telephony = Telephony.instance;
    // telephony.listenIncomingSms(
    //   onNewMessage: (SmsMessage message) {
    //
    //     String sms = message.body.toString(); //get the message
    //     String otpcode = sms.replaceAll(new RegExp(r'[^0-9]'), '');
    //
    //     otpbox.set(otpcode.split(""));
    //     update();
    //   },
    //   listenInBackground: false,
    // );
    // userService.init();
  }

  resend_otp() async {
    isLoading(true);

    var url = Uri.parse(baseApiUrl + '/resend_otp');
    if (phone.value == null) {

      showAlertDialog(Get.context as BuildContext, DialogType.error,
          'Some error occured ,please login again', 'Error', null);
    } else {

      var body = {'phone': phone.value};
      ApiService.postRequest(
          ApiResponseType.PlainString, '/resendOtp', body, null, (res) {
        otp_response.value = res;
        isLoading(false);
      }, (){
        isLoading(false);
      }, showRequestDetail: false);
    }
  }

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  registerWithEmail() async {
    //  try {
    isLoading(true);
   UserService us=Get.find();

    var body = {
      'name': nameController.text,
      'email': emailController.text.trim(),
      'phone': phoneController.text,'device_token':us.device_token??''
    };

    ApiService.postRequest(ApiResponseType.SingleRow, '/register', body, null,
        (res) {
      String email = emailController.text.trim();
      String phone = phoneController.text.trim();
      nameController.clear();
      emailController.clear();
      phoneController.clear();
      isLoading(false);
      Get.toNamed(AppRoutes.register_success);
    }, (res) {
      isLoading(false);

      showAlertDialog(Get.context as BuildContext, DialogType.error,
          res['message'], 'Error', null);
    }, showRequestDetail: false);
  }

  verifyOtp() async {
    print('see');
    print(phone.value);
    print(otp.value);
    if (otp.value == null || phone.value == null) {
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: Text('Error'),
              contentPadding: EdgeInsets.all(20),
              children: [Text('Some Error ocurred')],
            );
          });
      return;
    }
    isLoading(true);
    UserService us=Get.find();

    var body = {'otp': otp.value,
      'phone': phone.value,
      };
print('okoko');
    ApiService.postRequest(
        ApiResponseType.Unformatted, '/verifyOtp', body, null, (res) async {
      var user = res['user'];
      var token = res['token'];

      final UserModel cacheUser = UserModel(
          name: user['name'],
          email: user['email'],
          phone_number: user['phone'],
          address: user['address'] != null ? user['address'] : '',
          token: token);

      //CACHE_BOX_NAME is any string key

      await userService.userBox.put('user', cacheUser);

      userService.user = cacheUser;
      isLoading(false);
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: Text('Sucess'),
              contentPadding: EdgeInsets.all(20),
              children: [Text('OTP verified successfully')],
            );
          });
      Get.offNamedUntil(AppRoutes.dashboard, (route) => false);
     // Get.offAndToNamed(AppRoutes.dashboard);
    }, (res) {
      isLoading(false);

      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: Text('Error'),
              contentPadding: EdgeInsets.all(20),
              children: [Text('OTP is incorrect or invalid')],
            );
          });
    }, showRequestDetail: false);
  }

  String? validateName() {
    if (nameController.text.trim().isEmpty) {
      return "Name field is required";
    }

    return null;
  }

  String? validatePhone() {
    if (phoneController.text.trim().isEmpty) {
      return "Phone Number is required";
    }

    return null;
  }

  String? validateEmail() {
    if (emailController.text.trim().isEmpty) {
      return "Email field is required";
    }
    if (!emailController.text.trim().isEmail) {
      return "Please enter valid email";
    }

    return null;
  }

  String? validatePassword() {
    if (passwordController.text.trim().isEmpty) {
      return 'Enter password';
    }
    if (passwordController.text.trim().length < 7) {
      return 'Min Lenght of 7 is required';
    }

    return null;
  }
}
