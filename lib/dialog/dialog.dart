import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:delivery/models/get_api_response_model.dart';
import 'package:delivery/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

AwesomeDialog showAlertDialog(
    BuildContext context, DialogType dialogType, String message, String title,Function? onPress) {
  return AwesomeDialog(
    btnCancel: null,
    bodyHeaderDistance: 30,
    padding: EdgeInsets.symmetric(horizontal: 30,vertical: 50),
    btnOkColor: AppTheme(context: context).colors['primary'],
    btnCancelOnPress:null,
    context: context,

    dialogType: dialogType,
    animType: AnimType.scale,
    title: title,
    desc: message,
  btnOkOnPress: () {
      if(onPress!=null)
      onPress();
    },
  )..show();
}
