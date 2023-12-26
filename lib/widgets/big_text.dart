import 'package:ecommerce_flutter/utils/dimensions.dart';
import 'package:flutter/cupertino.dart';

class BigText extends StatelessWidget {
  final Color? color;
  final String text;
  double size;
  final TextOverflow overflow;

  BigText({super.key,
    this.color = const Color(0xFF332d2b),
    required this.text,
    this.overflow = TextOverflow.ellipsis,
    this.size = 0
  });


  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      style: TextStyle(
          color: color,
          fontWeight: FontWeight.w400,
          fontFamily: "Roboto",
          fontSize: size == 0 ? Dimensions.font20 : size
      ),

    );
  }

}