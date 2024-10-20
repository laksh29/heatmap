import 'package:flutter/material.dart';
import 'package:scapia/models/transaction_model.dart';
import 'package:scapia/presentation/typography/text_style.dart';
import 'package:scapia/presentation/widgets/amout_display_test.dart';
import 'package:scapia/utils/date.dart';
import 'package:scapia/utils/extensions.dart';

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
                        CustomDateUtils.getReadableTime(data.transactionAt),
                        style: EzTextStyle.title.smallRegular,
                      )
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      AmountDislayText(
                        amount: data.amount.toString(),
                        textStyle: EzTextStyle.label.small,
                      ),
                      Text(
                        data.transactionType.name,
                        style: EzTextStyle.title.smallRegular.copyWith(
                          color: data.transactionType == TransactionType.credit
                              ? Colors.green
                              : Colors.red,
                        ),
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
