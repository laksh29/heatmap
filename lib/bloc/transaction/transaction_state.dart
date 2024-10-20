part of 'transaction_cubit.dart';

sealed class TransactionState {}

final class TransactionLoading extends TransactionState {}

final class TransactionFiltered extends TransactionState {
  final List<TransactionModel> transactionData;
  final String totalCredit;
  final String totalDebit;

  TransactionFiltered({
    required this.transactionData,
    required this.totalCredit,
    required this.totalDebit,
  });
}

final class TransactionFilterError extends TransactionState {
  final String errorMsg;

  TransactionFilterError({required this.errorMsg});
}
