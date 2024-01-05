import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> LoadingDialog(String text){
  return  showDialog(
      barrierDismissible: false, //Don't close dialog when click outside
      context: Get.context as BuildContext,
      builder: (_) {
        return Dialog(
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children:  [
                CircularProgressIndicator(), //Loading Indicator you can use any graphic
                SizedBox(
                  height: 20,
                ),
                Text('${text}...')
              ],
            ),
          ),
        );
      });
}