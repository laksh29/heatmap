// the main heatmap
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scapia/bloc/transaction/transaction_cubit.dart';
import 'package:scapia/models/transaction_model.dart';
import 'package:scapia/presentation/heatmap/hm_column.dart';
import 'package:scapia/presentation/heatmap/week_month_labels.dart';
import 'package:scapia/presentation/typography/text_style.dart';
import 'package:scapia/utils/date.dart';
import 'package:scapia/utils/extensions.dart';
import 'package:scapia/utils/size_constants.dart';

class HmComponent extends StatelessWidget {
  const HmComponent({
    super.key,
    required this.datasets,
    this.showYearly = false,
  });
  final List<TransactionModel>? datasets;
  final bool showYearly;

  @override
  Widget build(BuildContext context) {
    final DateTime endDate = DateTime.now();
    final DateTime startDate = showYearly
        ? CustomDateUtils().oneYearBefore(endDate)
        : DateTime(endDate.year, endDate.month);
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
                BlocProvider.of<TransactionCubit>(context)
                    .filterDailyTransactions(p0);
                return showDialog(
                  context: context,
                  builder: (context) => TransactionListDialog(
                    currentDate: p0,
                  ),
                );
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
        HmMonthLabels(
          firstDayInfos: firstDayOfMonth,
          startDate: startDate,
          showYearly: showYearly,
        ),

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

class TransactionListDialog extends StatelessWidget {
  const TransactionListDialog({
    super.key,
    required this.currentDate,
  });
  final DateTime currentDate;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        height: SizeConfig.screenHeight! / 2.3,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // header - date and collapse icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Date: ${CustomDateUtils.getReadableDate(currentDate)}",
                  style: EzTextStyle.title.large,
                ),
                InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(Icons.close),
                )
              ],
            ),

            10.whitespaceHeight,

            //  displaying the total credit and debit amount of the selected date
            BlocBuilder<TransactionCubit, TransactionState>(
              builder: (context, state) {
                return Row(
                  children: [
                    TitleChildContainer(
                      title: "Total Credit",
                      textColor: Colors.white,
                      child: (state is TransactionFiltered)
                          ? AmountDislayText(
                              amount: state.totalCredit,
                              textColor: Colors.white,
                            )
                          : (state is TransactionFilterError)
                              ? Text(
                                  state.errorMsg,
                                  style: EzTextStyle.label.small,
                                )
                              : const CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                    ),
                    10.whitespaceWidth,
                    TitleChildContainer(
                      title: "Total Debit",
                      hasBorder: true,
                      isFilled: false,
                      child: (state is TransactionFiltered)
                          ? AmountDislayText(
                              amount: state.totalDebit,
                            )
                          : (state is TransactionFilterError)
                              ? Text(
                                  state.errorMsg,
                                  style: EzTextStyle.label.small,
                                )
                              : const CircularProgressIndicator(),
                    ),
                  ],
                );
              },
            ),

            30.whitespaceHeight,

            // show transaction history of that day
            Text(
              "Transaction History:",
              style: EzTextStyle.title.large,
            ),
            10.whitespaceHeight,
            BlocBuilder<TransactionCubit, TransactionState>(
              builder: (context, state) {
                return Flexible(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: TransactionHistory(
                      filteredData: state is TransactionFiltered
                          ? state.transactionData
                          : [],
                      isLoading: state is TransactionLoading,
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class TransactionHistory extends StatelessWidget {
  const TransactionHistory({
    super.key,
    required this.filteredData,
    this.isLoading = false,
  });
  final List<TransactionModel> filteredData;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return CircularProgressIndicator(
        color: Colors.blue[900],
      );
    } else {
      return SingleChildScrollView(
        child: Column(
          children: List.generate(filteredData.length, (index) {
            final TransactionModel data = filteredData.elementAt(index);
            return Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(
                  color: Colors.black26,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.note ?? "",
                        style: EzTextStyle.label.medium
                            .copyWith(overflow: TextOverflow.ellipsis),
                      ),
                      Text(
                        CustomDateUtils.getReadableDate(data.transactionAt),
                        style: EzTextStyle.title.smallRegular,
                      )
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "₹${data.amount}",
                        style: EzTextStyle.label.small,
                      ),
                      Text(
                        data.transactionType.name,
                        style: EzTextStyle.title.smallRegular,
                      )
                    ],
                  )
                ],
              ),
            );
          }).addSeparator(10.whitespaceHeight),
        ),
      );
    }
  }
}

class AmountDislayText extends StatelessWidget {
  const AmountDislayText({
    super.key,
    required this.amount,
    this.textColor,
  });
  final String amount;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "₹ ",
        style: EzTextStyle.title.mediumRegular.copyWith(color: textColor),
        children: [
          TextSpan(
            text: amount,
            style: EzTextStyle.headline.small.copyWith(color: textColor),
          )
        ],
      ),
    );
  }
}

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
