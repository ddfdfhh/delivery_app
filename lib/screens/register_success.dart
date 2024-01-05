// ignore_for_file: prefer_const_constructors

import 'package:delivery/constants.dart';
import 'package:delivery/routes.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';


class RegisterSuccess extends StatelessWidget {
   RegisterSuccess({Key? key});

Color themeColor = const Color(0xFF43D19E);

  double screenWidth = 600;
  double screenHeight = 400;
  Color textColor = const Color(0xFF32567A);

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 170,
              padding: EdgeInsets.all(35),

              child: Image.asset(
                "${assetUrl(context)}/check.png",
                fit: BoxFit.contain,
              ),
            ),

            Text(
              "Thank You!",
              style: TextStyle(
                color: Colors.lightGreen,
                fontWeight: FontWeight.w600,
                fontSize: 36,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Text(
              "Registered Successfully",
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w400,
                fontSize: 17,
              ),
            ),

            SizedBox(height: screenHeight * 0.06),
            Flexible(
              child: ElevatedButton(onPressed: () {
                Get.toNamed(AppRoutes.login);
              }, child: Text('Login Now'),

              ),
            ),
          ],
        ),
      ),
    );
  }
}