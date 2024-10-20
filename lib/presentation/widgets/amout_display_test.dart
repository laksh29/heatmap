import 'package:flutter/material.dart';
import 'package:scapia/presentation/typography/text_style.dart';

class AmountDislayText extends StatelessWidget {
  const AmountDislayText({
    super.key,
    required this.amount,
    this.textColor,
    this.textStyle,
  });
  final String amount;
  final Color? textColor;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "₹ ",
        style: textStyle ??
            EzTextStyle.title.mediumRegular.copyWith(color: textColor),
        children: [
          TextSpan(
            text: amount,
            style: textStyle ??
                EzTextStyle.headline.small.copyWith(color: textColor),
          )
        ],
      ),
    );
  }
}
