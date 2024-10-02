import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _generateAppBar(),
      body: Center(
        child: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SelectableText(
                'DashboardView is working',
                style: TextStyle(fontSize: 20, color: Colors.blue),
              ),
              SelectableText('Time: ${controller.now.value.toString()}'),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _generateAppBar()
  {
    return AppBar(
      title: Text("Popup Menu on AppBar"),
      backgroundColor: Colors.redAccent,
      actions: [

        PopupMenuButton(
          // add icon, by default "3 dot" icon
          // icon: Icon(Icons.book)
            itemBuilder: (context){
              return [
                PopupMenuItem<int>(
                  value: 0,
                  child: Text("My Account"),
                ),

                PopupMenuItem<int>(
                  value: 1,
                  child: Text("Settings"),
                ),

                PopupMenuItem<int>(
                  value: 2,
                  child: Text("Logout"),
                ),
              ];
            },
            onSelected:(value){
              if(value == 0){
                print("My account menu is selected.");
              }else if(value == 1){
                print("Settings menu is selected.");
              }else if(value == 2){
                print("Logout menu is selected.");
              }
            }
        ),

      ],
    );
  }
}
