import 'package:cached_network_image/cached_network_image.dart';

import 'package:delivery/constants.dart';
import 'package:delivery/theme.dart';
import 'package:delivery/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'imageWidget.dart';

class OrderItemWidget extends StatefulWidget {
  OrderItemWidget({Key? key, required this.item}) : super(key: key);
  final Map<String, dynamic> item;

  @override
  _OrderItemWidgetState createState() => _OrderItemWidgetState();
}

class _OrderItemWidgetState extends State<OrderItemWidget> {
  final double height = 110;

  final Color borderColor = Color(0xffE2E2E2);

  final double borderRadius = 18;

  int amount = 1;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> item = widget.item;

    return Card(
      child: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListTile(splashColor: Colors.transparent,hoverColor: Colors.transparent,contentPadding: EdgeInsets.all(15),
            leading: imageWidget(context,item),
            title: Text('${toUpperCase(item['name'])}', style: AppTheme(context: context).textTheme['bodySmallBold']),
            trailing: Text('${currency} ${item['net_cart_amount']}',
                style:
                TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (item['variant_name'] != null)
                    Text('${item['variant_name']}'),
                  Text('Purchased qty-${item['qty']}',style:AppTheme(context: context).textTheme['bodyMediumLight']),
                  if (item['returned_qty']>0)
                    Text('Returned qty-${item['returned_qty']}',style:AppTheme(context: context).textTheme['bodyMediumBold']),
                ]),
            selected: true,
            onTap: () {},
          ),

        ],
      ),
    );
  }

  Widget imageWidget(BuildContext context,Map<String, dynamic> item) {
    var imageUrl = item['image'];
    return Container(
      width: 50,
      child: imageUrl != null
          ? CachedImageWidget(context,imageUrl,null,null,null)
          : Image.asset('${assetUrl(context)}/no-image.jpg'),
    );
  }
}
