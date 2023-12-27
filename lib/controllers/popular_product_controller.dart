import 'package:ecommerce_flutter/controllers/cart_controller.dart';
import 'package:ecommerce_flutter/data/repository/popular_product_repo.dart';
import 'package:ecommerce_flutter/model/product_model.dart';
import 'package:ecommerce_flutter/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;

  PopularProductController({required this.popularProductRepo});
  late CartController _cartController;

  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity = 1;
  int get quantity => _quantity;

  int _inCartItems = 0;
  int get inCartItems => _inCartItems = _quantity;

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

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity++;
    } else {
      if (_quantity > 0) {
        _quantity--;
      }
      else{
        Get.snackbar("Item Count", "You can reduce more than 0",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white);
      }
    }

    update();
  }

  void initProduct(CartController cartController){
    _quantity = 0;
    _inCartItems = 0;
    _cartController = cartController;

    //get from storage
  }

  void addItem(ProductModel product){
    _cartController.addItems(product, _quantity);
  }
}
