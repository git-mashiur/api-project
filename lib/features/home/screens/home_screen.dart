import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../category/controller/category_controller.dart';
import '../../product/controller/product_controller.dart';
import '../../product/model/product_model.dart';
import '../../../core/routes/app_routes.dart';

class HomeScreen extends StatelessWidget {
  final CategoryController categoryController = Get.find();
  final ProductController productController = Get.find();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ShopEasy',
            style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding:
              EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.r),
                  bottomRight: Radius.circular(20.r),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Categories',
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  SizedBox(height: 8.h),
                  _buildCategoryList(),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Featured Products',
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal)),
                  SizedBox(height: 8.h),
                  _buildProductList(),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryList() {
    return Obx(() {
      if (categoryController.isLoading.value)
        return Center(
            child: CircularProgressIndicator(color: Colors.white));
      if (categoryController.errorMessage.isNotEmpty)
        return Center(
            child: Text(categoryController.errorMessage.value,
                style: TextStyle(fontSize: 14.sp, color: Colors.white)));

      return SizedBox(
        height: 120.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.only(right: 16.w),
          itemCount: categoryController.categories.length,
          itemBuilder: (context, index) {
            final category = categoryController.categories[index];
            return Padding(
              padding: EdgeInsets.only(left: 8.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () async {
                      await productController.getProductByCategory(
                          categoryId: category.id!);
                      Get.toNamed(AppRoutes.productList, arguments: {
                        'categoryId': category.id,
                        'categoryName': category.name
                      });
                    },
                    child: CircleAvatar(
                      radius: 30.r,
                      backgroundColor: Colors.white,
                      child: ClipOval(
                        child: Image.network(
                          category.image ?? '',
                          width: 60.w,
                          height: 60.h,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.broken_image,
                                size: 30.sp, color: Colors.grey);
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  SizedBox(
                    width: 80.w,
                    child: Text(
                      category.name ?? 'Unnamed',
                      style:
                      TextStyle(fontSize: 12.sp, color: Colors.white),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    });
  }

  Widget _buildProductList() {
    return Obx(() {
      if (productController.isLoading.value)
        return Center(child: CircularProgressIndicator());
      if (productController.errorMessage.isNotEmpty)
        return Center(
            child: Text(productController.errorMessage.value,
                style: TextStyle(fontSize: 14.sp)));

      return GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.w,
          mainAxisSpacing: 10.h,
          childAspectRatio: 0.75,
        ),
        itemCount: productController.products.length,
        itemBuilder: (context, index) {
          final product = productController.products[index];
          return _buildProductCard(product);
        },
      );
    });
  }

  Widget _buildProductCard(ProductModel product) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.productDetail, arguments: product);
      },
      child: Card(
        elevation: 4,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
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
                    return Container(
                      width: double.infinity,
                      color: Colors.grey[300],
                      child: Icon(Icons.broken_image,
                          size: 50.sp, color: Colors.grey),
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
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '\$${product.price ?? 0}',
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.teal,
                        fontWeight: FontWeight.bold),
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
