class Transaction {
  int id;
  String title;
  double value;
  DateTime date;

  Transaction({
    required this.id,
    required this.title,
    required this.value,
    required this.date,
  });

  transactionMap() {
    var mapping = Map();
    mapping['id'] = id;
    mapping['title'] = title;
    mapping['value'] = value;
    mapping['date'] = date.toIso8601String();
    return mapping;
  }
}
