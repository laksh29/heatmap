// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

enum TransactionType { credit, debit }

class TransactionModel {
  final TransactionType transactionType;
  final double amount;
  final DateTime transactionAt;
  final String? note;
  TransactionModel({
    required this.transactionType,
    required this.amount,
    required this.transactionAt,
    this.note,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'transactionType':
          transactionType == TransactionType.credit ? 'credit' : 'debit',
      'amount': amount,
      'transactionAt': transactionAt.millisecondsSinceEpoch,
      'note': note,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      transactionType: map['transaction_type'] == 'credit'
          ? TransactionType.credit
          : TransactionType.debit,
      amount: map['amount'] as double,
      transactionAt: DateTime.parse(map['transactionAt']),
      note: map['note'] != null ? map['note'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionModel.fromJson(String source) =>
      TransactionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TransactionModel(transactionType: $transactionType, amount: $amount, transactionAt: $transactionAt, note: $note)';
  }
}
