import 'dart:developer' as dev;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:scapia/utils/date.dart';
import 'package:scapia/utils/extensions.dart';

class Heatmap extends StatelessWidget {
  const Heatmap({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // scrollable heat map
        const SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          // reverse: true,
          child: HmComponent(),
        ),

        20.whitespaceHeight,

        // color guide
        const ColorToolTip(defaultColor: Colors.orange)
      ],
    );
  }
}

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
    for (int i = 0; i < 3; i++) {
      children.add(
        HmBox(
          boxColor: defaultColor?.withOpacity(i / 3),
        ),
      );
    }
    return children;
  }
}

// I have wrapped the MapContainer over MapContainer because, the boxColor depends on the opacity, and if we have a color bg, the color of the box will not be as expected
class HmBox extends StatelessWidget {
  const HmBox({super.key, this.boxColor});
  final Color? boxColor;

  @override
  Widget build(BuildContext context) {
    return MapContainer(
      boxColor: Colors.white,
      child: MapContainer(boxColor: boxColor),
    );
  }
}

// basic container design that will be used in the HM and in the color guide
class MapContainer extends StatelessWidget {
  const MapContainer({
    super.key,
    required this.boxColor,
    this.child,
  });

  final Color? boxColor;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: boxColor ?? Colors.white,
        borderRadius: BorderRadius.circular(2.0),
      ),
      child: child,
    );
  }
}

class HmComponent extends StatelessWidget {
  const HmComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final DateTime endDate = DateTime.now();
    final DateTime startDate = CustomDateUtils().oneYearBefore(endDate);
    final int dateDif = endDate.difference(startDate).inDays;

    final List<int> firstDayOfMonth = [];

    List<Widget> hmGrid() {
      List<Widget> children = [];

      for (int i = 0 - (startDate.weekday % 7); i <= dateDif; i += 7) {
        DateTime firstDay = CustomDateUtils().changeDay(startDate, i);

        children.add(
          HmCol(
            numDays: min(endDate.difference(firstDay).inDays, 7),
          ),
        );

        firstDayOfMonth.add(firstDay.month);
      }
      dev.log("first day of month: $firstDayOfMonth");

      return children;
    }

    return Row(
      children: [
        // week labels
        const WeekLabels(),

        10.whitespaceWidth,

        // column for month label and the HM grid
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // month label
            HmMonthText(firstDayInfos: firstDayOfMonth),

            10.whitespaceHeight,

            // hm grid
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: hmGrid().addSeparator(5.whitespaceWidth),
            )
          ],
        ),
      ],
    );
  }
}

class WeekLabels extends StatelessWidget {
  const WeekLabels({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var week in CustomDateUtils.week)
          SizedBox(
            height: 20,
            child: Text(
              week,
              style: const TextStyle(
                fontSize: 12.0,
                color: Colors.black,
              ),
            ),
          ),
      ].addSeparator(5.whitespaceHeight),
    );
  }
}

class HmCol extends StatelessWidget {
  const HmCol({
    super.key,
    required this.numDays,
  });
  final int numDays;

  @override
  Widget build(BuildContext context) {
    List<Widget> dayBox() {
      List<Widget> col = List.generate(numDays, (index) => const HmBox());
      return col.addSeparator(5.whitespaceHeight);
    }

    List emptyBox() {
      List emptySpace = (numDays != 7)
          ? List.generate(
              7 - numDays,
              (index) => const SizedBox(
                height: 20,
                width: 20,
              ),
            )
          : [];

      return emptySpace;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ...dayBox(),
        ...emptyBox(),
      ],
    );
  }
}

class HmMonthText extends StatelessWidget {
  const HmMonthText({
    super.key,
    required this.firstDayInfos,
  });
  final List<int> firstDayInfos;

  @override
  Widget build(BuildContext context) {
    Widget textDisplay(String text) {
      return Text(
        text,
        style: const TextStyle(),
      );
    }

    List<Widget> monthLabels() {
      List<Widget> children = [];

      // if the previous week was the first week of the month, create label
      bool writeLabel = false;

      for (int label = 0; label < (firstDayInfos.length); label++) {
        // if given week is first week of the dataset or first week of the month, create a label
        if (label == 0 ||
            (label > 0 && firstDayInfos[label] != firstDayInfos[label - 1])) {
          writeLabel = true;

          children.add(
            firstDayInfos.length == 1 ||
                    (label == 0 &&
                        firstDayInfos[label] != firstDayInfos[label + 1])
                ? textDisplay(CustomDateUtils.month[firstDayInfos[label] - 1])
                : Container(
                    margin: const EdgeInsets.symmetric(horizontal: 2.0),
                    width: (20 + 2) * 2,
                    child: textDisplay(
                      CustomDateUtils.month[firstDayInfos[label] - 1],
                    ),
                  ),
          );
        } else if (writeLabel) {
          // if the week is any other week than consisting of the first day, do not label
          writeLabel = false;
        } else {
          // else create empty boxes
          children.add(Container(
            margin: const EdgeInsets.only(left: 5.0),
            width: 20,
          ));
        }
      }
      return children;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: monthLabels(),
    );
  }
}

/*
TODO: following
1. const colors
2. box sizes 
3. all paddings and margins
4. all texts
5. create a dataset
6. add colors to respective boxes
7. onTap show a dialog box with details
 */
