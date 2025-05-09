
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../model/product_model.dart';

class ProductDetailScreen extends StatelessWidget {
final ProductModel product = Get.arguments;

ProductDetailScreen({super.key});

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: Text(product.title ?? '', style: TextStyle(fontSize: 20.sp, color: Colors.white)),
backgroundColor: Colors.teal,
elevation: 0,
),
body: SingleChildScrollView(
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
SizedBox(
height: 250.h,
child: ListView.builder(
scrollDirection: Axis.horizontal,
itemCount: product.images?.length ?? 0,
itemBuilder: (context, index) {
return Container(
margin: EdgeInsets.only(right: 8.w, left: index == 0 ? 16.w : 0),
child: ClipRRect(
borderRadius: BorderRadius.circular(12.r),
child: Image.network(
product.images![index],
width: 300.w,
height: 250.h,
fit: BoxFit.cover,
errorBuilder: (context, error, stackTrace) {
print('Product Detail Image Load Error: $error for ${product.images![index]}');
return Container(
width: 300.w,
height: 250.h,
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
);
},
),
),
Padding(
padding: EdgeInsets.all(16.w),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
product.title ?? '',
style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold, color: Colors.black87),
),
SizedBox(height: 8.h),
Text(
'\$${product.price ?? 0}',
style: TextStyle(fontSize: 20.sp, color: Colors.teal, fontWeight: FontWeight.bold),
),
SizedBox(height: 8.h),
Text(
'Category: ${product.category?.name ?? ''}',
style: TextStyle(fontSize: 16.sp, color: Colors.grey),
),
SizedBox(height: 16.h),
Text(
'Description',
style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.black87),
),
SizedBox(height: 8.h),
Text(
product.description ?? 'No description available.',
style: TextStyle(fontSize: 16.sp, color: Colors.black54),
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