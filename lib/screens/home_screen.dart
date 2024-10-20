import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scapia/bloc/data/data_cubit.dart';
import 'package:scapia/models/transaction_model.dart';
import 'package:scapia/presentation/typography/text_style.dart';
import 'package:scapia/screens/hm_page.dart';
import 'package:scapia/services/dataset.dart';
import 'package:scapia/utils/extensions.dart';
import 'package:scapia/utils/size_constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showYearly = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero)
        .then((_) => BlocProvider.of<DataCubit>(context).getData());
  }

  List<TransactionModel> getData() {
    List<TransactionModel> data = [];

    for (var x in transactionDummy) {
      data.add(TransactionModel.fromMap(x));
    }

    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tansaction Analysis",
          style: EzTextStyle.headline.medium,
        ),
        centerTitle: false,
      ),
      body: BlocBuilder<DataCubit, DataState>(
        builder: (context, state) {
          if (state is DataSuccess) {
            return SingleChildScrollView(
              padding: SizeConst.pagePadding,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Yearly transaction view:",
                          style: EzTextStyle.label.small),
                      CupertinoSwitch(
                        value: showYearly,
                        onChanged: (val) => setState(() {
                          showYearly = val;
                        }),
                      ),
                    ],
                  ),
                  20.whitespaceHeight,
                  Heatmap(
                    datasets: getData(),
                    showYearly: showYearly,
                  ),
                ],
              ),
            );
          } else if (state is DataFailure) {
            return Center(
              child: Container(
                color: Colors.blue[900],
                child: Text(
                  state.errorMsg,
                  style: EzTextStyle.body.medium,
                ),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(
              color: Colors.blue[900],
            ),
          );
        },
      ),
    );
  }
}
