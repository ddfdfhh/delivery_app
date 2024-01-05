import 'dart:convert';

import 'package:delivery/constants.dart';

import 'package:delivery/models/get_api_response_model.dart';

import 'package:delivery/models/user_model.dart';
import 'package:delivery/routes.dart';
import 'package:delivery/service/api_service.dart';
import 'package:delivery/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:pretty_http_logger/pretty_http_logger.dart';

class ProfileController extends GetxController {
  var isLoading = false.obs;
  UserService userService = Get.find();
  static const String baseUrl = baseApiUrl;
  var _status = ''.obs;
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  Future<void> onInit() async {
    super.onInit();

    nameController.text = userService.user!.name;
    emailController.text = userService.user!.email;
    phoneController.text = userService.user!.phone_number;
    addressController.text = userService.user!.address;
  }

  updateProfile() async {
    //  try {
    isLoading(true);
    var url = Uri.parse(baseApiUrl + '/updateProfile');
    var body = {
      'name': nameController.text,
      'address': addressController.text,
      'old_email': userService.user!.email,
      'old_phone': userService.user!.phone_number
    };


    ApiService.postRequest(ApiResponseType.Unformatted, '/updateProfile',body,null,
            (res) async{

              var userp = res['data']['user'];

              isLoading(false);
              Get.snackbar(
                "Success!",
                "Profile Updated Successfully",
                colorText: Colors.white,
                backgroundColor: Colors.lightGreen,
                icon: const Icon(Icons.check_circle),
              );


              final UserModel cacheUser = UserModel(
                  name: userp['name'],
                  email: userp['email'],
                  phone_number: userp['phone'],
                  address: userp['address'] != null ? userp['address'] : '',
                  token: userp['token'],
                  lat: userp['lat'],
                  lang: userp['lang']);

              await userService.userBox.put('user', cacheUser);
              userService.user = cacheUser;
              //DashboardController dc=Get.put(DashboardController());
             // dc.user_address.value=userp['address'];
              isLoading(false);
              Future.delayed(Duration(seconds: 2), () {
                Get.offNamed(AppRoutes.account);
              });


        }, (res){ isLoading(false);
          showDialog(
              context: Get.context!,
              builder: (context) {
                return SimpleDialog(
                  title: Text('Error'),
                  contentPadding: EdgeInsets.all(20),
                  children: [Text('${res['message']}')],
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
