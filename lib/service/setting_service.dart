import 'dart:convert';

import 'package:delivery/models/user_model.dart';
import 'package:delivery/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
class SettingService extends GetxService {
   Map<String,dynamic>? setting;

   void init() async {

      ApiService.getRequest(ApiResponseType.SingleRow,'/setting',(res){
        print('setting fetched');
        setting=res;


        // print(setting);
      },null);

  }

}