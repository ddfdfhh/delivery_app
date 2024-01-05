import 'package:delivery/theme.dart';
import 'package:delivery/util.dart';
import 'package:flutter/material.dart';

Widget f(int step, StepState state) {
  return Icon(Icons.check_circle);
}

Widget TimeLineW(
    BuildContext context, List<Map<String, dynamic>> order_statuses) {
  List<String> real_keys = [];
  List<String> fake_keys = [];
  order_statuses.forEach((element) {
    real_keys.add(element['name']);
  });
  List<Map<String, dynamic>> new_order_statuses = [...order_statuses];
  print('here order st');

  if (order_statuses.length == 1) {
    List<Map<String, dynamic>> add = [
      {'name': 'Out For Delivery', 'date': null, 'message': ''},
      {'name': 'Delivered', 'date': null, 'message': ''}
    ];
    new_order_statuses.addAll(add);
  }
  if (order_statuses.length == 2) {
    List<Map<String, dynamic>> add = [
      {'name': 'Delivered', 'date': null, 'message': ''}
    ];
    new_order_statuses.addAll(add);
  }
  new_order_statuses.forEach((element) {
    fake_keys.add(element['name']);
  });

  return Stepper(
      controlsBuilder: (context, controller) {
        return const SizedBox.shrink();
      },
      onStepTapped: (step) {},
      currentStep: order_statuses.length - 1,
      steps: List.generate(new_order_statuses.length, (index) {
        String name = new_order_statuses[index]['name'] == 'Pending'
            ? 'Order Placed'
            : new_order_statuses[index]['name'];
        bool isActive = real_keys.contains(fake_keys[index]);
        return Step(
          state: name != 'Cancelled' ? StepState.complete : StepState.error,
          isActive: isActive,
          title: Text('${name}',
              style: !isActive
                  ? AppTheme(context: context)
                      .textTheme['light']
                  : (name != 'Cancelled'
                      ? AppTheme(context: context)
                          .textTheme['bodyLargeBoldColor']
                      : AppTheme(context: context)
                          .textTheme['titleMediumBoldRed'])),
          subtitle: new_order_statuses[index]['date'] != null
              ? Text('${formatDateTime(new_order_statuses[index]['date']!)}',
                  style: AppTheme(context: context).textTheme['bodySmall'])
              : Text(''),
          content: Container(
              alignment: Alignment.centerLeft,
              child: new_order_statuses[index]['message']!=null && !new_order_statuses[index]['message'].isEmpty
                  ? Card(
                      child: Container(
                          // color: Colors.orange.shade50,
                          padding: EdgeInsets.all(10),
                          child: Text(
                              '${toUpperCase(new_order_statuses[index]['message'])}',
                              style: AppTheme(context: context)
                                  .textTheme['titleMediumBlack'])),
                    )
                  : SizedBox.shrink()),
        );
      }));
}
