// single columns in the heatmap representing the week
import 'package:flutter/material.dart';
import 'package:scapia/presentation/heatmap/hm_box.dart';
import 'package:scapia/utils/date.dart';
import 'package:scapia/utils/extensions.dart';

class HmCol extends StatelessWidget {
  const HmCol({
    super.key,
    required this.numDays,
    required this.aggregateData,
    required this.firstDate,
    required this.endDate,
    required this.maxValue,
    this.defaultColor = Colors.orange,
    this.onTap,
  });

  final int numDays;
  final Map<DateTime, double> aggregateData;
  final DateTime firstDate;
  final DateTime endDate;
  final Color defaultColor;
  final Function(DateTime)? onTap;
  final double maxValue;

  @override
  Widget build(BuildContext context) {
    // creating a block for each date in the week
    List<Widget> dayBox() {
      return List.generate(
        numDays,
        (index) {
          // finding the current date by using the first date of the week and the index
          DateTime currentDate = CustomDateUtils.changeDay(firstDate, index);

          // finding the daily total transaction value from the aggregated data
          double dailyTotal = aggregateData[currentDate] ?? 1;

          return HmBox(
            onTap: dailyTotal == 1 ? null : () => onTap?.call(currentDate),
            showBorder: true,

            // setting the opacity based on the [daily total transaction] and [max value]
            boxColor: aggregateData.containsKey(currentDate)
                ? defaultColor.withOpacity(dailyTotal / maxValue)
                : defaultColor.withOpacity(0),
          );
        },
      ).addSeparator(5.whitespaceHeight);
    }

    // if the numDays != 7, meaning the dates not in our range (current date - a year back). Any date apart from this range will be a blank box
    List emptyBox() {
      return (numDays != 7)
          ? List.generate(
              7 - numDays,
              (index) => const SizedBox(
                height: 20,
                width: 20,
              ),
            ).addSeparator(5.whitespaceHeight)
          : [];
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
