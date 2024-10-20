import 'package:flutter/material.dart';
import 'package:scapia/models/transaction_model.dart';
import 'package:scapia/presentation/heatmap/hm_color_guide.dart';
import 'package:scapia/presentation/heatmap/hm_component.dart';
import 'package:scapia/presentation/heatmap/week_month_labels.dart';
import 'package:scapia/utils/extensions.dart';

// the main component that needs to be used. and where the data needs to be passed
class Heatmap extends StatelessWidget {
  const Heatmap({
    super.key,
    required this.datasets,
    this.showYearly = false,
  });
  final List<TransactionModel> datasets;
  final bool showYearly;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // scrollable heat map
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // weeks label
            const HmWeekLabels(),
            10.whitespaceWidth,

            // scrollable heat map - only the blocks are scrollable to ensure that at any point the weeks are visible and easy to track
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                reverse: true,
                child: HmComponent(
                  datasets: datasets,
                  showYearly: showYearly,
                ),
              ),
            ),
          ],
        ),
        20.whitespaceHeight,

        // color guide - to help understand what the shade on the heatmap represents
        const ColorToolTip(defaultColor: Colors.orange)
      ],
    );
  }
}
