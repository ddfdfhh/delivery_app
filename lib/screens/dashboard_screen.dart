import 'package:autoscale_tabbarview/autoscale_tabbarview.dart';
import 'package:delivery/controllers/RealLocationController.dart';
import 'package:delivery/controllers/login_controller.dart';
import 'package:delivery/controllers/order_controller.dart';
import 'package:delivery/dialog/delivery_confirm_dialog.dart';
import 'package:delivery/dialog/item_dialog.dart';
import 'package:delivery/dialog/location_dialog.dart';
import 'package:delivery/service/user_service.dart';
import 'package:delivery/theme.dart';
import 'package:delivery/util.dart';
import 'package:delivery/widgets/expansion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    OrderController oc = Get.put(OrderController());
    // Get.put(RealLocationController());
    UserService us = Get.find();
    return SafeArea(
      child: Scaffold(
        // extendBodyBehindAppBar: true,
        backgroundColor: AppTheme(context: context).colors['grey1'],
        appBar: AppBar(
            title: Column(
              children: [
                Text('Welcome ${us.user?.name}',
                    style: AppTheme(context: context)
                        .textTheme['bodyMediumBoldWhite']),
                Text('${us.user?.email}',style:AppTheme(context: context)
                    .textTheme['bodySmallWhite'])
              ],
            ),

          actions:[
            InkWell(
              onTap:(){
                LoginController lc=Get.put(LoginController());
                lc.logout();
              },
              child: Row(children:[

                 Padding(
                   padding: const EdgeInsets.only(right:5),
                   child: Text('Logout'),
                 ),Icon(Icons.logout,size:15),
          ]),
            )
          ]
        ),
        body: SingleChildScrollView(
            //   physics: NeverScrollableScrollPhysics(),
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Expansible(
                  context,
                  'Stats',
                  Obx(()=> Column(mainAxisSize: MainAxisSize.min, children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                    right: 15, left: 10, top: 15, bottom: 20),
                                decoration: BoxDecoration(
                                  color:
                                      AppTheme(context: context).colors["orange"],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                constraints: BoxConstraints(
                                    minHeight: 150,
                                    minWidth:
                                        MediaQuery.of(context).size.width * .5,
                                    maxHeight: 150),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipOval(
                                      child: Material(
                                        color: Colors.deepOrange,
                                        // Button color
                                        child: SizedBox(
                                            width: 56,
                                            height: 56,
                                            child: Icon(
                                              Icons.currency_rupee,
                                              color: Colors.white,
                                            )),
                                      ),
                                    ),

                                    Text(
                                      'TOTAL EARNINGS',
                                      style: AppTheme(context: context)
                                          .textTheme["titleMediumWhiteBold"],
                                    ),
                                    // SizedBox(height: 20),
                                    Text(
                                      'Not Set ',
                                      style: AppTheme(context: context)
                                          .textTheme["titleLargeWhiteBold"],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                      right: 15, left: 10, top: 15, bottom: 20),
                                  decoration: BoxDecoration(
                                    color: AppTheme(context: context)
                                        .colors["green"],
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  constraints: BoxConstraints(
                                      minHeight: 150,
                                      minWidth:
                                          MediaQuery.of(context).size.width * .5,
                                      maxHeight: 150),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ClipOval(
                                        child: Material(
                                          color: AppTheme(context: context)
                                              .colors["greenAccent"],
                                          // Button color
                                          child: SizedBox(
                                              width: 52,
                                              height: 52,
                                              child: Icon(
                                                Icons.task,
                                                color: Colors.white,
                                              )),
                                        ),
                                      ),

                                      Text(
                                        'COMPLETED ORDERS',
                                        style: AppTheme(context: context)
                                            .textTheme["titleMediumWhiteBold"],
                                      ),

                                      Text(
                                        '${oc.completed_order_count.value}',
                                        style: AppTheme(context: context)
                                            .textTheme["titleLargeWhiteBold"],
                                      ),

                                      // )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                    right: 15, left: 10, top: 15, bottom: 20),
                                decoration: BoxDecoration(
                                  color: Colors.orangeAccent,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                constraints: BoxConstraints(
                                    minHeight: 150,
                                    minWidth:
                                        MediaQuery.of(context).size.width * .5,
                                    maxHeight: 150),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipOval(
                                      child: Material(
                                        color: Colors.blue, // Button color
                                        child: SizedBox(
                                            width: 56,
                                            height: 56,
                                            child: Icon(
                                              Icons.currency_rupee,
                                              color: Colors.white,
                                            )),
                                      ),
                                    ),

                                    Text(
                                      'PENDING ORDERS',
                                      style: AppTheme(context: context)
                                          .textTheme["titleMediumWhiteBold"],
                                    ),
                                    // SizedBox(height: 20),
                                    Text(
                                      '${oc.pending_order_count.value}',
                                      style: AppTheme(context: context)
                                          .textTheme["titleLargeWhiteBold"],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                      right: 15, left: 10, top: 15, bottom: 20),
                                  decoration: BoxDecoration(
                                    color: AppTheme(context: context)
                                        .colors["green"],
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  constraints: BoxConstraints(
                                      minHeight: 150,
                                      minWidth:
                                          MediaQuery.of(context).size.width * .5,
                                      maxHeight: 150),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ClipOval(
                                        child: Material(
                                          color: AppTheme(context: context)
                                              .colors["greenAccent"],
                                          // Button color
                                          child: SizedBox(
                                              width: 52,
                                              height: 52,
                                              child: Icon(
                                                Icons.task,
                                                color: Colors.white,
                                              )),
                                        ),
                                      ),

                                      Text(
                                        'NEW RETURN ORDERS',
                                        style: AppTheme(context: context)
                                            .textTheme["titleMediumWhiteBold"],
                                      ),

                                      Text(
                                        '${oc.return_order_count.value}',
                                        style: AppTheme(context: context)
                                            .textTheme["titleLargeWhiteBold"],
                                      ),

                                      // )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ]),
                  ),
                  false,
                  null),
              Tabs1(context, MediaQuery.of(context).size.height),
            ],
          ),
        )),
      ),
    );
  }

  Widget OrderStrip(BuildContext context, Map<String, dynamic> order) {
    return Container(
      height: 210,
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme(context: context).colors["bgWhite"],
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppTheme(context: context).colors["grey2"],
            blurRadius: 1.0,
            // spreadRadius: 1.0,
          ), //BoxShadow//BoxShadow
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Order ',
                    style:
                        AppTheme(context: context).textTheme["titleLargeBlack"],
                  ),
                  Text(
                    '#${order['uuid']}',
                    style:
                        AppTheme(context: context).textTheme["titleLargeBlack"],
                  ),
                ],
              ),
              InkWell(
                  onTap: () {
                    DeliveryConfirmationDialog(
                        order['id'], order['otp'], 'Cancelled');
                  },
                  child: Text('Cancel Order',
                      style: AppTheme(context: context)
                          .textTheme['bodyLargeBoldColorUnderline'])),
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Text(
                'Customer Name:',
                style: AppTheme(context: context).textTheme["titleLargeBlack"],
              ),
              Text(
                ' ${toUpperCase(order['user']['name'])} ',
                style:
                    AppTheme(context: context).textTheme["titleMediumGreyBold"],
              ),
            ],
          ),
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(right: 1),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Exp. Delivery Time: ',
                    style:
                        AppTheme(context: context).textTheme["titleLargeBlack"],
                  ),
                  TextSpan(
                    text:
                        '${formatDate(order['slot_date'])} (${order['slot_time']})',
                    style: AppTheme(context: context)
                        .textTheme["titleMediumGreyBold"],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(right: 1),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Delivery Location: ',
                    style:
                        AppTheme(context: context).textTheme["titleLargeBlack"],
                  ),
                  TextSpan(
                    text:
                        '${order['user']['address']} ${order['user']['pincode']}.',
                    style: AppTheme(context: context)
                        .textTheme["titleMediumGreyBold"],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 5),
          SizedBox(
              //height: 100,
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: TextButton(
                      onPressed: () {
                        print('address');
                        print(order['user']);
                        LocationDialog(order['user']);
                      },
                      child: Text('Tracking'))),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                    onPressed: () {
                      DeliveryConfirmationDialog(
                          order['id'], order['otp'], 'Delivered');
                    },
                    child: FittedBox(child: Text('Set Delivered'))),
              ),
              Expanded(
                  child: TextButton(
                      onPressed: () {
                        OrderController oc = Get.find();
                        oc.single_order_id.value = order['id'];
                        OrderItemDialog();
                      },
                      child: Text('Items')))
            ],
          ))
        ],
      ),
    );
  }
  Widget ReturnOrderStrip(BuildContext context, Map<String, dynamic> order) {
    return Container(
      height: 210,
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme(context: context).colors["bgWhite"],
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppTheme(context: context).colors["grey2"],
            blurRadius: 1.0,
            // spreadRadius: 1.0,
          ), //BoxShadow//BoxShadow
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Order ',
                    style:
                    AppTheme(context: context).textTheme["titleLargeBlack"],
                  ),
                  Text(
                    '#${order['uuid']}',
                    style:
                    AppTheme(context: context).textTheme["titleLargeBlack"],
                  ),
                ],
              ),
              // InkWell(
              //     onTap: () {
              //       DeliveryConfirmationDialog(
              //           order['id'], order['otp'], 'Cancelled');
              //     },
              //     child: Text('Cancel Order',
              //         style: AppTheme(context: context)
              //             .textTheme['bodyLargeBoldColorUnderline'])),
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Text(
                'Customer Name:',
                style: AppTheme(context: context).textTheme["titleLargeBlack"],
              ),
              Text(
                ' ${toUpperCase(order['user']['name'])} ',
                style:
                AppTheme(context: context).textTheme["titleMediumGreyBold"],
              ),
            ],
          ),
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(right: 1),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Exp. Delivery Time: ',
                    style:
                    AppTheme(context: context).textTheme["titleLargeBlack"],
                  ),
                  TextSpan(
                    text:
                    '${formatDate(order['slot_date'])} (${order['slot_time']})',
                    style: AppTheme(context: context)
                        .textTheme["titleMediumGreyBold"],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(right: 1),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Delivery Location: ',
                    style:
                    AppTheme(context: context).textTheme["titleLargeBlack"],
                  ),
                  TextSpan(
                    text:
                    '${order['user']['address']} ${order['user']['pincode']}.',
                    style: AppTheme(context: context)
                        .textTheme["titleMediumGreyBold"],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 5),
          SizedBox(
            //height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: TextButton(
                          onPressed: () {
                            print('address');
                            print(order['user']);
                            LocationDialog(order['user']);
                          },
                          child: Text('Tracking'))),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                        onPressed: () {
                          DeliveryConfirmationDialog(
                              order['id'], order['otp'], 'Delivered');
                        },
                        child: FittedBox(child: Text('Set Delivered'))),
                  ),
                  Expanded(
                      child: TextButton(
                          onPressed: () {
                            OrderController oc = Get.find();
                            oc.single_order_id.value = order['id'];
                            OrderItemDialog();
                          },
                          child: Text('Items')))
                ],
              ))
        ],
      ),
    );
  }

  Widget Tabs1(BuildContext context, double height) {
    OrderController oc = Get.find();
    return DefaultTabController(
      length: 2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            child: TabBar(
                onTap: (selectedIndex) {
                  oc.loadSelectedTabData(selectedIndex);
                },
                isScrollable: true,
                overlayColor: MaterialStateProperty.all(Colors.pink.shade50),
                dividerColor: AppTheme(context: context).colors['primary'],
                labelColor: AppTheme(context: context).colors['primary'],
                labelStyle: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
                unselectedLabelColor: Colors.black87,
                unselectedLabelStyle: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
                indicatorColor: AppTheme(context: context).colors['primary'],
                indicator: BoxDecoration(
                    color: Colors.pink.shade50,
                    border: Border(
                      bottom: BorderSide(
                        //                   <--- left side
                        color: AppTheme(context: context).colors['primary'],
                        width: 2.0,
                      ),
                    )),
                tabs: [
                  Tab(text: "Pending Orders"),
                  Tab(text: "Pending Return Orders"),
                  // Tab(text: "All Orders"),
                  // Tab(text: "All Return Orders"),
                ]),
          ),
          AutoScaleTabBarView(children: [
            Container(
              height: MediaQuery.of(context).size.height * .7,
              child: Obx(() => oc.isOrderListLoading.value
                  ? Center(child: const CircularProgressIndicator())
                  : (oc.order_list.isNotEmpty
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  controller: oc.scrollController,
                                  //key: new PageStorageKey('myListView'),
                                  itemCount: oc.order_list.length,
                                  primary: false,
                                  scrollDirection: Axis.vertical,
                                  physics: AlwaysScrollableScrollPhysics(),
                                  itemBuilder: (BuildContext context, index) {
                                    return OrderStrip(
                                        context, oc.order_list[index]);
                                  }),
                            ),
                            if (oc.loadingMore.value)
                              Align(
                                  alignment: Alignment.center,
                                  child: const CircularProgressIndicator())
                          ],
                        )
                      : Align(child: Text('No Orders')))),
            ),
            Container(
              height: MediaQuery.of(context).size.height * .7,
              child: Obx(() => oc.isReturnOrderListLoading.value
                  ? Center(child: const CircularProgressIndicator())
                  : (oc.return_order_list.isNotEmpty
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  controller: oc.scrollControllerReturn,
                                  //key: new PageStorageKey('myListView'),
                                  itemCount: oc.return_order_list.length,
                                  primary: false,
                                  scrollDirection: Axis.vertical,
                                  physics: AlwaysScrollableScrollPhysics(),
                                  itemBuilder: (BuildContext context, index) {
                                    return ReturnOrderStrip(
                                        context, oc.return_order_list[index]);
                                  }),
                            ),
                            if (oc.loadingMoreReturn.value)
                              Align(
                                  alignment: Alignment.center,
                                  child: const CircularProgressIndicator())
                          ],
                        )
                      : Align(child: Text('No Return Orders')))),
            ),
          ]),
        ],
      ),
    );
  }
}
