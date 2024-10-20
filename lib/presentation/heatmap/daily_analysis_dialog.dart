import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scapia/bloc/transaction/transaction_cubit.dart';
import 'package:scapia/presentation/heatmap/transaction_history.dart';
import 'package:scapia/presentation/typography/text_style.dart';
import 'package:scapia/presentation/widgets/amout_display_test.dart';
import 'package:scapia/presentation/widgets/title_child_container.dart';
import 'package:scapia/utils/date.dart';
import 'package:scapia/utils/extensions.dart';
import 'package:scapia/utils/size_constants.dart';

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
