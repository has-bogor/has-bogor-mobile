import 'package:flutter/material.dart';

class PaymentForm extends StatelessWidget {
  final TextEditingController amountController;
  final Function(String) onQuantityChanged; // Add this callback

  // Constructor to accept the controller and quantity change callback
  PaymentForm({
    Key? key,
    required this.amountController,
    required this.onQuantityChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: amountController,
          decoration: InputDecoration(labelText: "Jumlah"),
          keyboardType: TextInputType.number,
          onChanged: (value) {
            onQuantityChanged(value); // Call the callback when quantity changes
          },
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
