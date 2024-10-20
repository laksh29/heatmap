import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scapia/bloc/data/data_cubit.dart';
import 'package:scapia/models/transaction_model.dart';

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  final DataCubit dataCubit;

  TransactionCubit(this.dataCubit) : super(TransactionLoading());

  Future<void> filterDailyTransactions(DateTime currentDate) async {
    emit(TransactionLoading());

    try {
      // Access the data from DataCubit
      final currentState = dataCubit.state;
      if (currentState is DataSuccess) {
        // Get current date and filter transactions based on it
        final List<TransactionModel> filteredData =
            currentState.data.where((transaction) {
          return transaction.transactionAt.year == currentDate.year &&
              transaction.transactionAt.month == currentDate.month &&
              transaction.transactionAt.day == currentDate.day;
        }).toList();

        log("filtered data : $filteredData");

        // If there is filtered data, emit the TransactionFiltered state
        if (filteredData.isNotEmpty) {
          double totalCredit = 0;
          double totalDebit = 0;

          // loop over the filtered transactions to figure out total credit and total debit amounts
          for (var data in filteredData) {
            if (data.transactionType == TransactionType.credit) {
              totalCredit += data.amount;
            }
            if (data.transactionType == TransactionType.debit) {
              totalDebit += data.amount;
            }
          }
          emit(TransactionFiltered(
            transactionData: filteredData,
            totalCredit: totalCredit.toStringAsFixed(2),
            totalDebit: totalDebit.toStringAsFixed(2),
          ));
        } else {
          emit(TransactionFilterError(
              errorMsg: "No transactions found for today."));
        }
      } else {
        // Emit an error if DataCubit state is not ready
        emit(TransactionFilterError(
            errorMsg: "Failed to fetch data from DataCubit."));
      }
    } catch (e) {
      emit(TransactionFilterError(errorMsg: e.toString()));
    }
  }
}
