// the main heatmap
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:scapia/presentation/hm_column.dart';
import 'package:scapia/presentation/week_month_labels.dart';
import 'package:scapia/transaction_model.dart';
import 'package:scapia/utils/date.dart';
import 'package:scapia/utils/extensions.dart';

class HmComponent extends StatelessWidget {
  const HmComponent({super.key, required this.datasets});
  final List<TransactionModel>? datasets;

  @override
  Widget build(BuildContext context) {
    final DateTime endDate = DateTime.now();
    final DateTime startDate = CustomDateUtils().oneYearBefore(endDate);
    final int dateDif = endDate.difference(startDate).inDays;

    final List<int> firstDayOfMonth = [];

    // converting the data [List<TransactionModel>] into an aggregated dataset[Map<DateTime, double>].
    //key = DateTime and value = total spending on that day
    // total spending = debit + credit
    Map<DateTime, double> getAggregateData() {
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

    // finding the max spendings from the aggregated data - based on which the opacity of the block will be adjusted
    double findMaxValue(Map<DateTime, double> dailyTotals) {
      return dailyTotals.isNotEmpty
          ? dailyTotals.values.reduce((a, b) => a > b ? a : b)
          : 1.0;
    }

    // the main grid which forms the heatmap
    List<Widget> hmGrid() {
      List<Widget> children = [];

      final Map<DateTime, double> data = getAggregateData();
      final double maxValue = findMaxValue(data);

      // iterating over all the days in the range [startDate - endDate]
      // incrementing the loop with 7 (number of days in a week) to create a column of the heatmap
      for (int i = 0 - (startDate.weekday % 7); i <= dateDif; i += 7) {
        DateTime firstDay = CustomDateUtils.changeDay(startDate, i);

        children.add(
          HmCol(
              numDays: min(endDate.difference(firstDay).inDays + 1, 7),
              aggregateData: data,
              maxValue: maxValue,
              firstDate: firstDay,
              endDate: endDate,
              defaultColor: Colors.orange,
              onTap: (p0) {
                return showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text(
                            CustomDateUtils.getReadableDate(p0),
                          ),
                        ));
              }),
        );

        // adding the first day of the month, to add the month tag at the right place
        firstDayOfMonth.add(firstDay.month);
      }

      return children;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // month label
        HmMonthLabels(firstDayInfos: firstDayOfMonth),

        10.whitespaceHeight,

        // hm grid
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: hmGrid().addSeparator(5.whitespaceWidth),
        )
      ],
    );
  }
}
