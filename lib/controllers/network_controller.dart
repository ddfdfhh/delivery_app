import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:delivery/dialog/dialog.dart';
import 'package:delivery/dialog/network_error_dialog.dart';
import 'package:delivery/routes.dart';
import 'package:delivery/service/user_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


class NetworkController extends GetxController {
  //0 = No Internet, 1 = WIFI Connected ,2 = Mobile Data Connected.
  var hasConnection = true.obs;
  var finshedChecking=false.obs;

  late StreamSubscription listener;

  @override
  void onInit() async{
    print('here');
    UserService us=Get.find();
    final connectivityResult = await (Connectivity().checkConnectivity());
    print('here is connectivity result');
    print(connectivityResult);
    if(connectivityResult==ConnectivityResult.mobile || connectivityResult==ConnectivityResult.wifi || connectivityResult==ConnectivityResult.vpn || connectivityResult==ConnectivityResult.ethernet){
      hasConnection(true);
    }
    else{
      hasConnection(false);
    }
    // if(us.user==null)
    //   hasConnection(true);
    // bool status= await InternetConnection().hasInternetAccess;
   // hasConnection(status);
    finshedChecking(true);
    super.onInit();
    listener = Connectivity().onConnectivityChanged.listen((var connectivityResult) {
      print('connectivityResult');
      print(connectivityResult);
      if(connectivityResult==ConnectivityResult.mobile || connectivityResult==ConnectivityResult.wifi || connectivityResult==ConnectivityResult.vpn || connectivityResult==ConnectivityResult.ethernet){
        hasConnection(true);
      }
      else{
        hasConnection(false);
      }
    });


  }


  @override
  void onClose() {
   // listener.cancel();
  }
}