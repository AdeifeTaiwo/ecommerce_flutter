import 'package:ecommerce_flutter/data/repository/popular_product_repo.dart';
import 'package:ecommerce_flutter/data/repository/recommended_product_repo.dart';
import 'package:ecommerce_flutter/model/product_model.dart';
import 'package:get/get.dart';

class RecommendedProductController extends GetxController {
  final RecommendedProductRepo recommendedProductRepo;

  RecommendedProductController({required this.recommendedProductRepo});

  List<dynamic> _recommendedProductList = [];

  List<dynamic> get recommendedProductList => _recommendedProductList;

  bool _isLoaded = false;

  bool get isLoaded => _isLoaded;

  int _quantity = 0;
  int get quantity => _quantity;

  Future<void> getRecommendedProductList() async {
    Response response =
        await recommendedProductRepo.getRecommendedProductList();
    if (response.statusCode == 200) {
      print(response.body.toString());
      _recommendedProductList = [];
      _recommendedProductList
          .addAll(Product.fromJson(response.body).products as List);
      _isLoaded = true;
      update(); // data has been updated and we want to update the ui
    } else {
      print("could not get recommended products");
    }
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity++;
    } else {
      if (_quantity > 0) {
        _quantity--;
      }
    }
    update();
  }
}
