import 'package:flutter/material.dart';
import 'package:scapia/presentation/typography/text_style.dart';
import 'package:scapia/utils/size_constants.dart';

class TitleChildContainer extends StatelessWidget {
  const TitleChildContainer({
    super.key,
    required this.title,
    required this.child,
    this.isFilled = true,
    this.hasBorder = false,
    this.boxColor,
    this.textColor,
  });

  final String title;
  final Widget child;
  final bool isFilled;
  final bool hasBorder;
  final Color? boxColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 12.0,
      ),
      width: SizeConfig.screenWidth! / 3,
      decoration: BoxDecoration(
        color: isFilled
            ? boxColor ?? const Color.fromARGB(255, 13, 71, 161)
            : null,
        borderRadius: BorderRadius.circular(5.0),
        border: hasBorder
            ? Border.all(
                color: boxColor ?? const Color.fromARGB(255, 13, 71, 161),
              )
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: EzTextStyle.title.smallRegular.copyWith(color: textColor),
          ),
          // 5.whitespaceHeight,
          child,
        ],
      ),
    );
  }
}
