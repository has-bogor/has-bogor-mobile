class Payment {
  final int id;
  final String productName;
  final String status;
  final String paymentMethod;
  final int amount;
  final int totalPayment;
  final DateTime createdAt;

  Payment({
    required this.id,
    required this.productName,
    required this.status,
    required this.paymentMethod,
    required this.amount,
    required this.totalPayment,
    required this.createdAt,
  });

  // Fungsi untuk membuat objek Payment dari JSON
  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json['id'],
      productName: json['product_name'],  // Ganti dengan nama produk dari response API
      status: json['status'],
      paymentMethod: json['payment_method'],
      amount: json['amount'],
      totalPayment: json['total_payment'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}