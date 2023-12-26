import 'package:ecommerce_flutter/utils/dimensions.dart';
import 'package:ecommerce_flutter/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';

class IconAndText extends StatelessWidget {
  final IconData iconData;
  final String text;
  final Color color;
  final Color iconColor;

  const IconAndText(
      {super.key,
      required this.iconData,
      required this.text,
      required this.color,
      required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Icon(iconData, color: iconColor, size: Dimensions.iconSize24,),
          const SizedBox(
            width: 5,
          ),
          SmallText(text: text, color: color)
        ],
      ),
    );
  }
}
