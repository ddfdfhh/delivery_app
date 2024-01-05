import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:delivery/dialog/dialog.dart';
import 'package:delivery/dialog/loading_dialog.dart';
import 'package:delivery/routes.dart';

import 'package:delivery/service/api_service.dart';
import 'package:delivery/service/setting_service.dart';
import 'package:delivery/service/user_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';

class OrderController extends GetxController {
  // PaymentController pc = Get.put(PaymentController());
  late ScrollController scrollController;
  late ScrollController scrollControllerReturn;

  final orderOtpController = TextEditingController();
  UserService userService = Get.find();
  SettingService settingService = Get.find();
  var showDialog = false.obs;
  var isOrderListLoading = false.obs;
  var isLoadingSingleOrder = false.obs;
  var isReturnOrderListLoading = false.obs;

  Rx<String?> status = (null as String?).obs;
  var isCancellingOrder = false.obs;
  var loadingMore = false.obs;
  var settingDeliveryConfirmation = false.obs;
  var noMoreData = false.obs;
  var noMoreDataReturn = false.obs;
  var loadingMoreReturn = false.obs;
  var cancelled_order_id = 0.obs;
  var current_timestamp = DateTime.now().millisecondsSinceEpoch.obs;

  var pending_order_count = 0.obs;
   var return_order_count = 0.obs;
   var completed_order_count = 0.obs;
  var current_page = 1.obs;
  var current_page_return = 1.obs;
  RxMap<String, dynamic> single_order = <String, dynamic>{}.obs;
  RxMap<String, dynamic> any_current_pending_order = <String, dynamic>{}.obs;
  var single_order_id = 2.obs;

  RxList<Map<String, dynamic>> order_list = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> return_order_list = <Map<String, dynamic>>[].obs;
  @override
  void onInit() async {
    super.onInit();
    scrollController = new ScrollController()..addListener(scrollListener);
    scrollControllerReturn = new ScrollController()
      ..addListener(scrollListenerReturn);

    ever(status, (_) => fetchOrders());
    ever(single_order_id,
        (_) => fetchSingleOrder(single_order_id.value.toString()));

    fetchOrders();
  fetchDriverStats();
    everAll([isCancellingOrder, settingDeliveryConfirmation], (_) => do1());
  }

  void do1() {
    if (settingDeliveryConfirmation.value || isCancellingOrder.value)
      LoadingDialog('Please Wait..');
    else
      Navigator.of(Get.context as BuildContext, rootNavigator: true)
          .pop('dialog');
  }

