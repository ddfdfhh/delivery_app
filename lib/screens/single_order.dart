
import 'dart:developer';

import 'package:autoscale_tabbarview/autoscale_tabbarview.dart';

import 'package:delivery/constants.dart';
import 'package:delivery/controllers/network_controller.dart';

import 'package:delivery/controllers/order_controller.dart';
import 'package:delivery/routes.dart';
import 'package:delivery/theme.dart';
import 'package:delivery/util.dart';

import 'package:delivery/widgets/nointernet.dart';
import 'package:delivery/widgets/order_items.dart';
import 'package:delivery/widgets/timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SingleOrderScreen extends StatelessWidget {
  OrderController orderController = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      orderController.single_order_id.value = Get.arguments['order'];
    });
    NetworkController nc = Get.find();
    return Obx(() => nc.hasConnection.value
        ? Scaffold(

            appBar: AppBar(
              elevation: 0,
              foregroundColor: Colors.white,
              title: Text(
                "Order Detail",
              ),
              centerTitle: true,
              leading: InkWell(
                  onTap: () => {Get.back()}, child: Icon(Icons.arrow_back)),
            ),
            body: orderController.single_order_id.value > 0 &&
                    orderController.single_order.value.isNotEmpty
                ? SingleChildScrollView(
                    child: DefaultTabController(
                        length: 2,
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              TabBar(
                                  unselectedLabelColor: Colors.grey.shade800,

                                  labelColor: AppTheme(context: context).colors['primary'],
                                  tabs: [
                                    Tab(text: "Order Summery"),
                                    Tab(text: "Items"),
                                  ]),
                              AutoScaleTabBarView(children: [
                                Container(
                                    child: OrderDetail(context,
                                        orderController.single_order.value)),
                                ProductList(
                                    context, orderController.single_order.value)
                              ])
                            ])),
                  )
                : Center(child: const CircularProgressIndicator()),
          )
        : NoInternet(context));
  }

  Widget OrderDetail(BuildContext context, Map<String, dynamic> order) {
    return Padding(
      padding: EdgeInsets.all(30),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (order['delivery_status'] == 'Out For Delivery') ...[
              Container(
                  color: Colors.orange.shade100,
                  padding: EdgeInsets.all(8),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Your order will be delivered today',
                            style: AppTheme(context: context)
                                .textTheme['titleLargeBold']),
                        SizedBox(height: 10),
                        Text(
                            'To get more information about your order, you can contact our delivery agent',
                            style: AppTheme(context: context)
                                .textTheme['titleMedium']),
                        SizedBox(height: 10),
                        if (order['driver'] != null &&
                            order['driver']['name'].isNotEmpty)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${toUpperCase(order['driver']['name'])}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(color: Colors.green.shade800)),
                              InkWell(
                                  onTap: () async {
                                    var url = "tel:${order['driver']['phone']}";
                                    if (await canLaunch(url)) {
                                      await launch(url);
                                    } else {
                                      throw 'Could not launch $url';
                                    }
                                  },
                                  child:
                                      Icon(Icons.phone, color: Colors.green)),
                            ],
                          )
                      ])),
              SizedBox(height: 5)
            ],

            TimeLineW(context, order['order_delivery_updates']),
            Text(
              'Order details',
              textAlign: TextAlign.center,
              style:
                  AppTheme(context: context).textTheme["titleSmallGreenBold"],
            ),
            Container(
              //  height: 240,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Order Id:',
                        textAlign: TextAlign.center,
                        style: AppTheme(context: context)
                            .textTheme["titleMediumBlack"],
                      ),
                      Text(
                        '#${order['uuid']}',
                        textAlign: TextAlign.center,
                        style: AppTheme(context: context)
                            .textTheme["titleMediumBlack"],
                      ),
                    ],
                  ),
                  SizedBox(height: 08),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Order Date',
                        textAlign: TextAlign.center,
                        style: AppTheme(context: context)
                            .textTheme["titleMediumBlack"],
                      ),
                      Text(
                        '${formatDateTime(order['created_at'])}',
                        textAlign: TextAlign.center,
                        style: AppTheme(context: context)
                            .textTheme["titleMediumBlack"],
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Expected Delivery Date',
                        textAlign: TextAlign.center,
                        style: AppTheme(context: context)
                            .textTheme["titleMediumBlack"],
                      ),
                      Text(
                        '${formatDate(order['slot_date'])}',
                        textAlign: TextAlign.center,
                        style: AppTheme(context: context)
                            .textTheme["titleMediumBlack"],
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Expected Delivery Slot',
                        textAlign: TextAlign.center,
                        style: AppTheme(context: context)
                            .textTheme["titleMediumBlack"],
                      ),
                      Text(
                        '${order['slot_time']}',
                        textAlign: TextAlign.center,
                        style: AppTheme(context: context)
                            .textTheme["titleMediumBlack"],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Text(
              'Address',
              style:
                  AppTheme(context: context).textTheme["titleSmallGreenBold"],
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 260,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.home_outlined,
                          color: Colors.black87,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            '${order['user']['address']}',
                            textAlign: TextAlign.left,
                            style: AppTheme(context: context)
                                .textTheme["titleMediumBlack"],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 08),
                  Row(
                    children: [
                      Icon(
                        Icons.call_outlined,
                        color: Colors.black87,
                      ),
                      SizedBox(width: 8),
                      Text(' ${order['user']['phone']}'),
                    ],
                  )
                ],
              ),
            ),
            Text(
              'Payment details',
              textAlign: TextAlign.center,
              style:
                  AppTheme(context: context).textTheme["titleSmallGreenBold"],
            ),
            Container(
              //  height: 240,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Payment Mode',
                        textAlign: TextAlign.center,
                        style: AppTheme(context: context)
                            .textTheme["titleMediumBlack"],
                      ),
                      Text(
                        '${order['payment_method']}',
                        textAlign: TextAlign.center,
                        style: AppTheme(context: context)
                            .textTheme["titleMediumBlack"],
                      ),
                    ],
                  ),
                  SizedBox(height: 08),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Order items',
                        textAlign: TextAlign.center,
                        style: AppTheme(context: context)
                            .textTheme["titleMediumBlack"],
                      ),
                      Text(
                        '${order['no_of_items']} items',
                        textAlign: TextAlign.center,
                        style: AppTheme(context: context)
                            .textTheme["titleMediumBlack"],
                      ),
                    ],
                  ),
                  SizedBox(height: 08),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Sub total',
                        textAlign: TextAlign.center,
                        style: AppTheme(context: context)
                            .textTheme["titleMediumBlack"],
                      ),
                      Text(
                        '${currency}${substract(substract(double.parse(order['net_payable']),double.parse(order['shipping_cost'])) ,double.parse(order['total_tax']))}',
                        textAlign: TextAlign.center,
                        style: AppTheme(context: context)
                            .textTheme["titleMediumBlackBold"],
                      ),
                    ],
                  ),
                  SizedBox(height: 08),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Delivery charges',
                        textAlign: TextAlign.center,
                        style: AppTheme(context: context)
                            .textTheme["titleMediumBlack"],
                      ),
                      Text(
                        '${currency}${order['shipping_cost']}',
                        textAlign: TextAlign.center,
                        style: AppTheme(context: context)
                            .textTheme["titleMediumBlackBold"],
                      ),
                    ],
                  ),
                  SizedBox(height: 08),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        textAlign: TextAlign.center,
                        style: AppTheme(context: context)
                            .textTheme["titleMediumBlackBold"],
                      ),
                      Text(
                        '${currency}${order['net_payable']}',
                        textAlign: TextAlign.center,
                        style: AppTheme(context: context)
                            .textTheme["titleMediumRedBold"],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ]),
    );
  }

  Widget ProductList(BuildContext context, Map<String, dynamic> order) {
    return SingleChildScrollView(
        child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 900),
            child: ListView.builder(
                //shrinkWrap: true,
                itemCount: order['items'].length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: .5, color: Colors.black12),
                      ),
                    ),
                    width: double.maxFinite,
                    child: OrderItemWidget(
                      item: order['items'][index],
                    ),
                  );
                })));
  }

  Widget ItemsDetail(BuildContext context, Map<String, dynamic> order) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: order['items'].length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: .5, color: Colors.black12),
              ),
            ),
            width: double.maxFinite,
            child: OrderItemWidget(
              item: order['items'][index],
            ),
          );
        });
  }

  Widget BillingDetail(BuildContext context, Map<String, dynamic> order) {
    double offerDiscount =
        double.parse(order['total_cart_level_offer_discount']) +
            double.parse(order['total_individual_item_discount']);

    return Column(children: [
     Padding(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("Total Paid",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold)),
            Text("${currency}${order['net_payable']}",
                style: Theme.of(context).textTheme.labelLarge),
          ])),
    ]);
  }

  Widget BillingRow(BuildContext context, String title, String amount) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(title,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.bold)),
          Text("${currency}${amount}",
              style: Theme.of(context).textTheme.bodyLarge),
        ]));
  }

  Widget BillingRowOffer(BuildContext context, String title, double amount) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(title,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold)),
              Text("${currency}${amount}",
                  style: Theme.of(context).textTheme.bodyLarge),
            ]),
          ],
        ));
  }

  List<Widget> getChildrenWithSeperator(
      {required List<Widget> widgets,
      required Widget seperator,
      bool addToLastChild = true}) {
    List<Widget> children = [];
    if (widgets.length > 0) {
      children.add(seperator);

      for (int i = 0; i < widgets.length; i++) {
        children.add(widgets[i]);

        if (widgets.length - i == 1) {
          if (addToLastChild) {
            children.add(seperator);
          }
        } else {
          children.add(seperator);
        }
      }
    }
    return children;
  }

  //
  //
  // Widget Track(BuildContext context) {
  //   return Timeline.tileBuilder(
  //     builder: TimelineTileBuilder.fromStyle(
  //       contentsAlign: ContentsAlign.basic,
  //       contentsBuilder: (context, index) => Padding(
  //         padding: const EdgeInsets.all(24.0),
  //         child: Text('Timeline Event $index'),
  //       ),
  //       itemCount: 10,
  //     ),
  //   );
  // }
}
