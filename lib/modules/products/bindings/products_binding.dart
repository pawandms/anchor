import 'package:get/get.dart';

import '../controllers/products_controller.dart';

class ProductsBinding extends Bindings {
  /*@override
  List<Bind> dependencies() {
    return [
      Bind.lazyPut<ProductsController>(
        () => ProductsController(),
      )
    ];
  }*/

  @override
  void dependencies() {
    Get.lazyPut(() => ProductsController());
  }
}
