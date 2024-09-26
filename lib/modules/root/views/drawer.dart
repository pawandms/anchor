import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/authentication_manager.dart';
import '../../../routes/app_pages.dart';

class DrawerWidget extends StatelessWidget {

  final AuthenticationManager _authmanager = Get.find();


  /*
  const DrawerWidget({
    Key? key,
  }) : super(key: key);
   */
  DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 100,
            color: Colors.red,
          ),
          ListTile(
            title: Text('Home'),
            onTap: () {
              Get.rootDelegate.toNamed(Routes.HOME);
              //to close the drawer

              Navigator.of(context).pop();
            },
          ),
          ListTile(
            title: Text('Settings'),
            onTap: () {
              Get.rootDelegate.toNamed(Routes.SETTINGS);
              //to close the drawer

              Navigator.of(context).pop();
            },
          ),

          if (_authmanager.isLoggedInValue)
            ListTile(
              title: Text(
                'Logout',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              onTap: () {
                _authmanager.logOut();
                Get.rootDelegate.toNamed(Routes.AUTH_SCREEN);
                //to close the drawer

                Navigator.of(context).pop();
              },
            ),
          if (!_authmanager.isLoggedInValue)
            ListTile(
              title: Text(
                'Login',
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
              onTap: () {
                Get.rootDelegate.toNamed(Routes.LOGIN);
                //to close the drawer

                Navigator.of(context).pop();
              },
            ),


        ],
      ),
    );
  }


}
