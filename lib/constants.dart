import 'package:delivery/routes.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

const baseUrl = "https://dornish.flexipattern.biz";
assetUrl(BuildContext? context){
  if(context==null)
     context=Get.context as BuildContext;

 return Theme.of(context).platform == TargetPlatform.android?'assets/images':'images';
}
//const baseUrl="http://grocery.test";
//const baseUrl='https://cb83-2409-4089-a102-34dc-3c12-8f93-ab68-640e.ngrok-free.app';
const currency = '₹';
const baseApiUrl = baseUrl + "/api";
const apiKey="YdmBIJus";
const salt="txjsIh21PH";
const authHeader="Rqrb4AnCrdVvaLu//ghITegIyhE7hTmDr8pyRMEpzZs=";
enum PriceOrder { Asc, Desc }

enum DiscountOrder { Asc, Desc }

class NavigatorItem {
  final String label;
  final IconData iconPath;
  final int index;
  final String path;

  NavigatorItem(this.label, this.iconPath, this.index, this.path);
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

List<NavigatorItem> navigatorItems = [
  NavigatorItem("Home", Icons.home_outlined, 0, AppRoutes.dashboard),
  // NavigatorItem(
  //     "Categories",  Icons.category_outlined, 1, AppRoutes.main_categories),
  // NavigatorItem("Cart", Icons.shopping_cart_outlined, 2, AppRoutes.cart),
  // NavigatorItem("My Orders", Icons.receipt_long_outlined, 3,
  //     AppRoutes.order_history),
  NavigatorItem(
      "Account",Icons.people_alt_outlined, 4, AppRoutes.account),
];
