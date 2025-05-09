
import '../../category/model/category_model.dart';
import '../../../core/network/api_client.dart';

class ProductModel {
int? id;
String? title;
String? slug;
int? price;
String? description;
CategoryModel? category;
List<String>? images;
String? creationAt;
String? updatedAt;

ProductModel({
this.id,
this.title,
this.slug,
this.price,
this.description,
this.category,
this.images,
this.creationAt,
this.updatedAt,
});

factory ProductModel.fromJson(dynamic json) {
if (json is List) {
return ProductModel(); // Placeholder, we'll handle lists separately
} else if (json is Map<String, dynamic>) {
return ProductModel(
id: json['id'],
title: json['title'],
slug: json['slug'],
price: json['price'],
description: json['description'],
category: json['category'] != null ? CategoryModel.fromJson(json['category']) : null,
images: json['images']?.cast<String>(),
creationAt: json['creationAt'],
updatedAt: json['updatedAt'],
);
}
throw ArgumentError('Invalid JSON data');
}

static List<ProductModel> fromJsonList(dynamic json) {
if (json is List) {
return json.map((item) => ProductModel.fromJson(item)).toList().cast<ProductModel>();
}
throw ArgumentError('Expected a list of JSON objects');
}

Map<String, dynamic> toJson() {
final Map<String, dynamic> data = {};
data['id'] = id;
data['title'] = title;
data['slug'] = slug;
data['price'] = price;
data['description'] = description;
if (category != null) {
data['category'] = category!.toJson();
}
data['images'] = images;
data['creationAt'] = creationAt;
data['updatedAt'] = updatedAt;
return data;
}

static List<ProductModel> productList = [];
static Future<List<ProductModel>> getProductByCategory({required int categoryId}) async {
try {
productList.clear();
var response = await BaseApiClient().get(
endPoint: 'https://api.escuelajs.co/api/v1/categories/$categoryId/products');
productList.addAll(ProductModel.fromJsonList(response));
return productList;
} catch (e) {
print('Error fetching products: $e');
return [];
}
}
}