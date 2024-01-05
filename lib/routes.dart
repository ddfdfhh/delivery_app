import 'package:delivery/screens/dashboard_screen.dart';
import 'package:delivery/screens/login_screen.dart';

import 'package:delivery/screens/nointenet.dart';
import 'package:delivery/screens/otp_screen.dart';

import 'package:delivery/screens/register_success.dart';
import 'package:delivery/screens/single_order.dart';
import 'package:delivery/screens/splash_screen.dart';

import 'package:get/get.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String welcome = '/welcome';
  static const String dashboard = '/dashboard';
  static const String success = '/success';
  static const String login = '/login';
  static const String register = '/register';
  static const String detail = '/detail';

  static const String account = '/account';

  static const String register_success = '/register_success';
  static const String location = '/location';

  static const String map = '/map';
  static const String otp = '/otp';
  static const String order_detail = '/order_detail';

  static const String nointernet = '/nointernet';
  static List<GetPage> pages = [
    GetPage(
      name: nointernet,
      page: () => NoIntenetScreen(),
    ),
    GetPage(
      name: dashboard,
      page: () => DashboardScreen(),
    ),
    GetPage(
      name: splash,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: login,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: otp,
      page: () => OTPScreen(),
    ),
    GetPage(
      name: order_detail,
      page: () => SingleOrderScreen(),
    ),
    // GetPage(
    //   name: register,
    //   page: () => RegisterScreen(),
    // ),
    GetPage(
      name: register_success,
      page: () => RegisterSuccess(),
    )
  ];
}
