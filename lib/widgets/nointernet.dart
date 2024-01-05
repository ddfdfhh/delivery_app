import 'package:delivery/constants.dart';
import 'package:delivery/controllers/network_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget NoInternet(BuildContext context){
  NetworkController nc=Get.find();
  return Scaffold(
      backgroundColor: Colors.white,
      body:Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
        Image.asset('${assetUrl(context)}/nointernet.jpg',width:300,height:200),
        Text('No Internet Connection'),
        SizedBox(width:200,child:ElevatedButton(onPressed: (){
          print(Get.currentRoute);
          if(nc.hasConnection.value){
             Get.to(Get.currentRoute);
          }
          else
            return;
        }, child: const Text('Retry Connection')))
    ],

  ),
      ));
}