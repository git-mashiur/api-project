
import '../model/category_model.dart';
import '../../../core/network/api_client.dart';

class CategoryService {
static const String baseUrl = 'https://api.escuelajs.co/api/v1';
final BaseApiClient _apiClient = BaseApiClient();

Future<List<CategoryModel>> getCategories() async {
final response = await _apiClient.get(endPoint: '$baseUrl/categories');
return (response as List).map((json) => CategoryModel.fromJson(json)).toList();
}
}