  scrollListener() {
    print('loading more');
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !noMoreData.value) {
      current_page.value = current_page.value + 1;

      loadMoreData();
    }
  }

  scrollListenerReturn() {
    if (scrollControllerReturn.position.pixels ==
            scrollControllerReturn.position.maxScrollExtent &&
        !noMoreDataReturn.value) {
      current_page_return.value = current_page_return.value + 1;

      loadMoreData();
    }
  }

  cancelOrder(int id,String otp) async {
    String entred_otp = orderOtpController.text.trim();
    if (entred_otp != otp) {
      settingDeliveryConfirmation(false);
      showAlertDialog(Get.context as BuildContext, DialogType.error,
          'OTP is wrong', 'Erorr', null);
    } else {
      var body = {
        'id': id.toString(),
      };
      isCancellingOrder(true);
      ApiService.postRequest(
          ApiResponseType.PlainString, '/driver/order_cancel', body, null, (
          res) {
        isCancellingOrder(false);
       showAlertDialog(Get.context as BuildContext, DialogType.success, 'Order Cancelled Successfully', 'Success', (){
         Get.back();
         status.value='Order Placed';
         Get.offAndToNamed(AppRoutes.dashboard);
       });

      }, (res) {
        isCancellingOrder(false);
      }, showRequestDetail: false);
    }
  }
  fetchDriverStats() async {

      ApiService.getRequest(
          ApiResponseType.SingleRow, '/driver/orders', (
          res) {

       pending_order_count.value=res['pending_count'];
       return_order_count.value=res['return_count'];
       completed_order_count.value=res['delivered_count'];

      },null);
    }


  fetchOrders() async {
   if (status.value == null || status.value == 'Order Placed')
      isOrderListLoading(true);
    else {
      if (status.value != null) isReturnOrderListLoading(true);
    }

    var body = {
      'phone': userService.user?.phone_number,
    };
    if (status.value != null) body['status'] = status.value;

    ApiService.postRequest(
        ApiResponseType.MultipleRow, '/driver/order_history', body, null,
        (res) {


      if (status.value == null || status.value == 'Order Placed') {
        order_list.clear();
        for (var json in res) {
          order_list.add(json);
        }
        order_list.refresh();
        isOrderListLoading(false);
      } else {

        if (status.value != null) {
          return_order_list.clear();
          for (var json in res) {
            return_order_list.add(json);
          }
          return_order_list.refresh();
          isReturnOrderListLoading(false);
        }
      }

      print('finally fojd');

      //if (status == 'Pending') pending_order_count.value = order_list.length;
    }, (res) {
      isOrderListLoading(false);
      isReturnOrderListLoading(false);
    }, showRequestDetail: false);
  }

  loadMoreData() async {
    String append = '';
    if (status.value == null || status.value == 'Order Placed') {
      loadingMore(true);
      append = '?page=${current_page}';
    } else {
      if (status.value != null) {
        loadingMoreReturn(true);
        append = '?page=${current_page_return}';
      }
    }

    var body = {'phone': userService.user?.phone_number};
    if (status.value != null) {
      body['status'] = status.value;
    }

    ApiService.postRequest(ApiResponseType.MultipleRow,
        '/driver/order_history${append}', body, null, (res) {
      if (res.length > 0) {
        if (status.value == null || status.value == 'Order Placed') {
          for (var json in res) {
            order_list.add(json);
          }

          order_list.refresh();
          loadingMore(false);
        } else {
          for (var json in res) {
            return_order_list.add(json);
          }
          return_order_list.refresh();
          loadingMoreReturn(false);
        }
      } else {
        noMoreData(false);
        loadingMore(false);
        noMoreDataReturn(false);
        loadingMoreReturn(false);
      }

      //if (status == 'Pending') pending_order_count.value = order_list.length;
    }, (res) {
      noMoreData(false);
      loadingMore(false);
      isOrderListLoading(false);
      isReturnOrderListLoading(false);

      if (status.value == null || status.value == 'Order Placed') {
        noMoreData(false);
        loadingMore(false);
        isOrderListLoading(false);
      } else {
        noMoreDataReturn(false);
        loadingMoreReturn(false);

        isReturnOrderListLoading(false);
      }
    }, showRequestDetail: false);
  }

  fetchSingleOrder(String orderid) async {
    isLoadingSingleOrder(true);
    String uri='/driver/orders/' + orderid;
    if(status.value!='Order Placed')
       uri='/driver/return_orders/' + orderid;
    ApiService.getRequest(
        ApiResponseType.SingleRow, uri, (res) {
      single_order.value = res;

      List<dynamic> statuses =
          jsonDecode(single_order.value['order_delivery_updates']);

      List<Map<String, dynamic>> items = [];
      if(single_order.value['items']!=null) {
        single_order.value['items'] = single_order.value['items']
            .map((e) => e as Map<String, dynamic>)
            .toList();
      }
      else{
        single_order.value['items'] = single_order.value['return_items']
            .map((e) => e as Map<String, dynamic>)
            .toList();
      }
      single_order.value['user'] =
          single_order.value['user'] as Map<String, dynamic>;
      single_order.value['driver'] = single_order.value['driver_id'] != null
          ? single_order.value['driver'] as Map<String, dynamic>
          : null;
      single_order.value['order_delivery_updates'] =
          statuses.map((e) => e as Map<String, dynamic>).toList();
      isLoadingSingleOrder(false);
    }, (res) {
      isLoadingSingleOrder(false);
    }, showRequestDetail: false);
  }

  loadSelectedTabData(int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        status.value = 'Order Placed';

        break;
      case 1:
        status.value = 'Exchanged';
      case 1:
        status.value = null;
    }
  }

  confirmOrderDelivery(int id, String otp) {
    settingDeliveryConfirmation(true);
    String entred_otp = orderOtpController.text.trim();
    if (entred_otp != otp) {
      settingDeliveryConfirmation(false);
      showAlertDialog(Get.context as BuildContext, DialogType.error,
          'OTP is wrong', 'Erorr', null);
    } else {
      ApiService.postRequest(
          ApiResponseType.PlainString,
          '/driver/confirm_order_delivery',
          {'order_id': id.toString()},
          null, (res) {
        settingDeliveryConfirmation(false);
        showAlertDialog(Get.context as BuildContext, DialogType.success,
            'Set Successfully', 'Success', () {
              Get.back();
              status.value='Order Placed';
              Get.offAndToNamed(AppRoutes.dashboard);
        });
      }, (res) {
        settingDeliveryConfirmation(false);
      }, showRequestDetail: false);
    }
  }
}
