import 'dart:convert';
import 'dart:ui';

import 'package:delivery/bindings/initial_binding.dart';
import 'package:delivery/routes.dart';
import 'package:delivery/theme.dart';
import 'package:get/get.dart';
import 'package:delivery/service/user_service.dart';
import 'package:delivery/util.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  var encryptionKey='Asd@123#';
  var containsEncryptionKey = await secureStorage.containsKey(key: encryptionKey);
  if (!containsEncryptionKey) {
    var key = Hive.generateSecureKey();
    await secureStorage.write(key: encryptionKey, value: base64UrlEncode(key));
  }
  Get.put<UserService>(UserService(), permanent: true);
  UserService us=Get.find();
  us.init(secureStorage,encryptionKey);

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Color(0xe7739246),
    statusBarBrightness: Brightness.light,
  ));
  // Get.reset();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(DevicePreview(
    enabled: false,
    builder: (context) => const MyApp(), // Wrap your app
  )));

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
   // SizeConfig().init(context);
    UserService us=Get.find();

  return GetMaterialApp(
            // scrollBehavior: const MaterialScrollBehavior().copyWith(
            //   dragDevices: {PointerDeviceKind.mouse},
            // ),
              initialBinding: InitialBinding(),
              debugShowCheckedModeBanner: false,
              title: 'Delivery App',
              theme: ThemeData(
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                  fontFamily: GoogleFonts.robotoCondensed().fontFamily,
                  tabBarTheme: TabBarTheme(

                      labelStyle:AppTheme(context: context).textTheme['bodyLargeBoldColor'],
                      unselectedLabelStyle:AppTheme(context: context).textTheme['bodyLargeBold']
                  ),
                  appBarTheme: AppBarTheme(

                    titleTextStyle: AppTheme(context: context).textTheme['titleMediumBoldWhite'],

                  ),
                  // colorScheme: ColorScheme.fromSeed(
                  //   seedColor: AppTheme(context: context).colors['primary'],
                  // ).copyWith(
                  //   primary: Color(0xe77b9c4a),
                  // ),
                  colorScheme: ColorScheme.fromSwatch(
                      primarySwatch: getMaterialColor(Color(0xFFEB1A3C))),
                  // textTheme:
                  //     GoogleFonts.nunitoTextTheme(Theme.of(context).textTheme),
                  sliderTheme: SliderThemeData(
                    activeTickMarkColor: Colors.green,
                    showValueIndicator: ShowValueIndicator.always,
                    overlayColor: Colors.green,
                    valueIndicatorColor: Colors.lightGreen.shade600,
                  )),
      initialRoute: us.user!=null?AppRoutes.dashboard:AppRoutes.splash,
              getPages: AppRoutes.pages);
        }
  }


