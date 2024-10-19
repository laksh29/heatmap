import 'package:flutter/material.dart';
import 'package:scapia/models/transaction_model.dart';
import 'package:scapia/presentation/typography/text_style.dart';
import 'package:scapia/screens/hm_page.dart';
import 'package:scapia/services/dataset.dart';
import 'package:scapia/utils/size_constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<TransactionModel> getData() {
      List<TransactionModel> data = [];

      for (var x in transactionDummy) {
        data.add(TransactionModel.fromMap(x));
      }

      return data;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tansaction Analysis",
          style: EzTextStyle.headline.medium,
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: SizeConst.pagePadding,
        child: Column(
          children: [
            Heatmap(
              datasets: getData(),
            ),
          ],
        ),
      ),
    );
  }
}
