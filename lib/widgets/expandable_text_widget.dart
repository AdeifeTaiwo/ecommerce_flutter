import 'package:ecommerce_flutter/utils/colors.dart';
import 'package:ecommerce_flutter/utils/dimensions.dart';
import 'package:ecommerce_flutter/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  final String text;

  const ExpandableText({super.key, required this.text});

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  late String firstHalf;
  late String secondHalf;

  bool isTextHidden = true;
  double textHeight = Dimensions.screenHeight / 5.63;

  @override
  void initState() {
    super.initState();
    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  void toggleTextHiddenState() {
    setState(() {
      isTextHidden = !isTextHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: secondHalf.isEmpty
            ? SmallText(
                color: AppColors.paraColor,
                size: Dimensions.font16,
                text: firstHalf)
            : Column(children: [
                SmallText(
                  height: 1.8,
                  text: isTextHidden
                      ? (firstHalf + "...")
                      : (firstHalf + secondHalf),
                  size: Dimensions.font16,
                  color: AppColors.paraColor,
                  overflow: TextOverflow.visible,
                ),
                InkWell(
                  onTap: () {
                    toggleTextHiddenState();
                  },
                  child: Row(
                    children: [
                      SmallText(
                          height: 1.8,
                          text: isTextHidden ? "Show more!" : "Show less!",
                          color: AppColors.mainColor,
                          size: Dimensions.font16),
                      Icon(
                        isTextHidden
                            ? Icons.arrow_drop_down
                            : Icons.arrow_drop_up,
                        color: AppColors.mainColor,
                      )
                    ],
                  ),
                )
              ]));
  }
}
