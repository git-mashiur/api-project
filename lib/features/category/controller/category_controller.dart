
import 'package:get/get.dart';
import '../model/category_model.dart';
import '../service/category_service.dart';

class CategoryController extends GetxController {
var categories = <CategoryModel>[].obs;
var isLoading = false.obs;
var errorMessage = ''.obs;

final CategoryService _categoryService = CategoryService();

@override
void onInit() {
fetchCategories();
super.onInit();
}

Future<void> fetchCategories() async {
try {
isLoading(true);
errorMessage('');
final response = await _categoryService.getCategories();
categories.assignAll(response);
} catch (e) {
errorMessage('Failed to load categories: $e');
} finally {
isLoading(false);
}
}
}
