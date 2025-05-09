
import 'package:get/get.dart';
import '../model/product_model.dart';
import '../service/product_service.dart';

class ProductController extends GetxController {
var products = <ProductModel>[].obs;
var categoryProducts = <ProductModel>[].obs;
var isLoading = false.obs;
var errorMessage = ''.obs;

final ProductService _productService = ProductService();

@override
void onInit() {
fetchProducts();
super.onInit();
}

Future<void> fetchProducts() async {
try {
isLoading(true);
errorMessage('');
final response = await _productService.getProducts();
products.assignAll(response);
} catch (e) {
errorMessage('Failed to load products: $e');
} finally {
isLoading(false);
}
}

Future<List<ProductModel>> getProductByCategory({required int categoryId}) async {
try {
isLoading(true);
errorMessage('');
final products = await ProductModel.getProductByCategory(categoryId: categoryId);
categoryProducts.assignAll(products);
return categoryProducts;
} catch (e) {
errorMessage('Failed to load products: $e');
return [];
} finally {
isLoading(false);
}
}
}