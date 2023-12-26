import 'package:ecommerce_flutter/data/repository/popular_product_repo.dart';
import 'package:ecommerce_flutter/model/product_model.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;

  PopularProductController({required this.popularProductRepo});

  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      print(response.body.toString());
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products as List);
      _isLoaded = true;
      update(); // data has been updated and we want to update the ui
    } else {

    }
  }
}
