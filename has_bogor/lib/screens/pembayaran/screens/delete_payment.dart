import 'package:flutter/material.dart';

class DeletePaymentScreen extends StatelessWidget {
  final String paymentId;

  DeletePaymentScreen({required this.paymentId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hapus Pembayaran"),
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Apakah Anda yakin ingin menghapus pembayaran ini?",
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Handle deletion of payment
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Pembayaran dihapus')));
                Navigator.pop(context);
              },
              child: Text("Ya, Hapus"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Back to previous screen
              },
              child: Text("Batal"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
