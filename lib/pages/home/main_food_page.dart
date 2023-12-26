import 'package:ecommerce_flutter/pages/detail/popular_food_detail.dart';
import 'package:ecommerce_flutter/pages/home/food_body_page.dart';
import 'package:ecommerce_flutter/utils/colors.dart';
import 'package:ecommerce_flutter/widgets/big_text.dart';
import 'package:ecommerce_flutter/widgets/small_text.dart';
import 'package:flutter/material.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({super.key});

  @override
  State<StatefulWidget> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    print("Current height is " + MediaQuery.of(context).size.height.toString() + "width is" +
        MediaQuery.of(context).size.width.toString());

    return Scaffold(
      body: Column(
        children: [
          Container(

            child: Container(
              margin: EdgeInsets.only(top: 45, bottom: 15),
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      BigText(text: "Bangladesh",color: AppColors.mainColor),
                      Row(
                        children: [
                          SmallText(text: "Narsingdi", ),
                          Icon(Icons.arrow_drop_down_rounded)
                        ],
                      )


                    ],
                  ),

                  Center(
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: AppColors.mainColor
                      ),
                      child: Icon(Icons.search, color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(child: SingleChildScrollView(
              child: FoodPageBody())
          )
        ],
      ),
    );
  }
}
