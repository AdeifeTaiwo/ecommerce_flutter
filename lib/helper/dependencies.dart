import 'package:ecommerce_flutter/controllers/popular_product_controller.dart';
import 'package:ecommerce_flutter/controllers/recommended_product_controller.dart';
import 'package:ecommerce_flutter/data/api/api_client.dart';
import 'package:ecommerce_flutter/data/repository/popular_product_repo.dart';
import 'package:ecommerce_flutter/data/repository/recommended_product_repo.dart';
import 'package:ecommerce_flutter/utils/app_constants.dart';
import 'package:get/get.dart';

Future<void> init() async {
  //api client
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));


  //repositories
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(()  => RecommendedProductRepo(apiClient: Get.find()));


  //controllers
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(() => RecommendedProductController(recommendedProductRepo: Get.find()));


}
