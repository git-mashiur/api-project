
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'core/bindings/app_binding.dart';
import 'core/routes/app_routes.dart';

void main() {
runApp(const MyApp());
}

class MyApp extends StatelessWidget {
const MyApp({super.key});

@override
Widget build(BuildContext context) {
return ScreenUtilInit(
designSize: const Size(375, 942),
minTextAdapt: true,
splitScreenMode: true,
ensureScreenSize: true,
builder: (context, child) {
return GetMaterialApp(
title: 'E-commerce App',
initialRoute: AppRoutes.home,
getPages: AppRoutes.routes,
initialBinding: AppBinding(),
theme: ThemeData(primarySwatch: Colors.blue),
);
},
);
}
}
