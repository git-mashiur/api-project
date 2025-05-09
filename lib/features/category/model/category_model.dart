
class CategoryModel {
int? id;
String? name;
String? slug;
String? image;
String? creationAt;
String? updatedAt;

CategoryModel({this.id, this.name, this.slug, this.image, this.creationAt, this.updatedAt});

CategoryModel.fromJson(Map<String, dynamic> json) {
id = json['id'];
name = json['name'] ?? 'Unknown Category'; // Fallback for null name
slug = json['slug'];
image = json['image'] is String ? json['image'] : null; // Ensure image is a valid string
creationAt = json['creationAt'];
updatedAt = json['updatedAt'];
}

Map<String, dynamic> toJson() {
final Map<String, dynamic> data = {};
data['id'] = id;
data['name'] = name;
data['slug'] = slug;
data['image'] = image;
data['creationAt'] = creationAt;
data['updatedAt'] = updatedAt;
return data;
}
}