import 'package:delivery/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget ButtonWithIconText(BuildContext context,String text,IconData ic,
    Function? press,Color color,Color textColor){
  return  ElevatedButton.icon(

      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      onPressed: () {
       press!();
      },
      icon: Icon( // <-- Icon
        ic,
        size: 14.0,color:textColor
      ),
      label: Text(text,style:Theme.of(context).textTheme.bodyMedium));
}