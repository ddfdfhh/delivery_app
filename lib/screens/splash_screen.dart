import 'package:delivery/constants.dart';
import 'package:delivery/controllers/network_controller.dart';
import 'package:delivery/controllers/register_controller.dart';
import 'package:delivery/routes.dart';
import 'package:delivery/service/user_service.dart';
import 'package:delivery/theme.dart';
import 'package:delivery/widgets/button.dart';
import 'package:delivery/widgets/nointernet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RegisterationController rc = Get.find();

    NetworkController nc = Get.find();
    UserService us=Get.find();
    return Obx(() => nc.hasConnection.value
        ? SafeArea(
      child: Scaffold(
        // extendBodyBehindAppBar: true,
        backgroundColor: AppTheme(context: context).colors['primary'],

        body: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.60,

              child: Padding(
                padding: const EdgeInsets.all(2),
                child: SizedBox(
                  // height: 100,
                  child: Image.asset(
                    '${assetUrl(context)}/del-boy3.png',
                    // height: 100,
                    // fit:BoxFit.fill
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(
                    top: 30, left: 30, right: 30, bottom: 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Hello Delivery Partners!',
                      style: AppTheme(context: context)
                          .textTheme["titleLargeBold"],
                      textAlign: TextAlign.center,
                    ),
                    // Text('eSchool serve you virtual education at your home',style:AppTheme(context).text["titleLargeBlackLight"],textAlign: TextAlign.center,),
                    Button1('Login Now', () {
                      if(us.user!=null) {
                        Get.offAndToNamed(AppRoutes.dashboard);

                    }else
                      Get.toNamed(AppRoutes.login);
                    }),
                    // AppTheme(context).Buttonwithtransparentbackground("Login Now"),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    )
        : NoInternet(context));
  }
}
