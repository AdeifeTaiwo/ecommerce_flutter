import 'package:ecommerce_flutter/data/api/api_client.dart';
import 'package:ecommerce_flutter/utils/app_constants.dart';
import 'package:get/get.dart';

//to talk to the internet service
class PopularProductRepo extends GetxService {

  final ApiClient apiClient;

  PopularProductRepo({required this.apiClient});

  Future<Response> getPopularProductList() async {
    return apiClient.getData(AppConstants.POPULAR_PRODUCT_URL);
  }

}