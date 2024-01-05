
import 'package:delivery/controllers/login_controller.dart';
import 'package:delivery/controllers/network_controller.dart';
import 'package:delivery/controllers/order_controller.dart';
import 'package:delivery/controllers/register_controller.dart';
import 'package:delivery/service/api_service.dart';
import 'package:delivery/service/setting_service.dart';
import 'package:delivery/service/user_service.dart';

import 'package:get/get.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() async{

    NetworkController nc = Get.put<NetworkController>(NetworkController(),permanent: true);

    SettingService settingService =
    Get.put<SettingService>(SettingService(), permanent: true);
    settingService.init();
    ApiService apiService = Get.put<ApiService>(ApiService(), permanent: true);

    Get.lazyPut(() => RegisterationController());
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => OrderController());


  }
}