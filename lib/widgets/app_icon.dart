import 'package:ecommerce_flutter/utils/dimensions.dart';
import 'package:flutter/cupertino.dart';

class AppIcon extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final double size;
  final double iconSize;
  final Color iconColor;

  AppIcon({super.key,
    required this.icon,
    this.backgroundColor = const Color (0xFFfcf4e4),
    this.size = 40,
    this.iconSize = 16,
    this.iconColor = const Color(0xFF756d54)});


  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,

      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size / 2),
          color: backgroundColor
      ),
      child: Icon(
          icon,
          color: iconColor,
          size: Dimensions.iconSize16),
    );
  }
}
