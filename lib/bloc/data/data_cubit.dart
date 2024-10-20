import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scapia/models/transaction_model.dart';
import 'package:scapia/repositories/data_repo.dart';

part 'data_state.dart';

class DataCubit extends Cubit<DataState> {
  DataCubit() : super(DataInitial());

  Future getData() async {
    try {
      // fetching the data from the repo
      emit(DataLoading());
      List<TransactionModel> data = await DataRepo().fetchData();
      emit(DataSuccess(data: data));
    } catch (e) {
      // in case of any error getting the data from the repo, emitting error state
      emit(DataFailure(errorMsg: e.toString()));
    }
  }
}
