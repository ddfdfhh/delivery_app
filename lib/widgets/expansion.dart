import 'package:delivery/theme.dart';
import 'package:delivery/theme.dart';
import 'package:flutter/material.dart';

Widget Expansible(BuildContext context,String title,Widget w,bool expanded,IconData? leading){
  return Card(
      child: ExpansionTile(
        initiallyExpanded:expanded,
        expandedAlignment: Alignment.topLeft,
      leading:leading!=null?Icon(leading,color:AppTheme(context: context).colors['primary']):null,
      title: Text(title,style:Theme.of(context).
      textTheme.titleMedium?.copyWith(color:Colors.black,fontWeight: FontWeight.bold)),
      children: [
       Container(
         decoration: const BoxDecoration(border:Border(
             top:BorderSide(width:1,
             color:Colors.black12))),
          padding:EdgeInsets.symmetric(vertical:10,horizontal:0),
          child:w
      ),

      ],
  ));
}