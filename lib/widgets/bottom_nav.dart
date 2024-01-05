
import 'package:delivery/constants.dart';
import 'package:delivery/routes.dart';
import 'package:delivery/service/user_service.dart';
import 'package:delivery/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:delivery/theme.dart';

class BottomNavBar extends StatefulWidget {

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  int currentIndex = 0;
  String? currentPath;
  @override
  Widget build(BuildContext context) {
    UserService us=Get.find();
    currentPath=Get.currentRoute;
    currentIndex=us.currentIndex;

    return Container(
      decoration: BoxDecoration(
        color:Colors.lightGreen,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(25),
          topLeft: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
              color: Colors.grey,
              spreadRadius: 0,
              blurRadius: 30,
              offset: Offset(0, 7)),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: currentIndex,
          onTap: (i) {
            setState(() {
              currentIndex = i;
            });
            us.currentIndex=i;
            if (i == 0) {
              Get.offNamed(AppRoutes.dashboard);
            }

            if (i == 4) {
              Get.toNamed(AppRoutes.account);
            }
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppTheme(context: context).colors['primary'],
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.w500),
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w500),
          unselectedItemColor: Colors.black,
          items: navigatorItems.map((e) {
            return getNavigationBarItem(
                label: e.label, index: e.index, iconPath: e.iconPath,path:e.path,userService:us);
          }).toList(),
        ),
      ),
    );
  }

  BottomNavigationBarItem getNavigationBarItem(

      {required String label,required int index, required IconData iconPath,required String path,required UserService userService}) {
    Color iconColor = userService.currentIndex == index ?
    AppTheme(context: context).colors['primary'] : Colors.grey.shade600;
    return BottomNavigationBarItem(
      label: label,
      icon: Icon(iconPath,color:iconColor,size: 20)

    );
  }
}
