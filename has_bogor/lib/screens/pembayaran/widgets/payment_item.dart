import 'package:flutter/material.dart';

class PaymentItem extends StatelessWidget {
  final String id;
  final String product;
  final String status;
  final String amount;
  final String total;

  PaymentItem({required this.id, required this.product, required this.status, required this.amount, required this.total});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('ID: $id'),
        subtitle: Text('Produk: $product\nJumlah: $amount\nStatus: $status\nTotal: $total'),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            // Logic for deleting payment (could show confirmation dialog)
          },
        ),
      ),
    );
  }
}
