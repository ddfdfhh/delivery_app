import 'dart:math';

import 'package:delivery/controllers/RealLocationController.dart';
import 'package:delivery/controllers/order_controller.dart';
import 'package:delivery/screens/rela_location_update.dart';
import 'package:delivery/widgets/expansion.dart';
import 'package:delivery/widgets/order_item.dart';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
// import 'package:mapmyindia_gl/mapmyindia_gl.dart';
import 'package:latlong2/latlong.dart';

Future<void> LocationDialog(Map<String,dynamic> user) {
  OrderController oc = Get.find();
  return showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      //Don't close dialog when click outside
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      context: Get.context as BuildContext,
      builder: (BuildContext ctx) {
        return user == null
              ? const Align(child: const CircularProgressIndicator())
              : Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(25.0)),
                  ),
                  height: MediaQuery.of(ctx).size.height * .95,
                  child: Loc(user:user));
      }).whenComplete(() {
    print('shahi closed');
  });
}
