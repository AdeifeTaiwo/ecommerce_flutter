import 'package:dots_indicator/dots_indicator.dart';
import 'package:ecommerce_flutter/controllers/popular_product_controller.dart';
import 'package:ecommerce_flutter/controllers/recommended_product_controller.dart';
import 'package:ecommerce_flutter/model/product_model.dart';
import 'package:ecommerce_flutter/pages/detail/popular_food_detail.dart';
import 'package:ecommerce_flutter/route/route_helper.dart';
import 'package:ecommerce_flutter/utils/app_constants.dart';
import 'package:ecommerce_flutter/utils/colors.dart';
import 'package:ecommerce_flutter/utils/dimensions.dart';
import 'package:ecommerce_flutter/widgets/big_text.dart';
import 'package:ecommerce_flutter/widgets/icon_and_text.dart';
import 'package:ecommerce_flutter/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:get/get.dart";

class FoodPageBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController =
      PageController(initialPage: 0, viewportFraction: 0.85);
  var _currentPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = 220;

  //access page properrty from Page Controller
  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
        print("Current value is" + _currentPageValue.toString());
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Slider section
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return popularProducts.isLoaded
              ? Container(
                  height: Dimensions.pageView,
                  child: PageView.builder(
                      controller: pageController,
                      itemCount: popularProducts.popularProductList.length,
                      itemBuilder: (context, position) {
                        return _buildPageItem(position,
                            popularProducts.popularProductList[position]);
                      }))
              : Container(
                  child: CircularProgressIndicator(
                    color: AppColors.mainColor,
                  ),
                );
        }),

        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return DotsIndicator(
            dotsCount: popularProducts.popularProductList.isEmpty
                ? 1
                : popularProducts.popularProductList.length,
            position: _currentPageValue,
            decorator: DotsDecorator(
              activeColor: AppColors.mainColor,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          );
        }),

        //Popular Text
        SizedBox(height: Dimensions.height30),

        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              BigText(text: "Recommended"),
              SizedBox(width: Dimensions.width10),
              Container(
                margin: EdgeInsets.only(bottom: 3),
                child: BigText(
                  text: ".",
                  color: Colors.black26,
                ),
              ),
              SizedBox(width: Dimensions.width10),
              Container(
                margin: EdgeInsets.only(bottom: 3),
                child: const SmallText(text: "Food pairing"),
              )
            ],
          ),
        ),

        //list of food and images

        GetBuilder<RecommendedProductController>(builder: (recommendedProduct) {
          return recommendedProduct.isLoaded?
          ListView.builder(
              itemCount: recommendedProduct.recommendedProductList.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, position) {
                return Container(
                  margin: EdgeInsets.only(
                      left: Dimensions.width20, right: Dimensions.width20),
                  child: Row(
                    children: [
                      //image section
                      Container(
                        width: Dimensions.listViewImg,
                        height: Dimensions.listViewImg,
                        margin: EdgeInsets.only(bottom: 10, left: 10),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                            color: Colors.white30,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image:
                                    NetworkImage(AppConstants.BASE_URL +AppConstants.UPLOAD_URL + recommendedProduct.recommendedProductList[position]!.img)
                            )
                        ),
                      ),

                      //text container
                      Expanded(
                        child: Container(
                          height: Dimensions.listViewTextViewContSize,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight:
                                      Radius.circular(Dimensions.radius20),
                                  bottomRight:
                                      Radius.circular(Dimensions.radius20)),
                              color: Colors.white),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: Dimensions.width10,
                                right: Dimensions.width10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BigText(text: recommendedProduct.recommendedProductList[position].name!),
                                SmallText(text: recommendedProduct.recommendedProductList[position].description!),
                                Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const IconAndText(
                                          iconData: Icons.circle_sharp,
                                          text: "Normal",
                                          color: Colors.black,
                                          iconColor: AppColors.iconColor1),
                                      const IconAndText(
                                          iconData: Icons.location_on,
                                          text: "1.7 Km",
                                          color: Colors.black,
                                          iconColor: AppColors.mainColor),
                                      const IconAndText(
                                          iconData:
                                              Icons.access_time_filled_rounded,
                                          text: "32 min",
                                          color: Colors.black,
                                          iconColor: AppColors.iconColor2)
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }) : CircularProgressIndicator(color: AppColors.mainColor,);
        })
      ],
    );
  }

  Widget _buildPageItem(int index, ProductModel popularProduct) {
    Matrix4 matrix = Matrix4.identity();

    if (index == _currentPageValue.floor()) {
      var currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    }
    //to refer to the next slide
    else if (index == _currentPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currentPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currentPageValue.floor() - 1) {
      var currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    }

    //as we go to left or right, the position should change at thesame time

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: (){
              Get.toNamed(RouteHelper.getPopularFood(index));
            },
            child: Container(
              height: Dimensions.pageViewContainer,
              margin: const EdgeInsets.only(left: 5, right: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Color(0XFF69c5df),
                  image: DecorationImage(
                      image: NetworkImage(
                        AppConstants.BASE_URL + "/uploads/" + popularProduct.img!,
                      ),
                      fit: BoxFit.cover)),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextController,
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0XFFFFFFFF),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0XFFe8e8e8),
                        blurRadius: 5.0,
                        offset: Offset(0, 5)),
                    BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                    BoxShadow(color: Colors.white, offset: Offset(5, 0))
                  ]),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                //star with text
                child: AppColumn(
                  text: "Chinese Side",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListViewItem(int index) {
    return Container();
  }
}
