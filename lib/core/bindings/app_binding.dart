
import 'package:get/get.dart';
import '../../features/category/controller/category_controller.dart';
import '../../features/product/controller/product_controller.dart';

class AppBinding extends Bindings {
@override
void dependencies() {
Get.lazyPut<CategoryController>(() => CategoryController());
Get.lazyPut<ProductController>(() => ProductController());
}
}