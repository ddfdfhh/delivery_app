import 'dart:math';

import 'package:delivery/controllers/RealLocationController.dart';
import 'package:delivery/controllers/order_controller.dart';
import 'package:delivery/screens/rela_location_update.dart';
import 'package:delivery/widgets/button.dart';
import 'package:delivery/widgets/expansion.dart';
import 'package:delivery/widgets/order_item.dart';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
// import 'package:mapmyindia_gl/mapmyindia_gl.dart';
import 'package:latlong2/latlong.dart';

Future<void> DeliveryConfirmationDialog(int order_id,String otp,String status) {
  OrderController oc = Get.put(OrderController());
  return showModalBottomSheet(isScrollControlled: true,
     enableDrag: true,
      useSafeArea: true,
      //Don't close dialog when click outside
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      context: Get.context as BuildContext,
      builder: (BuildContext ctx) {
        return Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(ctx).viewInsets.bottom),
          child: Container(height:200,
              decoration: BoxDecoration(
                borderRadius:
                BorderRadius.vertical(top: Radius.circular(25.0)),
              ),
              padding: EdgeInsets.all(50),
              child: Column(
                children: [
                  TextFormField(
                    controller: oc.orderOtpController,
                    validator: (val) {
                      // return lc!.validatePhone();
                    },
                    //maxLength: 10,
                    maxLines: 2,
                    minLines: 1,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      //labelText: "Phone number",
                        hintText: "Enter Customer OTP",
                        contentPadding: EdgeInsets.all(
                            5), //  <- you can it to 0.0 for no space
                        isDense: true,
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.purple))
                      //border: InputBorder.none
                    ),
                  ),
                  SizedBox(height:20),
                  Center(
                    child: SizedBox(height:40,width:100,
                      child: DefaultButton(ctx, 'Submit', (){
                        if(status=='Delivered')
                        oc.confirmOrderDelivery(order_id,otp);
                        else
                          oc.cancelOrder(order_id,otp);
                      },null),
                    ),
                  )
                ],
              )),
        );
      }).whenComplete(() {
    print('shahi closed');
  });
}
