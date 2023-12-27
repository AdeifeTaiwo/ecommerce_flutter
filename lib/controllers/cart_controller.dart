import 'package:ecommerce_flutter/data/repository/cart_repository.dart';
import 'package:ecommerce_flutter/model/cart_model.dart';
import 'package:ecommerce_flutter/model/product_model.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class CartController extends GetxController {
  final CartRepository cartRepository;

  CartController({required this.cartRepository});

  //in cart controller wr need to create another model to take quantity, cart items, product id and ...
  //created a new Model
  Map<int, CartModel> _items = {};

  void addItems(ProductModel product, int quantity) {
    //to avoid saving duplicate we perform a check
    print("length of the item ${_items.length}");
    _items.putIfAbsent(
        product.id!,
        () {
          print("adding item to the cart id: ${product.id} quantity: ${quantity}");
          return CartModel(
              price: product.price!,
              img: product.img!,
              name: product.name!,
              quantity: quantity,
              time: DateTime.now().toString(),
              isExists: true,
            );
        }
    );
  }
}
