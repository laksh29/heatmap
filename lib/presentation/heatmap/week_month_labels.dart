// week lables before the heatmap
import 'package:flutter/material.dart';
import 'package:scapia/utils/date.dart';
import 'package:scapia/utils/extensions.dart';

class HmWeekLabels extends StatelessWidget {
  const HmWeekLabels({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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

// month lables above the heatmap
class HmMonthLabels extends StatelessWidget {
  const HmMonthLabels({
    super.key,
    required this.firstDayInfos,
    required this.startDate,
    this.showYearly = false,
  });
  final List<int> firstDayInfos;
  final DateTime startDate;
  final bool showYearly;

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
          // check if the first [firstDayInfos] month < cuxrrent month, then not displaying the month label
          if ((!showYearly && firstDayInfos[label] < startDate.month)) {
            writeLabel = false;
          } else {
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
          }
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
