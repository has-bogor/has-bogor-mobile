class Payment {
  final int id;
  final String productName;
  final String status;
  final double amount;
  final double totalPayment;
  final String paymentMethod;
  final String createdAt;

  Payment({
    required this.id,
    required this.productName,
    required this.status,
    required this.amount,
    required this.totalPayment,
    required this.paymentMethod,
    required this.createdAt,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json['id'],
      productName: json['product_name'],
      status: json['status'],
      amount: json['amount'].toDouble(),
      totalPayment: json['total_payment'].toDouble(),
      paymentMethod: json['payment_method'],
      createdAt: json['created_at'],
    );
  }
}