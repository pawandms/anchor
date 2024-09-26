
import 'package:anchor_getx/core/app_export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../core/utils/image_constant.dart';
import '../../../routes/app_pages.dart';
import '../../../theme/theme_helper.dart';

class HomeNavigationBar extends StatelessWidget{

  RxInt selectedIndex;

  HomeNavigationBar({
    Key? key,
    required this.selectedIndex,
  //  this.onChanged,
  }) : super(
    key: key,
    //this.selectedIndex.value = selectedIndex;
  );

  //Function(NavBarEnum)? onChanged;
  //RxInt selectedIndex = 0.obs;

  List<NavBarMenuModel> bottomMenuList = [
    NavBarMenuModel(
      icon: Icon(Icons.home),
      tooltip: "lbl_home".tr,
      type: NavBarEnum.Home,
    ),
    NavBarMenuModel(
      icon: Icon(Icons.chat),
      tooltip: "lbl_messages".tr,
      type: NavBarEnum.Messages,
    ),
    NavBarMenuModel(
      icon: Icon(Icons.search),
      tooltip: "lbl_search".tr,
      type: NavBarEnum.Search,
    ),
   NavBarMenuModel(
      icon: Icon(Icons.person),
      tooltip: "lbl_profile".tr,
      type: NavBarEnum.Profile,

    ),
    NavBarMenuModel(
      icon: Icon(Icons.notification_add),
      tooltip: "lbl_notifications".tr,
      type: NavBarEnum.Notifications,
    ),

  ];


  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 80.v,
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12.h),
        ),
        boxShadow: [
          BoxShadow(
            color: appTheme.deepPurpleA200.withOpacity(0.2),
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(
              0,
              -3,
            ),
          ),
        ],
      ),
      child: Obx(
            () =>
               // getBottomNavigationBar()
         BottomNavigationBar(
          backgroundColor: Colors.transparent,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedFontSize: 0,
          elevation: 0,
          currentIndex: selectedIndex.value,
          selectedItemColor: Colors.blue,
          type: BottomNavigationBarType.fixed,
          items: List.generate(bottomMenuList.length, (index) {
            return BottomNavigationBarItem(
              tooltip: bottomMenuList[index].tooltip ?? "",
              icon:  bottomMenuList[index].icon,
              label: '',
            );
          }),
          onTap: (index) {
            selectedIndex.value = index;
            NavBarEnum type =  bottomMenuList[index].type;
            _changeCurrentRoute(type);
            //onChanged?.call(bottomMenuList[index].type);
          },
        ),

      ),
    );
  }

  void _changeCurrentRoute(NavBarEnum type) {
    print("Current Route After change is :$type");
    switch (type) {
      case NavBarEnum.Home:
        Get.rootDelegate.toNamed(Routes.HOME);
        //delegate.toNamed(Routes.HOME);
        break;

      case NavBarEnum.Messages:
        Get.rootDelegate.toNamed(Routes.MESSAGES);
        //delegate.toNamed(Routes.HOME);
        break;
      case NavBarEnum.Profile:
        Get.rootDelegate.toNamed(Routes.PROFILE);
        //delegate.toNamed(Routes.PROFILE);
        break;
      case NavBarEnum.Products:
        Get.rootDelegate.toNamed(Routes.PRODUCTS);
        //delegate.toNamed(Routes.PRODUCTS);
        break;

      case NavBarEnum.Notifications:
        Get.rootDelegate.toNamed(Routes.NOTIFICATION);
        // delegate.toNamed(Routes.NOTIFICATION);
        break;
      case NavBarEnum.Search:
        Get.rootDelegate.toNamed(Routes.SEARCH);
        break;

      default:
        Get.rootDelegate.toNamed(Routes.HOME);
    //delegate.toNamed(Routes.HOME);
    }

  }


  Widget getBottomNavigationBar()
  {
  return   BottomNavigationBar(
  items: const <BottomNavigationBarItem>[
  BottomNavigationBarItem(
  icon: Icon(Icons.home),
    label: 'Home',
    ),
    BottomNavigationBarItem(
    icon: Icon(Icons.business),
    label: 'Business',
  ),
  BottomNavigationBarItem(
  icon: Icon(Icons.school),
  label: 'School',
  ),
  ],
  currentIndex: selectedIndex.value,
  selectedItemColor: Colors.amber[800],
    onTap: _onItemTapped,
    );
  }

  void _onItemTapped(int index) {
    selectedIndex.value = index;
    NavBarEnum type =  bottomMenuList[index].type;
    _changeCurrentRoute(type);
  }
}

enum NavBarEnum {
  Home,
  Streams,
  Messages,
  Notifications,
  Profile,
  Products,
  Search,

}
enum NavBarIconEnum {
  String,
  Icon,

}

class NavBarMenuModel {
  NavBarMenuModel({
    required this.icon,
    this.title,
    this.tooltip,
    required this.type,

  });

  Widget icon;
  String? title;
  String? tooltip;
  NavBarEnum type;

}