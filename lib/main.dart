import 'package:ecommerce_flutter/controllers/popular_product_controller.dart';
import 'package:ecommerce_flutter/controllers/recommended_product_controller.dart';
import 'package:ecommerce_flutter/pages/detail/recommended_food_detail.dart';
import 'package:ecommerce_flutter/pages/home/food_body_page.dart';
import 'package:ecommerce_flutter/pages/home/main_food_page.dart';
import 'package:ecommerce_flutter/route/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'helper/dependencies.dart' as dep;

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized(); //ensure dependences is initialized
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<PopularProductController>().getPopularProductList();
    Get.find<RecommendedProductController>().getRecommendedProductList();
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  MainFoodPage(),
      initialRoute: RouteHelper.initial,
      getPages: RouteHelper.routes,
    );
  }
}
