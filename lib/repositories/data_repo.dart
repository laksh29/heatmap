import 'dart:developer';

import 'package:scapia/models/transaction_model.dart';
import 'package:scapia/services/dataset.dart';

class DataRepo {
  Future<List<TransactionModel>> fetchData() async {
    try {
      // fetching the data from data service (API)
      // since it is a mock data, have used Future.delayed to represnt the delay in receiving response
      List<Map<String, dynamic>>? resp =
          await Future.delayed(const Duration(seconds: 3))
              .then((_) => transactionDummy);

      // checking if the resp is not null and converting the raw data to TransactionModel
      List<TransactionModel> listOfTransaction = [];
      if (resp != null) {
        for (var data in resp) {
          listOfTransaction.add(TransactionModel.fromMap(data));
        }
      }

      return listOfTransaction;
    } catch (e) {
      // in case of any error logging it
      log("ERROR data repo - fetch data : $e");
      rethrow;
    }
  }
}
