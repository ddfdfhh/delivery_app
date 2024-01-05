import 'dart:convert';

import 'package:delivery/constants.dart';
import 'package:delivery/controllers/register_controller.dart';

import 'package:delivery/models/user_model.dart';
import 'package:delivery/routes.dart';
import 'package:delivery/service/api_service.dart';
import 'package:delivery/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  UserService userService = Get.find();
  var showPassword = false.obs;
  var isLoading = false.obs;
  var _status = ''.obs;
  final formKey = GlobalKey<FormState>();

  final phoneController = TextEditingController();
  @override
  void onInit() {
    super.onInit();
    //userService.init();
  }

  @override
  void onClose() {

    phoneController.dispose();
  }



  sub() async {
    print('going in i');
    isLoading(true);

    Map<String, dynamic> body = {};
    // if (emailController.text.trim().isNotEmpty)
    //   body['email'] = emailController.text.trim();

    if (phoneController.text.trim().isNotEmpty)
      body['phone'] = phoneController.text.trim();
      body['role'] = 'Driver';
print('going in i');
    ApiService.postRequest(ApiResponseType.Unformatted, '/login', body, null,
        (res) {

      String phone = phoneController.text.trim();
print('doneoneon');
      phoneController.clear();
      isLoading(false);

      Future.delayed(
          Duration(seconds: 1),
          (){
                   RegisterationController rc=Get.find();
                   rc.phone.value=phone;
            Get.toNamed(AppRoutes.otp);
          });
    },(res){
          isLoading(false);
        }, showRequestDetail: false);
  }

  String? validatePhone() {
    if (phoneController.text.trim().isEmpty) {
      return "Phone Number is required";
    }

    return null;
  }

  logout() async {
    await userService.userBox.clear();
    Get.offAllNamed(AppRoutes.login);
  }
}
