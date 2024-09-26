import 'package:anchor_getx/core/app_export.dart';
import 'package:anchor_getx/presentation/search_screen/models/search_model.dart';
import 'package:flutter/material.dart';

import '../models/contact_item_model.dart';
import '../models/recentsearches_item_model.dart';

/// A controller class for the SearchScreen.
///
/// This class manages the state of the SearchScreen, including the
/// current searchModelObj
class SearchController extends GetxController {
  TextEditingController searchController = TextEditingController();
  Rx<SearchModel> searchModelObj = SearchModel().obs;
  List<ContactItemModel> orgList = [];
  RxList<ContactItemModel> recentsearchesItemList = RxList<ContactItemModel>();

  @override
  void onInit() {
    orgList = searchModelObj.value.contactList;
    recentsearchesItemList.value = orgList;
  }

  @override
  void onClose() {
    super.onClose();
    searchController.dispose();
  }

  void searchString(String searchString)
  {
    if(searchString.isEmpty)
     {
       recentsearchesItemList.value = orgList;
     }
    else if((searchString.isNotEmpty) && (searchString.length >= 2))
    {
    recentsearchesItemList.value =  orgList.where((element) => element.kevinAllsrub1.isCaseInsensitiveContains(searchString)).toList();
    print('Searching for Value:$searchString , With Result Count:'+recentsearchesItemList.value.length.toString());
    }

  }


}
