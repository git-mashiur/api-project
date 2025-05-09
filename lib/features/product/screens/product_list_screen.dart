
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controller/product_controller.dart';
import '../model/product_model.dart';
import '../../../core/routes/app_routes.dart';

class ProductListScreen extends StatelessWidget {
final ProductController productController = Get.find();
final int categoryId = Get.arguments['categoryId'];
final String categoryName = Get.arguments['categoryName'];

ProductListScreen({super.key});

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: Text(categoryName, style: TextStyle(fontSize: 20.sp, color: Colors.white)),
backgroundColor: Colors.teal,
elevation: 0,
),
body: Obx(() {
if (productController.isLoading.value) return const Center(child: CircularProgressIndicator());
if (productController.errorMessage.isNotEmpty) return Center(child: Text(productController.errorMessage.value, style: TextStyle(fontSize: 14.sp)));
if (productController.categoryProducts.isEmpty) return Center(child: Text('No products found', style: TextStyle(fontSize: 14.sp)));
return GridView.builder(
padding: EdgeInsets.all(16.w),
gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
crossAxisCount: 2,
crossAxisSpacing: 10.w,
mainAxisSpacing: 10.h,
childAspectRatio: 0.75,
),
itemCount: productController.categoryProducts.length,
itemBuilder: (context, index) {
return _buildProductCard(productController.categoryProducts[index]);
},
);
}),
);
}

Widget _buildProductCard(ProductModel product) {
return GestureDetector(
onTap: () {
print('Navigating to Product Detail from ProductList with product: ${product.title}');
Get.toNamed(AppRoutes.productDetail, arguments: product);
},
child: Card(
elevation: 4,
shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Expanded(
child: ClipRRect(
borderRadius: BorderRadius.only(
topLeft: Radius.circular(12.r),
topRight: Radius.circular(12.r),
),
child: Image.network(
product.images?.first ?? '',
width: double.infinity,
fit: BoxFit.cover,
errorBuilder: (context, error, stackTrace) {
print('Product Image Load Error: $error for ${product.images?.first}');
return Container(
width: double.infinity,
color: Colors.grey[300],
child: Icon(
Icons.broken_image,
size: 50.sp,
color: Colors.grey,
),
);
},
),
),
),
Padding(
padding: EdgeInsets.all(8.w),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
product.title ?? '',
style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.black87),
maxLines: 2,
overflow: TextOverflow.ellipsis,
),
SizedBox(height: 4.h),
Text(
'\$${product.price ?? 0}',
style: TextStyle(fontSize: 14.sp, color: Colors.teal, fontWeight: FontWeight.bold),
),
SizedBox(height: 4.h),
Text(
'Category: ${product.category?.name ?? ''}',
style: TextStyle(fontSize: 12.sp, color: Colors.grey),
),
],
),
),
],
),
),
);
}
}