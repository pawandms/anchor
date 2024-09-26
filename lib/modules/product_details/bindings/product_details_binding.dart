import 'package:get/get.dart';

import '../controllers/product_details_controller.dart';

class ProductDetailsBinding extends Bindings {
  /*@override
  List<Bind> dependencies() {
    return [
      Bind.create<ProductDetailsController>(
        () => ProductDetailsController(
          Get.parameters['productId'] ?? '',
        ),
      )
    ];
  }*/

  @override
  void dependencies() {
    Get.lazyPut(() => ProductDetailsController( Get.parameters['productId'] ?? '',));
  }
}
