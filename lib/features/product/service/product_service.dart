
import '../model/product_model.dart';
import '../../../core/network/api_client.dart';

class ProductService {
static const String baseUrl = 'https://api.escuelajs.co/api/v1';
final BaseApiClient _apiClient = BaseApiClient();

Future<List<ProductModel>> getProducts() async {
final response = await _apiClient.get(endPoint: '$baseUrl/products');
return (response as List).map((json) => ProductModel.fromJson(json)).toList();
}
}