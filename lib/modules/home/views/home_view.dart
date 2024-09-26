import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import '../../../core/utils/image_constant.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/custom_bottom_bar.dart';
import '../controllers/home_controller.dart';
import 'home_navigration_bar.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(
      builder: (context, delegate, currentRoute) {
        //This router outlet handles the appbar and the bottom navigation bar
        final currentLocation = currentRoute?.locationString;
        //var currentIndex = 0;
        var currentIndex = _getCurrentIndex(currentLocation!);
        return Scaffold(
        //  appBar: _generateAppBar(),
          body: GetRouterOutlet(
            initialRoute: Routes.DASHBOARD,
            // anchorRoute: Routes.HOME,
            key: Get.nestedKey(Routes.HOME),
          ),
          bottomNavigationBar: _buildBottomBar(currentIndex),
          /*
          BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (value) {
              switch (value) {
                case 0:
                  delegate.toNamed(Routes.HOME);
                  break;
                case 1:
                  delegate.toNamed(Routes.PROFILE);
                  break;
                case 2:
                  delegate.toNamed(Routes.PRODUCTS);
                  break;
                case 3:
                  delegate.toNamed(Routes.NOTIFICATION);
                  break;
                default:
              }
            },
            items: [
              // _Paths.HOME + [Empty]
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              // _Paths.HOME + Routes.PROFILE
              BottomNavigationBarItem(
                icon: Icon(Icons.account_box_rounded),
                label: 'Profile',
              ),
              // _Paths.HOME + _Paths.PRODUCTS
              BottomNavigationBarItem(
                icon: Icon(Icons.account_box_rounded),
                label: 'Products',
              ),

              BottomNavigationBarItem(
                icon: Icon(Icons.notification_add_outlined),
                label: "lbl_notifications".tr,
              ),

            ],
          ),
          */
        );
      },
    );
  }



  int _getCurrentIndex(String currentLocation)
  {
    int result = 0;
    try{
      if(( null != currentLocation) && (currentLocation.isNotEmpty))
        {
          if (currentLocation?.startsWith(Routes.MESSAGES) == true) {
            result = 1;
          }
          else if (currentLocation?.startsWith(Routes.SEARCH) == true) {
            result = 2;
          }
          else if (currentLocation?.startsWith(Routes.PROFILE) == true) {
            result = 3;
          }
          else if (currentLocation?.startsWith(Routes.NOTIFICATION) == true) {
            result = 4;
          }
        }

    }
    catch(e)
    {
      logError("SignIn Error:$e");
    }


    return result;
  }

  Widget _buildBottomBar(int selectedIndex) {
    //return HomeNavigationBar(onChanged: getCurrentRoute);
    return HomeNavigationBar(selectedIndex: selectedIndex.obs,);
  }

}
