class Model {
  final String name;
  final String amount;

  Model({required this.name, required this.amount});

  factory Model.fromJson(Map<String, dynamic> json) =>
      Model(name: json['name'], amount: json['amount']);
}
