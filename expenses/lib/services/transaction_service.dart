import '../models/repository.dart';
import '../models/transaction.dart';

class TransactionService {
  late Repository _repository;
  TransactionService() {
    _repository = Repository();
  }
  //Save Transaction
  saveTransaction(Transaction transaction) async {
    print(
        "Testando | saveTransaction $transaction ${transaction.transactionMap()}");
    return await _repository.insertData(
        'transactions', transaction.transactionMap());
  }

  //Read All Transactions
  readAllTransactions() async {
    return await _repository.readData('transactions');
  }

  //Read All Transactions
  readSingleTransaction(int id) async {
    return await _repository.readDataById('transactions', id);
  }

  //Edit Transaction
  updateTransaction(Transaction transaction) async {
    return await _repository.updateData(
        'transactions', transaction.transactionMap());
  }

  deleteTransaction(transactionId) async {
    return await _repository.deleteDataById('transactions', transactionId);
  }
}
