import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/root_controller.dart';
import 'drawer.dart';

class RootView extends GetView<RootController> {



  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(
      builder: (context, delegate, current) {
        final title = current?.uri;
        var effectiveTitle = current?.currentPage?.title;
        if (effectiveTitle != null) {
          effectiveTitle = '(GetPage.effectiveTitle: $effectiveTitle)';
        } else {
          effectiveTitle = '';
        }

        return Scaffold(
          drawer: DrawerWidget(),
         /*
          appBar: AppBar(
            title: Text(
              '$title $effectiveTitle',
            ),
            centerTitle: true,
          ),

          */
          body: GetRouterOutlet(

           // initialRoute: Routes.HOME,
            initialRoute: controller.initalRoute,
            // anchorRoute: '/',
            // filterPages: (afterAnchor) {
            //   return afterAnchor.take(1);
            // },
          ),
        );
      },
    );
  }
}
