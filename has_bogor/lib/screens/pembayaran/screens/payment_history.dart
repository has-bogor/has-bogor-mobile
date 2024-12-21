import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:has_bogor/screens/pembayaran/services/payment_controller.dart';
import 'package:has_bogor/screens/pembayaran/models/models.dart';

class PaymentHistoryScreen extends StatefulWidget {
  const PaymentHistoryScreen({Key? key}) : super(key: key);

  @override
  _PaymentHistoryScreenState createState() => _PaymentHistoryScreenState();
}

class _PaymentHistoryScreenState extends State<PaymentHistoryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PaymentController>().fetchPayments();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Riwayat Pembayaran"),
      ),
      body: Consumer<PaymentController>(
        builder: (context, paymentController, child) {
          if (paymentController.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (paymentController.payments.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Belum ada transaksi'),
                  ElevatedButton(
                    onPressed: () => paymentController.fetchPayments(),
                    child: Text('Refresh'),
                  ),
                ],
              ),
            );
          } else {
            return ListView.builder(
              itemCount: paymentController.payments.length,
              itemBuilder: (context, index) {
                final payment = paymentController.payments[index];
                return ListTile(
                  title: Text(payment.productName),
                  subtitle: Text('${payment.status} - ${payment.createdAt}'),
                  trailing: Text('Rp ${payment.totalPayment}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}