import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
double substract(double a, double b) {
  return ((a * 100).toInt() - (b * 100)).toInt() / 100;
}


Color getColorFromHexString (String c){
  return Color(int.parse(c.substring(1, 7), radix: 16) + 0xFF000000);
}
String? toUpperCase(String? txt){
  return txt!=null?toBeginningOfSentenceCase(txt):'';
}
String removeAllHtmlTags(String htmlText) {
  if(htmlText.isEmpty){
    return htmlText;
  }
  else {
    RegExp exp = RegExp(
        r"<[^>]*>",
        multiLine: true,
        caseSensitive: true
    );
    return htmlText.replaceAll(exp, '');
  }
}

MaterialColor getMaterialColor(Color color) {
  final int red = color.red;
  final int green = color.green;
  final int blue = color.blue;
  final int alpha = color.alpha;

  final Map<int, Color> shades = {
    50: Color.fromARGB(alpha, red, green, blue),
    100: Color.fromARGB(alpha, red, green, blue),
    200: Color.fromARGB(alpha, red, green, blue),
    300: Color.fromARGB(alpha, red, green, blue),
    400: Color.fromARGB(alpha, red, green, blue),
    500: Color.fromARGB(alpha, red, green, blue),
    600: Color.fromARGB(alpha, red, green, blue),
    700: Color.fromARGB(alpha, red, green, blue),
    800: Color.fromARGB(alpha, red, green, blue),
    900: Color.fromARGB(alpha, red, green, blue),
  };

  return MaterialColor(color.value, shades);
}
String formatDate(String datetime){
  var parsedDate = DateTime.parse(datetime);
  final DateFormat formatter = DateFormat('MMM d, y', 'en_US');
 return formatter.format(parsedDate);
}
String formatDateTime(String datetime){
  var parsedDate = DateTime.parse(datetime);
  final DateFormat formatter = DateFormat('MMM d, y HH:mm a', 'en_US');
  return formatter.format(parsedDate);
}
Widget AppText(String text,FontWeight fontWeight,
    double fontSize,Color fontColor){
  return Text(text,style:TextStyle(
      fontWeight:fontWeight,
      color:fontColor,
      fontSize:fontSize
  ));

}
Widget PolicyBulletLine(String text){
  return Text.rich(
    textAlign: TextAlign.justify,
    TextSpan(
      children: [
        WidgetSpan(
          child: Icon(
            Icons.arrow_forward,
            color: Colors.black,
            size: 16,
          ),
        ),
        TextSpan(
            text:
            ' ${text}'),
      ],
    ),
  );
}
Widget PolicyHeading(BuildContext context,String text){
  return  Text(
      '${text}',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        color:Colors.black,
        fontWeight: FontWeight.bold,
      )
  );
}
Widget PolicyParagraph(BuildContext context,String text){
  return  Text(
      '${text}',
      textAlign: TextAlign.justify,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color:Colors.black
      )
  );
}