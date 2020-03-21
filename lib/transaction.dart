import 'dart:ffi';

class Transaction{
  final String id;
  final String title;
  final Double amount;
  final DateTime date;

  Transaction({
    this.id,
    this.title,
    this.amount,
    this.date
  });

}