// color guide indicating the colors used in the heatmap
import 'package:flutter/material.dart';
import 'package:scapia/presentation/hm_box.dart';
import 'package:scapia/utils/extensions.dart';

class ColorToolTip extends StatelessWidget {
  const ColorToolTip({
    super.key,
    required this.defaultColor,
    this.minText,
    this.maxText,
  });
  final Color? defaultColor;
  final String? minText;
  final String? maxText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _textDisplay(minText ?? 'less spendings'),
        10.whitespaceWidth,

        // color guide range [min - max]
        ..._colorContainer(),

        10.whitespaceWidth,

        _textDisplay(maxText ?? "more spendings")
      ],
    );
  }

  Text _textDisplay(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 10,
      ),
    );
  }

  // by default i assume to have 3 sections of color range. [min, avg, max]
  // this method generates a List of 3 containers changing their color based on opacity
  List<Widget> _colorContainer() {
    List<Widget> children = [];
    for (int i = 0; i < 7; i++) {
      children.add(
        HmBox(
          boxDimension: 15.0,
          boxColor: defaultColor?.withOpacity(i / 7),
        ),
      );
    }
    return children;
  }
}
