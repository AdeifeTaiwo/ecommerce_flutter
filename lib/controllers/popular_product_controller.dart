import 'package:ecommerce_flutter/controllers/cart_controller.dart';
import 'package:ecommerce_flutter/data/repository/popular_product_repo.dart';
import 'package:ecommerce_flutter/model/product_model.dart';
import 'package:ecommerce_flutter/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;

  PopularProductController({required this.popularProductRepo});

  final CartController _cartController = Get.find<CartController>();

  List<dynamic> _popularProductList = [];

  List<dynamic> get popularProductList => _popularProductList;

  bool _isLoaded = false;

  bool get isLoaded => _isLoaded;

  int _quantity = 1;

  int get quantity => _quantity;

  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      print(response.body.toString());
      _popularProductList = [];
      _popularProductList
          .addAll(Product.fromJson(response.body).products as List);
      _isLoaded = true;
      update(); // data has been updated and we want to update the ui
    } else {}
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = initQuantity(_quantity+1);
    } else {
      _quantity = initQuantity(_quantity-1);
    }
    update();
  }

  int initQuantity(int quantity) {
    if ((_inCartItems + quantity) < 0) {
      Get.snackbar("Item Count", "You can reduce more than 0",
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
      return 0;
    } else if ((_inCartItems + quantity) > 20) {
      Get.snackbar("Item Count", "You can't add more!",
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
      return 20;
    } else {
      return quantity;
    }
  }

  void initProduct(ProductModel product) {
    _quantity = 0;
    _inCartItems = 0;
    //get from storage

    var isItemExisting = false;
    isItemExisting = _cartController.existInCart(product);
    if (isItemExisting) {
      _inCartItems = _cartController.getQuantity(product);
    }

    print("exist or not " + isItemExisting.toString());
  }

  void addItem(ProductModel product) {
    if (_quantity > 0) {
      _cartController.addItems(product, _quantity);
    } else {
      Get.snackbar("Item Count", "You should at least add 1 item to the cart",
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
    }
  }
}
