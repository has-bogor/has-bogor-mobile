import 'package:flutter/material.dart';

class PaymentMethodDropdown extends StatelessWidget {
  final List<String> paymentMethods = ['Bank Transfer', 'Credit Card', 'E-Wallet'];
  final ValueChanged<String?> onChanged;

  PaymentMethodDropdown({required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      hint: Text('Pilih Metode Pembayaran'),
      items: paymentMethods.map((String method) {
        return DropdownMenuItem<String>(
          value: method,
          child: Text(method),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
