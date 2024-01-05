import 'package:delivery/theme.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget DefaultButton(
    BuildContext context, String label, onPressed, Color? color,
    {bool isLoading = false}) {
  return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: color != null
              ? color
              : AppTheme(context: context).colors['primary'],
          minimumSize: Size(180, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          )),
      child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isLoading
                  ? CircularProgressIndicator(
                      backgroundColor:
                          AppTheme(context: context).colors['primary'],
                      color: Colors.white)
                  : Text(label,
                      style: AppTheme(context: context)
                          .textTheme["titleSmallWhiteBold"]),
            ],
          )));
}

Widget Button1(String text, Function onPressed) {
  BuildContext context = Get.context as BuildContext;
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30.0),
        backgroundColor: AppTheme(context: context).colors['primary'],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        side: BorderSide(width: 1, color: Colors.white)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      // mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          text,
          style: AppTheme(context: context).textTheme["titleLargeWhiteBold"],
        ),
      ],
    ),
    onPressed: () {
      onPressed();
    },
  );
}
