import 'dart:developer' as dev;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:scapia/transaction_model.dart';
import 'package:scapia/utils/date.dart';
import 'package:scapia/utils/extensions.dart';

class Heatmap extends StatelessWidget {
  const Heatmap({
    super.key,
    this.datasets,
  });
  final List<TransactionModel>? datasets;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // scrollable heat map
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          // reverse: true,
          child: HmComponent(
            datasets: datasets,
          ),
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

// I have wrapped the MapContainer over MapContainer because, the boxColor depends on the opacity, and if we have a color bg, the color of the box will not be as expected
class HmBox extends StatelessWidget {
  const HmBox({
    super.key,
    this.boxColor,
    this.showBorder = false,
    this.boxDimension,
    this.onTap,
  });
  final Color? boxColor;
  final bool showBorder;
  final double? boxDimension;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: MapContainer(
        boxDimension: boxDimension,
        boxColor: Colors.transparent,
        showBorder: showBorder,
        child: MapContainer(
          boxDimension: boxDimension,
          boxColor: boxColor,
        ),
      ),
    );
  }
}

// basic container design that will be used in the HM and in the color guide
class MapContainer extends StatelessWidget {
  const MapContainer({
    super.key,
    required this.boxColor,
    this.child,
    this.showBorder = false,
    this.boxDimension,
  });

  final Color? boxColor;
  final Widget? child;
  final bool showBorder;
  final double? boxDimension;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: boxDimension ?? 20.0,
      height: boxDimension ?? 20.0,
      decoration: BoxDecoration(
        color: boxColor ?? Colors.white,
        borderRadius: BorderRadius.circular(2.0),
        border: showBorder
            ? Border.all(color: Colors.black.withOpacity(0.1))
            : null,
      ),
      child: child,
    );
  }
}

class HmComponent extends StatelessWidget {
  const HmComponent({super.key, required this.datasets});
  final List<TransactionModel>? datasets;

  @override
  Widget build(BuildContext context) {
    final DateTime endDate = DateTime.now();
    final DateTime startDate = CustomDateUtils().oneYearBefore(endDate);
    final int dateDif = endDate.difference(startDate).inDays;

    final List<int> firstDayOfMonth = [];

    List<Widget> hmGrid() {
      List<Widget> children = [];

      for (int i = 0 - (startDate.weekday % 7); i <= dateDif; i += 7) {
        DateTime firstDay = CustomDateUtils.changeDay(startDate, i);

        children.add(
          HmCol(
            numDays: min(endDate.difference(firstDay).inDays, 7),
            datasets: datasets,
            startDate: firstDay,
            endDate: endDate,
            defaultColor: Colors.orange,
            onTap: (p0) => showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: Text(
                        CustomDateUtils.getDate(p0),
                      ),
                    )),
          ),
        );

        firstDayOfMonth.add(firstDay.month);
      }
      dev.log("first day of month: $firstDayOfMonth");

      return children;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
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
    this.datasets,
    required this.startDate,
    required this.endDate,
    this.defaultColor = Colors.orange,
    this.onTap,
  });

  final int numDays;
  final List<TransactionModel>? datasets;
  final DateTime startDate;
  final DateTime endDate;
  final Color defaultColor;
  final Function(DateTime)? onTap;

  @override
  Widget build(BuildContext context) {
    double findMaxValue(Map<DateTime, double> dailyTotals) {
      return dailyTotals.isNotEmpty
          ? dailyTotals.values.reduce((a, b) => a > b ? a : b)
          : 1.0;
    }

    Map<DateTime, double> aggregateTransactions() {
      Map<DateTime, double> dailyTotals = {};

      for (var transaction in datasets!) {
        DateTime day = DateTime(transaction.transactionAt.year,
            transaction.transactionAt.month, transaction.transactionAt.day);

        if (dailyTotals.containsKey(day)) {
          dailyTotals[day] = dailyTotals[day]! + transaction.amount;
        } else {
          dailyTotals[day] = transaction.amount;
        }
      }

      return dailyTotals;
    }

    List<Widget> dayBox() {
      final aggregateData = aggregateTransactions();
      final maxValue = findMaxValue(aggregateData);

      dev.log("end date : ${endDate.toString()}");

      return List.generate(
        numDays,
        (index) {
          bool hasData = aggregateData.keys.contains(DateTime(startDate.year,
              startDate.month, startDate.day - startDate.weekday % 7 + index));

          double dailyTotal = aggregateData[DateTime(
                  startDate.year,
                  startDate.month,
                  startDate.day + index - (startDate.weekday % 7))] ??
              1;

          // dev.log(hasData
          //     ? "${CustomDateUtils.changeDay(startDate, index)} - $dailyTotal"
          //     : "no data");

          return HmBox(
            onTap: () {
              onTap != null
                  ? onTap!(CustomDateUtils.changeDay(startDate, index + 1))
                  : null;
            },
            showBorder: true,
            boxColor: hasData
                ? defaultColor.withOpacity(dailyTotal / maxValue)
                : defaultColor.withOpacity(0),
          );
        },
      ).addSeparator(5.whitespaceHeight);
    }

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
5. create a dataset - done
6. add colors to respective boxes - done
7. onTap show a dialog box with details - partial done

---
generate the aggregated date in HmComponent and pass it to the HmCol, so that the aggregated value can be used in the dialog box
 */
