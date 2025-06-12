class Stock {
  final double quantity;

  const Stock({required this.quantity});

  Map<String, dynamic> toMap() {
    return {
      'quantity': this.quantity,
    };
  }

  factory Stock.fromMap(Map<String, dynamic> map) {
    return Stock(
      quantity: map['quantity'] as double,
    );
  }

  @override
  String toString() {
    return 'Store{quantity: $quantity}';
  }
}