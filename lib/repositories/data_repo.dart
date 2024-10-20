import 'package:scapia/models/transaction_model.dart';
import 'package:scapia/services/dataset.dart';

class DataRepo {
  Future<List<TransactionModel>> fetchData() async {
    List<Map<String, dynamic>>? resp =
        await Future.delayed(const Duration(seconds: 3))
            .then((_) => transactionDummy);

    List<TransactionModel> listOfTransaction = [];
    if (resp != null) {
      for (var data in resp) {
        listOfTransaction.add(TransactionModel.fromMap(data));
      }
    }

    return listOfTransaction;
  }
}
