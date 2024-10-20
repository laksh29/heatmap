part of 'data_cubit.dart';

sealed class DataState {}

final class DataInitial extends DataState {}

final class DataLoading extends DataState {}

final class DataSuccess extends DataState {
  final List<TransactionModel> data;

  DataSuccess({required this.data});
}

final class DataFailure extends DataState {
  final String errorMsg;

  DataFailure({required this.errorMsg});
}
