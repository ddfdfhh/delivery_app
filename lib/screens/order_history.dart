import 'package:delivery/constants.dart';
import 'package:delivery/controllers/network_controller.dart';
import 'package:delivery/controllers/order_controller.dart';
import 'package:delivery/routes.dart';
import 'package:delivery/theme.dart';
import 'package:delivery/util.dart';
import 'package:delivery/widgets/bottom_nav.dart';
import 'package:delivery/widgets/nointernet.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class OrderHistoryScreen extends StatelessWidget {
  OrderController oc = Get.find();
  
  @override
  Widget build(BuildContext context) {
    NetworkController nc = Get.find();
    return Obx(() => nc.hasConnection.value
        ? Scaffold(
            bottomNavigationBar: BottomNavBar(),
            appBar: AppBar(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              )),
              elevation: 0,
              foregroundColor: Colors.white,
              title: Text(
                "Order History",
              ),
              centerTitle: true,
              leading: InkWell(
                  onTap: () => {Get.back()}, child: Icon(Icons.arrow_back)),
            ),
            body: SafeArea(
                child: oc.isOrderListLoading.value
                    ? Center(child: const CircularProgressIndicator())
                    : (oc.order_list.isNotEmpty
                        ? SingleChildScrollView(
                            child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(height: 1),
                                      ...oc.order_list.map(
                                          (data) => OrderStrip(context, data))
                                    ])))
                        : Center(child: Text('No Order placed')))))
        : NoInternet(context));
  }

  Widget Btn(BuildContext context, String txt, bool isActive) {
    return ElevatedButton(
      onPressed: () {
        oc.status.value = txt;
      },
      child: Text('${txt}',
          style: TextStyle(color: isActive ? Colors.white : Colors.black)),
      style: ElevatedButton.styleFrom(
        minimumSize: Size(40, 30),
        backgroundColor: isActive
            ? AppTheme(context: context).colors['primary']
            : Colors.white,
        side: BorderSide(width: 1, color: Colors.lightGreen),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  Widget OrderStrip(BuildContext context, Map<String, dynamic> order) {
    return InkWell(
      splashColor: Colors.lightGreen.shade100,
      highlightColor: Colors.lightGreen.shade100,
      onTap: () {
        Get.toNamed(AppRoutes.order_detail, arguments: {'order': order['id']});
      },
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.grey.shade100,
              border: Border.all(
                color: Colors.grey, //                   <--- border color
                width: 1.0,
              ),
              borderRadius: BorderRadius.all(Radius.circular(09))),
          child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${formatDate(order['created_at'])}',
                      textAlign: TextAlign.center,
                      style: AppTheme(context: context).textTheme["bodyLarge"],
                    ),
                    Row(
                      children: [
                        Text(
                          '${currency}${order['net_payable']}',
                          textAlign: TextAlign.center,
                          style: AppTheme(context: context)
                              .textTheme["titleLargeBlack"],
                        ),
                        Icon(Icons.chevron_right_outlined,
                            // size: 13,
                            color: Colors.black)
                      ],
                    )
                  ],
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Order',
                    style: AppTheme(context: context).textTheme["bodyLarge"],
                    /*defining default style is optional */
                    children: <TextSpan>[
                      TextSpan(
                        text: ' #${order['uuid']} ',
                        style: AppTheme(context: context)
                            .textTheme["bodyMediumBold"],
                      ),
                    ],
                  ),
                ),
                // Text(
                //   'Order #1234567',
                //   textAlign: TextAlign.center,
                //   style:
                //   AppTheme(context).text["titleMediumBlackLight"],
                // ),
                SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.shopping_bag_outlined,
                        // size: 13,
                        color: Colors.black),
                    Expanded(
                      child: SizedBox(
                        width: 295,
                        child: Text(
                          'You ordered ${order['no_of_items']} item(s)',
                          textAlign: TextAlign.center,
                          style:
                              AppTheme(context: context).textTheme["bodyLarge"],
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Delivery Status',
                          textAlign: TextAlign.center,
                          style: AppTheme(context: context)
                              .textTheme["bodyMediumBold"],
                        ),
                        // SizedBox(width: 5),
                        Text(
                          '${order['delivery_status']}',
                          textAlign: TextAlign.center,
                          style:
                              AppTheme(context: context).textTheme["bodyLarge"],
                        ),
                        if (order['delivery_status'] == 'Delivered')
                          Text(
                            '${order['delivered_date'] != null ? formatDate(order['delivered_date']) : ''}',
                            textAlign: TextAlign.center,
                            style: AppTheme(context: context)
                                .textTheme["bodySmallOrange"],
                          ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Payment Mode',
                          textAlign: TextAlign.center,
                          style: AppTheme(context: context)
                              .textTheme["bodyMediumBold"],
                        ),
                        Text(
                          '${order['payment_method']}',
                          textAlign: TextAlign.center,
                          style:
                              AppTheme(context: context).textTheme["bodyLarge"],
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (order['delivery_status'] == 'Order Placed')
                      Expanded(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(width: 5),
                          InkWell(
                            onTap: () {
                             // oc.cancelOrder(order['id']);
                            },
                            splashColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            child: oc.cancelled_order_id.value == order['id']
                                      ? Text('Cancelled',
                                          style: TextStyle(color: Colors.red))
                                      : Text('Cancel order',
                                          style: AppTheme(context: context)
                                                  .textTheme[
                                              "titleMediumBlackBold"]),

                          ),
                          Container(
                              color: Colors.black12,
                              width: 1,
                              height: 30,
                              child: Text('')),
                        ],
                      )),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.toNamed(AppRoutes.order_detail,
                              arguments: {'order': order['id']});
                        },
                        splashColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: Text('View your order',
                            textAlign: TextAlign.center,
                            style: AppTheme(context: context)
                                .textTheme["titleMediumRedBold"]),
                      ),
                    ),
                  ],
                )
              ]),
        ),
      ),
    );
  }
}
