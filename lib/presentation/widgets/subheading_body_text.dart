import 'package:flutter/material.dart';
import 'package:scapia/presentation/typography/text_style.dart';
import 'package:scapia/utils/extensions.dart';

class SubheadingBodyText extends StatelessWidget {
  const SubheadingBodyText({
    super.key,
    required this.subHeading,
    required this.body,
  });
  final String subHeading;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$subHeading :",
          style: EzTextStyle.title.large,
        ),
        5.whitespaceHeight,
        Text(
          body,
          style: EzTextStyle.body.largeRegular,
        ),
      ],
    );
  }
}
