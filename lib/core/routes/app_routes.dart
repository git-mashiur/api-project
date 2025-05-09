
import 'package:get/get.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/product/screens/product_detail_screen.dart';
import '../../features/product/screens/product_list_screen.dart';

class AppRoutes {
static const String home = '/home';
static const String productList = '/product-list';
static const String productDetail = '/product-detail';

static final routes = [
GetPage(name: home, page: () => HomeScreen()),
GetPage(name: productList, page: () => ProductListScreen()),
GetPage(name: productDetail, page: () => ProductDetailScreen()),
];
}