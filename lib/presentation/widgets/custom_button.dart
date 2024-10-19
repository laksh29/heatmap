import 'package:flutter/material.dart';
import 'package:scapia/presentation/typography/text_style.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.ctaText,
    this.onTap,
  });
  final String ctaText;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Center(
          child: Text(
            ctaText,
            style: EzTextStyle.title.medium,
          ),
        ),
      ),
    );
  }
}
