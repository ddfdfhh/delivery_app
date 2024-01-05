import 'dart:convert';

import 'package:delivery/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class UserService extends GetxService {
  UserModel? user;
  String? device_token;
  int currentIndex = 0;
  //late var finalEncryptionKey;
  late Box<UserModel> userBox;
  void init(FlutterSecureStorage secureStorage,String encryptionKey) async {

    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
    //await Hive.init;/***webbroswer**/
    if (!Hive.isAdapterRegistered(0)) Hive.registerAdapter(UserModelAdapter());
    var p=await secureStorage.read(key:encryptionKey);
    var encryptionKey1 = base64Url.decode(p!);
  //  finalEncryptionKey=encryptionKey1;
     userBox = await Hive.openBox('Usercache', encryptionCipher: HiveAesCipher(encryptionKey1));
     user = userBox.get('user');
  }
  setDeviceToken(String token){
      device_token=token;

  }
}
